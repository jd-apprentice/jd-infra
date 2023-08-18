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

## AWS

variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}


module "aws" {
  source = "./modules/aws"

  aws_region     = var.aws_region
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}

## Docker
