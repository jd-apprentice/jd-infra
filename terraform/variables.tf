#------------------------------------------------------------------------------
# AWS
#------------------------------------------------------------------------------

variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "access key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "aws_secret_key" {
  description = "secret key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "aws_ami" {
  description = "ami"
  type        = string
  default     = "ami-053b0d53c279acc90"
}

variable "aws_instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_ssh_key" {
  description = "ssh key path"
  type        = string
  default     = ""
}
