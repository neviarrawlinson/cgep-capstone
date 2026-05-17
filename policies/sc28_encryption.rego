# METADATA
# title: SC-28 - Encryption at Rest (GCS)
# description: "Every google_storage_bucket must encrypt at rest with a customer-managed encryption key."
# custom:
#   control_id: SC-28
#   framework: nist-800-53
#   severity: high
#   remediation: "Add an encryption block with default_kms_key_name referencing a google_kms_crypto_key."
package compliance.sc28

import rego.v1

deny contains msg if {
resource := all_buckets[_]
not has_cmek(resource)
msg := sprintf(
"[SC-28] %s: missing customer-managed encryption key. Remediation: add encryption { default_kms_key_name = ... }.",
[resource.address],
)
}

all_buckets contains r if {
some r in object.get(input.planned_values.root_module, "resources", [])
r.type == "google_storage_bucket"
}

all_buckets contains r if {
some child in object.get(input.planned_values.root_module, "child_modules", [])
some r in object.get(child, "resources", [])
r.type == "google_storage_bucket"
}

has_cmek(resource) if {
encryption := object.get(resource.values, "encryption", [])
count(encryption) > 0
not empty_kms_key(encryption[0])
}

empty_kms_key(enc) if {
object.get(enc, "default_kms_key_name", "__missing__") == ""
}

empty_kms_key(enc) if {
object.get(enc, "default_kms_key_name", "__missing__") == null
}
