data "azurerm_key_vault_secret" "shared_access_policy_key" {
  for_each     = { for k, v in var.stream_analytics_stream_input_eventhubs : k => v if v.shared_access_policy_key_key_vault_id != null && v.shared_access_policy_key_key_vault_secret_name != null }
  name         = each.value.shared_access_policy_key_key_vault_secret_name
  key_vault_id = each.value.shared_access_policy_key_key_vault_id
}
resource "azurerm_stream_analytics_stream_input_eventhub" "stream_analytics_stream_input_eventhubs" {
  for_each = var.stream_analytics_stream_input_eventhubs

  eventhub_name                = each.value.eventhub_name
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  servicebus_namespace         = each.value.servicebus_namespace
  stream_analytics_job_name    = each.value.stream_analytics_job_name
  authentication_mode          = each.value.authentication_mode
  eventhub_consumer_group_name = each.value.eventhub_consumer_group_name
  partition_key                = each.value.partition_key
  shared_access_policy_key     = each.value.shared_access_policy_key != null ? each.value.shared_access_policy_key : try(data.azurerm_key_vault_secret.shared_access_policy_key[each.key].value, null)
  shared_access_policy_name    = each.value.shared_access_policy_name

  serialization {
    encoding        = each.value.serialization.encoding
    field_delimiter = each.value.serialization.field_delimiter
    type            = each.value.serialization.type
  }
}

