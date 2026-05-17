# METADATA
# title: CM-6 - Configuration Settings (AWS required tags)
# description: "Every taggable AWS resource must carry the four required tags: Project, Environment, ManagedBy, ComplianceScope."
# custom:
#   control_id: CM-6
#   framework: nist-800-53
#   severity: medium
#   remediation: "Add the missing tags or use provider default_tags."
package compliance.cm6_aws

import rego.v1

required := {"Project", "Environment", "ManagedBy", "ComplianceScope"}

labelable_type(t) if {
  t == "aws_s3_bucket"
}

labelable_type(t) if {
  t == "aws_dynamodb_table"
}

labelable_type(t) if {
  t == "aws_lambda_function"
}

labelable_type(t) if {
  t == "aws_kms_key"
}

labelable_type(t) if {
  t == "aws_cloudtrail"
}

deny contains msg if {
  resource := all_resources[_]
  labelable_type(resource.type)
  provided := tag_keys(resource)
  missing := required - provided
  count(missing) > 0
  msg := sprintf(
    "[CM-6] %s: missing required tags %v. Remediation: add the missing tags or use provider default_tags.",
    [resource.address, sort_array(missing)],
  )
}

all_resources contains r if {
  some r in input.planned_values.root_module.resources
}

all_resources contains r if {
  some child in object.get(input.planned_values.root_module, "child_modules", [])
  some r in object.get(child, "resources", [])
}

tag_keys(resource) := keys if {
  tags := object.get(resource.values, "tags_all", {})
  count(tags) > 0
  keys := {k | tags[k]}
}

tag_keys(resource) := keys if {
  count(object.get(resource.values, "tags_all", {})) == 0
  tags := object.get(resource.values, "tags", {})
  keys := {k | tags[k]}
}

sort_array(s) := sorted if {
  sorted := sort([x | some x in s])
}
