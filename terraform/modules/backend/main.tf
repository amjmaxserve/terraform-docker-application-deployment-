terraform {

  required_providers {

    docker = {
      source = "kreuzwerker/docker"
    }

  }

}

variable "network" {}
variable "db_host" {}
variable "db_password" {}

resource "docker_image" "backend" {

  name = "task-backend"

  build {

    context = "${path.root}/../app/backend"

  }

}

resource "docker_container" "backend" {

  name  = "backend"
  image = docker_image.backend.image_id

  env = [

    "DB_HOST=${var.db_host}",
    "DB_PASSWORD=${var.db_password}"

  ]

  networks_advanced {

    name = var.network

  }

  ports {

    internal = 5000
    external = 5000

  }

}
