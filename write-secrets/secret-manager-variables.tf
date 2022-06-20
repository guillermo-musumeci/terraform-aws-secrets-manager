#######################################
## Secret Manager Module - Variables ##
#######################################

# Secret Variables
variable "api_username" {
  description = "API service username"
  type        = string
  sensitive   = true
}

