variable "dockerhub_username" {
  description = "Dockerhub username"
  default     = ""
  type        = string
}

variable "dockerhub_password" {
  description = "Dockerhub password"
  default     = ""
  type        = string
  sensitive   = true
}
