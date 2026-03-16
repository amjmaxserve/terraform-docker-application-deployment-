
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}


variable "network_name" {}

resource "docker_network" "app_network" {
  name = var.network_name
}

output "network_name" {
  value = docker_network.app_network.name
}
