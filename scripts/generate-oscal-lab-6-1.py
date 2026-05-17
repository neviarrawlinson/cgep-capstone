import json
import uuid
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path.cwd()

receipt_path = ROOT / "evidence" / "lab-5-4" / "chain-receipt.json"
if not receipt_path.exists():
    raise SystemExit("Missing evidence/lab-5-4/chain-receipt.json. Capture Lab 5.4 signed evidence first.")

receipt = json.loads(receipt_path.read_text(encoding="utf-8"))

vault = receipt.get("vault")
bundle_key = receipt.get("bundle_key")
run_id = receipt.get("run_id")
sha256 = receipt.get("sha256")

if not vault or not bundle_key:
    raise SystemExit("chain-receipt.json must include vault and bundle_key.")

evidence_href = f"s3://{vault}/{bundle_key}"
receipt_href = f"s3://{vault}/runs/{run_id}/receipt.json"

now = datetime.now(timezone.utc).isoformat(timespec="microseconds")

party_uuid = str(uuid.uuid4())
component_uuid = str(uuid.uuid4())
ci_uuid = str(uuid.uuid4())

def evidence_links(control_id):
    return [
        {
            "rel": "evidence",
            "href": evidence_href,
            "text": f"Signed workflow evidence bundle for {control_id.upper()} implementation evidence."
        },
        {
            "rel": "evidence-receipt",
            "href": receipt_href,
            "text": f"S3 evidence vault receipt for run {run_id}, SHA-256 {sha256}."
        }
    ]

implemented_requirements = [
    {
        "uuid": str(uuid.uuid4()),
        "control-id": "sc-28",
        "description": "The compliant-s3 Terraform primitive protects information at rest by using server-side encryption with a customer-managed AWS KMS key for the primary S3 bucket.",
        "props": [
            {"name": "implementation-status", "value": "implemented"},
            {"name": "terraform-resource", "value": "aws_s3_bucket_server_side_encryption_configuration.primary"},
            {"name": "terraform-resource", "value": "aws_kms_key.s3"}
        ],
        "links": evidence_links("sc-28")
    },
    {
        "uuid": str(uuid.uuid4()),
        "control-id": "ac-3",
        "description": "The compliant-s3 Terraform primitive enforces access control by blocking public access paths on the primary and log buckets.",
        "props": [
            {"name": "implementation-status", "value": "implemented"},
            {"name": "terraform-resource", "value": "aws_s3_bucket_public_access_block.primary"},
            {"name": "terraform-resource", "value": "aws_s3_bucket_public_access_block.logs"}
        ],
        "links": evidence_links("ac-3")
    },
    {
        "uuid": str(uuid.uuid4()),
        "control-id": "au-3",
        "description": "The compliant-s3 Terraform primitive supports audit record generation by enabling S3 server access logging to a dedicated log bucket.",
        "props": [
            {"name": "implementation-status", "value": "implemented"},
            {"name": "terraform-resource", "value": "aws_s3_bucket_logging.primary"},
            {"name": "terraform-resource", "value": "aws_s3_bucket.logs"}
        ],
        "links": evidence_links("au-3")
    },
    {
        "uuid": str(uuid.uuid4()),
        "control-id": "cm-6",
        "description": "The compliant-s3 Terraform primitive enforces baseline configuration settings through version-controlled Terraform resources and required compliance tags.",
        "props": [
            {"name": "implementation-status", "value": "implemented"},
            {"name": "terraform-path", "value": "terraform/primitives/compliant-s3"},
            {"name": "required-tags", "value": "Project, Environment, ManagedBy, ComplianceScope"}
        ],
        "links": evidence_links("cm-6")
    }
]

component_definition = {
    "component-definition": {
        "uuid": str(uuid.uuid4()),
        "metadata": {
            "title": "compliant-s3 module v1",
            "last-modified": now,
            "version": "1.0.0",
            "oscal-version": "1.2.1",
            "parties": [
                {
                    "uuid": party_uuid,
                    "type": "organization",
                    "name": "CGE-P Capstone Portfolio"
                }
            ]
        },
        "components": [
            {
                "uuid": component_uuid,
                "type": "software",
                "title": "compliant-s3",
                "description": "Reusable Terraform primitive for an AWS S3 primary bucket plus a dedicated access-log bucket. The primitive enforces server-side encryption, versioning, public access blocking, access logging, and required compliance tags.",
                "purpose": "Provide a compliant-by-default AWS S3 storage primitive that can be evaluated through policy-as-code and linked to signed evidence.",
                "responsible-roles": [
                    {
                        "role-id": "provider",
                        "party-uuids": [party_uuid]
                    }
                ],
                "control-implementations": [
                    {
                        "uuid": ci_uuid,
                        "source": "https://raw.githubusercontent.com/usnistgov/oscal-content/main/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_catalog.json",
                        "description": "Implementation of selected NIST SP 800-53 Rev 5 controls satisfied by the compliant-s3 Terraform primitive.",
                        "implemented-requirements": implemented_requirements
                    }
                ]
            }
        ]
    }
}

profile = {
    "profile": {
        "uuid": str(uuid.uuid4()),
        "metadata": {
            "title": "CGE-P minimum control selection",
            "last-modified": now,
            "version": "1.0.0",
            "oscal-version": "1.2.1"
        },
        "imports": [
            {
                "href": "https://raw.githubusercontent.com/usnistgov/oscal-content/main/nist.gov/SP800-53/rev5/json/NIST_SP-800-53_rev5_catalog.json",
                "include-controls": [
                    {
                        "with-ids": ["sc-28", "ac-3", "au-3", "cm-6"]
                    }
                ]
            }
        ],
        "merge": {
            "as-is": True
        }
    }
}

component_dir = ROOT / "oscal" / "component-definitions" / "compliant-s3-v1"
profile_dir = ROOT / "oscal" / "profiles" / "cge-p-minimum"

component_dir.mkdir(parents=True, exist_ok=True)
profile_dir.mkdir(parents=True, exist_ok=True)

(component_dir / "component-definition.json").write_text(
    json.dumps(component_definition, indent=2) + "\n",
    encoding="utf-8"
)

(profile_dir / "profile.json").write_text(
    json.dumps(profile, indent=2) + "\n",
    encoding="utf-8"
)

readme = """# OSCAL Artifacts

This folder contains OSCAL artifacts for the CGE-P capstone portfolio.

## Component Definitions

| Component | Location | Purpose |
|---|---|---|
| compliant-s3 v1 | component-definitions/compliant-s3-v1/component-definition.json | Describes how the Terraform compliant-s3 primitive implements selected NIST SP 800-53 Rev 5 controls |

## Profiles

| Profile | Location | Purpose |
|---|---|---|
| CGE-P minimum control selection | profiles/cge-p-minimum/profile.json | Selects SC-28, AC-3, AU-3, and CM-6 from the NIST SP 800-53 Rev 5 catalog |

## Evidence Chain

The component definition links implemented requirements to signed evidence in the S3 evidence vault. The evidence chain can be verified with:

```bash
bash scripts/verify-evidence.sh <run_id> --vault <vault_name> --profile cgep-sandbox
The current component evidence points to the signed evidence bundle recorded in:

evidence/lab-5-4/chain-receipt.json

"""

(ROOT / "oscal" / "README.md").write_text(readme, encoding="utf-8")

print("Created OSCAL component definition and profile.")
print(f"Evidence bundle: {evidence_href}")
print(f"Run ID: {run_id}")
