variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudflare_tunnel_secret" {
  description = "Cloudflare Tunnel Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudflare_admin_email" {
  description = "Cloudflare Admin Email"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudflare_tunnel_name" {
  description = "Cloudflare Tunnel Name"
  type        = string
  default     = ""
  sensitive   = false
}
