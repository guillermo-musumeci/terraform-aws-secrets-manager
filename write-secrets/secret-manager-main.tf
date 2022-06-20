##################################
## Secret Manager Module - Main ##
##################################

# Creating a AWS Secret for API Service UserName 
resource "aws_secretsmanager_secret" "service_user" {
  name        = "${var.app_name}/${var.app_environment}/service_user"
  description = "Service Account Username for the API"
   
  recovery_window_in_days = 0

  tags = {
    Name        = "${lower(var.app_name)}/${var.app_environment}/service_user"
    Environment = var.app_environment
  }
}

resource "aws_secretsmanager_secret_version" "service_user" {
  secret_id     = aws_secretsmanager_secret.service_user.id
  secret_string = var.api_username
}

# Creating a AWS Secret for API Service Password
resource "random_password" "service_password" {
  length  = 16
  special = true
  numeric = true
  upper   = true
  lower   = true
}
  
resource "aws_secretsmanager_secret" "service_password" {
  name        = "${var.app_name}/${var.app_environment}/service_pass"
  description = "Service Account Password for the API"

  recovery_window_in_days = 0

  tags = {
    Name        = "${lower(var.app_name)}/${var.app_environment}/service_pass"
    Environment = var.app_environment
  }
}

resource "aws_secretsmanager_secret_version" "service_password" {
  secret_id     = aws_secretsmanager_secret.service_password.id
  secret_string = random_password.service_password.result
}

# Creating a AWS Secret for DNS Configuration
resource "aws_secretsmanager_secret" "dns_config" {
  name        = "${var.app_name}/${var.app_environment}/dns_config"
  description = "DNS Configuration"

  recovery_window_in_days = 0

  tags = {
    Name        = "${lower(var.app_name)}/${var.app_environment}/dns_config"
    Environment = var.app_environment
  }
}

resource "aws_secretsmanager_secret_version" "dns_config" {
  secret_id     = aws_secretsmanager_secret.dns_config.id
  secret_string = <<EOF
  {
    "DNSZone": "kopicloud.local",
    "DNSServer1": "10.127.1.6",
    "DNSServer2": "10.127.1.7"
  }
EOF
}
