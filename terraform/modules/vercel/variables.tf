variable "vercel_domain" {
  type        = string
  default     = "next.jonathan.com.ar"
  description = "Domain name to use for the project"
}

variable "vercel_token" {
  type        = string
  description = "Vercel token to use for the project"
  sensitive   = true
}
