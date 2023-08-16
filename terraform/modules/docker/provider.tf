terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"

  registry_auth {
    address  = "registry.hub.docker.com"
    username = var.dockerhub_username
    password = var.dockerhub_password
  }
}
