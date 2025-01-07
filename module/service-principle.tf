# Create Service prinicple with Federated credentails
data "azuread_client_config" "current" {}

resource "azuread_application" "pipeline_app" {
    for_each = var.pipeline_service_principles
    display_name = "Azure-${each.value}-DEV"
    owners = [data.azuread_client_config.current.object_id]
  
}

resource "azuread_service_principal" "pipeline_spn" {
    for_each = var.pipeline_service_principles
    client_id = azuread_application.pipeline_app[eash.value].client_id
    owners = [data.azuread_client_config.current.object_id]
  
}

resource "azuread_application_federated_identity_credential" "pipeline_fed_id_creds" {
    for_each = {
        for creds in var.federated_id_credentails : "${creds.app_name}.${creds.display_name}" => creds
    }
    application_id = azuread_application.pipeline_app[each.value.app_name].client_id
    display_name = each.value.display_name
    description = each.value.description
    audiences = each.value.audiences
    issuer = each.value.issuer
    subject = each.value.subject
}

