#####
# Docker
#####

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_image" "dolar_hoy" {
  name         = "dyallo/dolar-hoy-api:latest"
  keep_locally = false
}

resource "docker_image" "waifuland_api" {
  name         = "dyallo/waifuland-api:latest"
  keep_locally = false
}

resource "docker_image" "waifuland_fe" {
  name         = "dyallo/waifuland-fe:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"
  ports {
    internal = 80
    external = 8000
  }
}

resource "docker_container" "dolar_hoy" {
  image = docker_image.dolar_hoy.image_id
  name  = "dolar_hoy"
  ports {
    internal = 4500
    external = 4500
  }
}

resource "docker_container" "waifuland_api" {
  image = docker_image.waifuland_api.image_id
  name  = "waifuland_api"
  ports {
    internal = 4000
    external = 4000
  }
}

resource "docker_container" "waifuland_fe" {
  image = docker_image.waifuland_fe.image_id
  name  = "waifuland_fe"
  ports {
    internal = 3500
    external = 3500
  }
}
