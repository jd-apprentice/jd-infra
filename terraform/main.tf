## Vercel

# variable "vercel_token" {}
# variable "domain" {
#   type        = string
#   default     = "jonathan.com.ar"
#   description = "Domain to be used in vercel"
# }

# module "vercel" {
#   source = "./modules/vercel"

#   domain       = var.domain
#   vercel_token = var.vercel_token
# }

## Cloudflare

# variable "cloudflare_api_token" {}
# variable "cloudflare_zone_id" {}
# variable "nginx_proxy_manager_ip" {}

# module "cloudflare" {
#   source = "./modules/cloudflare"

#   cloudflare_api_token   = var.cloudflare_api_token
#   cloudflare_zone_id     = var.cloudflare_zone_id
#   nginx_proxy_manager_ip = var.nginx_proxy_manager_ip
# }

## AWS

variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "aws_public_ssh_key" {}
variable "allowed_ip" {}

module "aws" {
  source = "./modules/aws"

  aws_region         = var.aws_region
  aws_public_ssh_key = var.aws_public_ssh_key
  allowed_ip         = var.allowed_ip
}

output "instance_public_dns" {
  value       = module.aws.instance_public_dns
  description = "Public DNS of the instance"
}

## Docker
