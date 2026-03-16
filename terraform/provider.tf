terraform {
  required_providers {

    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }

    grafana = {
      source  = "grafana/grafana"
      version = "~> 2.0"
    }

  }
}

