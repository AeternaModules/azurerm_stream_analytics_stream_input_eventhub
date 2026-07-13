variable "stream_analytics_stream_input_eventhubs" {
  description = <<EOT
Map of stream_analytics_stream_input_eventhubs, attributes below
Required:
    - eventhub_name
    - name
    - resource_group_name
    - servicebus_namespace
    - stream_analytics_job_name
    - serialization (block):
        - encoding (optional)
        - field_delimiter (optional)
        - type (required)
Optional:
    - authentication_mode
    - eventhub_consumer_group_name
    - partition_key
    - shared_access_policy_key
    - shared_access_policy_key_key_vault_id (alternative to shared_access_policy_key - read from Key Vault instead)
    - shared_access_policy_key_key_vault_secret_name (alternative to shared_access_policy_key - read from Key Vault instead)
    - shared_access_policy_name
EOT

  type = map(object({
    eventhub_name                                  = string
    name                                           = string
    resource_group_name                            = string
    servicebus_namespace                           = string
    stream_analytics_job_name                      = string
    authentication_mode                            = optional(string)
    eventhub_consumer_group_name                   = optional(string)
    partition_key                                  = optional(string)
    shared_access_policy_key                       = optional(string)
    shared_access_policy_key_key_vault_id          = optional(string)
    shared_access_policy_key_key_vault_secret_name = optional(string)
    shared_access_policy_name                      = optional(string)
    serialization = object({
      encoding        = optional(string)
      field_delimiter = optional(string)
      type            = string
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        length(v.stream_analytics_job_name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        v.eventhub_consumer_group_name == null || (length(v.eventhub_consumer_group_name) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        length(v.eventhub_name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        length(v.servicebus_namespace) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        v.shared_access_policy_key == null || (length(v.shared_access_policy_key) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        v.shared_access_policy_name == null || (length(v.shared_access_policy_name) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        v.partition_key == null || (length(v.partition_key) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.stream_analytics_stream_input_eventhubs : (
        v.serialization.field_delimiter == null || (contains([" ", ",", "\t", "|", ";"], v.serialization.field_delimiter))
      )
    ])
    error_message = "must be one of:  , ,, 	, |, ;"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

