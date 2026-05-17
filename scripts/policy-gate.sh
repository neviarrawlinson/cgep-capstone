#!/usr/bin/env bash
set -euo pipefail

POLICY_DIR="policies"
WORKSPACE=""
EVIDENCE_DIR="evidence/lab-3-4"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --workspace) WORKSPACE="$2"; shift 2 ;;
    --policy) POLICY_DIR="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [[ -z "$WORKSPACE" ]]; then
  echo "Usage: $0 --workspace <path> [--policy <path>]" >&2
  exit 2
fi

if command -v conftest >/dev/null 2>&1; then
  CONFTEST_BIN="conftest"
elif [[ -x "/c/Tools/conftest/conftest.exe" ]]; then
  CONFTEST_BIN="/c/Tools/conftest/conftest.exe"
else
  echo "conftest not found" >&2
  exit 2
fi

mkdir -p "$EVIDENCE_DIR"

(
  cd "$WORKSPACE"
  terraform show -json tfplan > plan.json
)

EXIT=0
RESULTS_FILE="$EVIDENCE_DIR/conftest-results.json"

{
  echo "["

  FIRST=1

  for ns in compliance.sc28_aws compliance.ac3_aws compliance.cm6_aws compliance.cm6; do
    if [[ $FIRST -eq 1 ]]; then
      FIRST=0
    else
      printf ","
    fi

    if OUT=$($CONFTEST_BIN test --policy "$POLICY_DIR" --namespace "$ns" --output=json "$WORKSPACE/plan.json" 2>&1); then
      echo "$OUT"
    else
      EXIT=1
      echo "$OUT"
    fi
  done

  echo "]"
} > "$RESULTS_FILE"

if [[ $EXIT -eq 0 ]]; then
  echo "policy-gate: PASS"
else
  echo "policy-gate: FAIL"
  echo "See $RESULTS_FILE"
fi

exit $EXIT
