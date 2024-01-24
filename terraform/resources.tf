## Vercel

# variable "vercel_token" {}
# variable "vercel_domain" {
#   type        = string
#   default     = "next.jonathan.com.ar"
#   description = "Domain to be used in vercel"
# }

# module "vercel" {
#   source = "./modules/vercel"

#   vercel_domain = var.vercel_domain
#   vercel_token  = var.vercel_token
# }

## Cloudflare

variable "cloudflare_tunnel_name" {}
variable "cloudflare_tunnel_secret" {}
variable "cloudflare_admin_email" {}
variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}
variable "cloudflare_account_id" {}

module "cloudflare" {
  source = "./modules/cloudflare"

  cloudflare_api_token     = var.cloudflare_api_token
  cloudflare_zone_id       = var.cloudflare_zone_id
  cloudflare_account_id    = var.cloudflare_account_id
  cloudflare_tunnel_name   = var.cloudflare_tunnel_name
  cloudflare_tunnel_secret = var.cloudflare_tunnel_secret
  cloudflare_admin_email   = var.cloudflare_admin_email
}

## AWS

# variable "aws_region" {
#   description = "aws region"
#   type        = string
#   default     = "us-east-1"
# }

# variable "aws_public_ssh_key" {}
# variable "allowed_ip" {}

# module "aws" {
#   source = "./modules/aws"

#   aws_region         = var.aws_region
#   aws_public_ssh_key = var.aws_public_ssh_key
#   allowed_ip         = var.allowed_ip
# }

# output "instance_public_dns" {
#   value       = module.aws.instance_public_dns
#   description = "Public DNS of the instance"
# }
