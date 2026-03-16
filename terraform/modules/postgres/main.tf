terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}


variable "network" {}
variable "password" {}

resource "docker_image" "postgres" {
  name = "postgres:15"
}

resource "docker_container" "postgres" {

  name  = "postgres_db"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_PASSWORD=${var.password}",
    "POSTGRES_DB=appdb"
  ]

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 5432
    external = 5432
  }
}

output "container_name" {
  value = docker_container.postgres.name
}
