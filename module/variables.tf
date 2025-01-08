# variable set for Fed creds and service principle
variable "pipeline_service_principles" {
  type = set(string)
  description = "list of service principles to be created for azure app repos workflows"
  default = []
}

variable "federated_id_credentails" {
    type = list(object({
      app_name = string
      display_name = string
      description = string
      audiences = optional(list(string), ["api://AzureADTokenExchange"])
      issuer = optional(string, "https://token.actions.githubuserscontent.com")
      subject = string
    }))
  description = "Mapping of service plrinciples to their federated credentiails for azure app workflows."
  default = []
}
