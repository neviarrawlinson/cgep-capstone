#!/usr/bin/env bash
# scripts/verify-evidence.sh <run_id> [--vault <bucket>] [--profile <profile>]

set -euo pipefail

RUN_ID="${1:?usage: verify-evidence.sh <run_id> [--vault <bucket>] [--profile <profile>]}"
shift || true

VAULT="${EVIDENCE_VAULT:-}"
AWS_ARGS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --vault)
      VAULT="$2"
      shift 2
      ;;
    --profile)
      AWS_ARGS+=(--profile "$2")
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ -z "$VAULT" ]]; then
  echo "Set --vault or EVIDENCE_VAULT"
  exit 2
fi

hash_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    echo "sha256sum or shasum is required" >&2
    exit 2
  fi
}

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
cd "$WORK"

PREFIX="runs/${RUN_ID}"

aws "${AWS_ARGS[@]}" s3 cp "s3://${VAULT}/${PREFIX}/" . --recursive \
  --exclude "*" \
  --include "evidence-*.tar.gz" \
  --include "evidence-*.tar.gz.sha256" \
  --include "evidence-*.tar.gz.sig.bundle" \
  --include "receipt.json"

BUNDLE="$(ls evidence-*.tar.gz | head -1)"

echo "=== 1. Integrity (SHA-256) ==="
EXPECTED="$(cat "${BUNDLE}.sha256")"
ACTUAL="$(hash_file "${BUNDLE}")"

if [[ "$EXPECTED" != "$ACTUAL" ]]; then
  echo "FAIL: SHA mismatch"
  echo "expected: $EXPECTED"
  echo "actual:   $ACTUAL"
  exit 1
fi

echo "  OK (${ACTUAL})"

echo "=== 2. Authenticity + timestamp (Cosign + Sigstore Rekor) ==="
cosign verify-blob \
  --bundle "${BUNDLE}.sig.bundle" \
  --certificate-identity-regexp '.*' \
  --certificate-oidc-issuer 'https://token.actions.githubusercontent.com' \
  "${BUNDLE}"

echo "  OK (Cosign verified)"

echo "=== 3. Preservation (Object Lock retention) ==="
RETAIN_UNTIL="$(aws "${AWS_ARGS[@]}" s3api get-object-retention \
  --bucket "${VAULT}" \
  --key "${PREFIX}/${BUNDLE}" \
  --query 'Retention.RetainUntilDate' \
  --output text)"

NOW="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

if [[ "$RETAIN_UNTIL" < "$NOW" ]]; then
  echo "FAIL: retention expired"
  echo "retain until: $RETAIN_UNTIL"
  echo "now:          $NOW"
  exit 1
fi

echo "  OK (retain until ${RETAIN_UNTIL})"

echo "CHAIN INTACT for run ${RUN_ID}"
