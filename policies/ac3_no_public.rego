# METADATA
# title: AC-3 - Access Enforcement
# description: "GCS buckets must enforce uniform bucket-level access and public access prevention. Firewall rules must not expose management ports to the public internet."
# custom:
#   control_id: AC-3
#   framework: nist-800-53
#   severity: critical
#   remediation: "Set uniform_bucket_level_access=true and public_access_prevention=enforced. For firewalls, narrow source_ranges or remove the rule."
package compliance.ac3

import rego.v1

deny contains msg if {
resource := bucket_resource[_]
not bucket_locked_down(resource)
msg := sprintf(
"[AC-3] %s: bucket allows public access. Remediation: set uniform_bucket_level_access=true and public_access_prevention=\"enforced\".",
[resource.address],
)
}

bucket_resource contains r if {
some r in all_resources
r.type == "google_storage_bucket"
}

bucket_locked_down(r) if {
object.get(r.values, "uniform_bucket_level_access", false) == true
object.get(r.values, "public_access_prevention", "") == "enforced"
}

mgmt_port(p) if {
p == "22"
}

mgmt_port(p) if {
p == "3389"
}

public_range(s) if {
s == "0.0.0.0/0"
}

public_range(s) if {
s == "*"
}

deny contains msg if {
r := all_resources[_]
r.type == "google_compute_firewall"
object.get(r.values, "direction", "") == "INGRESS"
some src in object.get(r.values, "source_ranges", [])
public_range(src)
some allow in object.get(r.values, "allow", [])
some port in object.get(allow, "ports", [])
mgmt_port(port)
msg := sprintf(
"[AC-3] %s: management port %s open to %s. Remediation: narrow source_ranges or remove the rule.",
[r.address, port, src],
)
}

all_resources contains r if {
some r in object.get(input.planned_values.root_module, "resources", [])
}

all_resources contains r if {
some child in object.get(input.planned_values.root_module, "child_modules", [])
some r in object.get(child, "resources", [])
}
