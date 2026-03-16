terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

variable "network" {}

resource "docker_image" "frontend" {

  name = "task-frontend"

  build {
    context = "${path.root}/../app/frontend"
  }

}

resource "docker_container" "frontend" {

  name  = "frontend"
  image = docker_image.frontend.image_id

  env = [
    "REACT_APP_API_URL=http://192.168.29.88:5000"
  ]

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 3000
    external = 3000
  }

}
