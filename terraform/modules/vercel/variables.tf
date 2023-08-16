variable "domain" {
  type        = string
  default     = "jonathan.com.ar"
  description = "Domain name to use for the project"
}

variable "repository" {
  type        = string
  default     = "https://github.com/jd-apprentice/Portfolio-Next"
  description = "Repository to use for the project"
}

variable "vercel_token" {
  type        = string
  description = "Vercel token to use for the project"
  sensitive   = true
}
