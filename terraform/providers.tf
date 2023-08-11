terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_ccess_key
  secret_key = var.aws_secret_key
}

provider "docker" {}
