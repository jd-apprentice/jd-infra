variable "vercel_token" {}

module "vercel" {
  source = "./modules/vercel"

  vercel_token = var.vercel_token
}
