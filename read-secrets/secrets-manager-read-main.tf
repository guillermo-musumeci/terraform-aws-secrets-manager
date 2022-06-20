###################################
## Secrets Manager Module - Main ##
###################################

# read service user secret
data "aws_secretsmanager_secret" "service_user" {
  name = "api_server/dev/service_user"
}

data "aws_secretsmanager_secret_version" "service_user" {
  secret_id = data.aws_secretsmanager_secret.service_user.id
}

# use locals to read the service user value
locals {
  service_user = data.aws_secretsmanager_secret_version.service_user.secret_string
}

output "service_user" {
  value = local.service_user
  sensitive = true
}

# DEBUG - export service user to text file for debugging (remove this code for prod environments)
resource "null_resource" "service_user" {
  provisioner "local-exec" {
    when    = create
    command = "echo ${local.service_user} >> user-secret.txt"
  }
}

# read service user password
data "aws_secretsmanager_secret" "service_pass" {
  name = "api_server/dev/service_pass"
}

data "aws_secretsmanager_secret_version" "service_pass" {
  secret_id = data.aws_secretsmanager_secret.service_pass.id
}

# use locals to read the service password value
locals {
  service_pass = data.aws_secretsmanager_secret_version.service_pass.secret_string
}

output "service_pass" {
  value = local.service_pass
  sensitive = true
}

# DEBUG - export service user to text file for debugging (remove this code for prod environments)
resource "null_resource" "service_pass" {
  provisioner "local-exec" {
    when    = create
    command = "echo ${local.service_pass} >> password-secret.txt"
  }
}

# read dns Config
data "aws_secretsmanager_secret" "dns_config" {
  arn = "arn:aws:secretsmanager:eu-west-1:088868772325:secret:api_server/dev/dns_config-d5q2Vw"
}

data "aws_secretsmanager_secret_version" "dns_config" {
  secret_id = data.aws_secretsmanager_secret.dns_config.id
}

# use locals to read the service user value
locals {
  dns_config = jsondecode(data.aws_secretsmanager_secret_version.dns_config.secret_string)
}

output "dns_config_DNS_Zone" {
  value = local.dns_config.DNSZone
  sensitive = true
}

output "dns_config_DNS_Server_1" {
  value = local.dns_config.DNSServer1
  sensitive = true
}

output "dns_config_DNS_Server_2" {
  value = local.dns_config.DNSServer2
  sensitive = true
}

# DEBUG - export service user to text file for debugging (remove this code for prod environments)
resource "null_resource" "dns_config" {
  provisioner "local-exec" {
    when    = create
    command = "echo ${local.dns_config.DNSZone} >> dns_zone.txt"
  }
}

