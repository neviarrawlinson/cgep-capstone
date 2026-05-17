# METADATA
# title: CM-6 - Configuration Settings
# description: "Every taggable resource must carry the four required labels: project, environment, managed_by, compliance_scope."
# custom:
#   control_id: CM-6
#   framework: nist-800-53
#   severity: medium
#   remediation: "Add the four required labels: project, environment, managed_by, compliance_scope."
package compliance.cm6

import rego.v1

required := {"project", "environment", "managed_by", "compliance_scope"}

deny contains msg if {
resource := all_resources[_]
labelable_type(resource.type)
provided := provided_labels(resource)
missing := required - provided
count(missing) > 0
missing_list := sort([x | some x in missing])
msg := sprintf(
"[CM-6] %s: missing required labels %v. Remediation: add the missing labels to the resource.",
[resource.address, missing_list],
)
}

labelable_type(t) if {
t == "google_storage_bucket"
}

labelable_type(t) if {
t == "google_compute_instance"
}

labelable_type(t) if {
t == "google_compute_disk"
}

all_resources contains r if {
some r in object.get(input.planned_values.root_module, "resources", [])
}

all_resources contains r if {
some child in object.get(input.planned_values.root_module, "child_modules", [])
some r in object.get(child, "resources", [])
}

provided_labels(resource) := keys if {
labels := object.get(resource.values, "labels", {})
keys := {k | labels[k]}
}
