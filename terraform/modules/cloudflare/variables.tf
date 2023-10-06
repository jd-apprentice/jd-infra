variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable "nginx_proxy_manager_ip" {
  description = "Nginx Proxy Manager IP"
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
