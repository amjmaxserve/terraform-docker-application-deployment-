terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

variable "network" {}

#############################
# PROMETHEUS
#############################

resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {

  name  = "prometheus"
  image = docker_image.prometheus.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = abspath("${path.root}/../monitoring/prometheus.yml")
    container_path = "/etc/prometheus/prometheus.yml"
  }

  command = [
    "--config.file=/etc/prometheus/prometheus.yml"
  ]

}

#############################
# GRAFANA
#############################

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {

  name  = "grafana"
  image = docker_image.grafana.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 3000
    external = 3001
  }

  volumes {
    host_path      = abspath("${path.root}/../monitoring/grafana-data")
    container_path = "/var/lib/grafana"
  }

}

#############################
# LOKI
#############################

resource "docker_image" "loki" {
  name = "grafana/loki:latest"
}

resource "docker_container" "loki" {

  name  = "loki"
  image = docker_image.loki.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 3100
    external = 3100
  }

  volumes {
    host_path      = abspath("${path.root}/../monitoring/loki-config.yml")
    container_path = "/etc/loki/local-config.yaml"
  }

  volumes {
    host_path      = abspath("${path.root}/../monitoring/loki-data")
    container_path = "/loki"
  }

  command = [
    "-config.file=/etc/loki/local-config.yaml"
  ]

}

#############################
# PROMTAIL
#############################

resource "docker_image" "promtail" {
  name = "grafana/promtail:latest"
}

resource "docker_container" "promtail" {

  name  = "promtail"
  image = docker_image.promtail.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = var.network
  }

  volumes {
    host_path      = abspath("${path.root}/../monitoring/promtail-config.yml")
    container_path = "/etc/promtail/config.yml"
  }

  volumes {
    host_path      = "/var/log"
    container_path = "/var/log"
  }

  command = [
    "-config.file=/etc/promtail/config.yml"
  ]

}



#############################
# NODE EXPORTER
#############################

resource "docker_image" "node_exporter" {
  name = "prom/node-exporter:latest"
}

resource "docker_container" "node_exporter" {

  name  = "node_exporter"
  image = docker_image.node_exporter.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 9100
    external = 9100
  }

}



#############################
# CADVISOR
#############################

resource "docker_image" "cadvisor" {
  name = "gcr.io/cadvisor/cadvisor:latest"
}

resource "docker_container" "cadvisor" {

  name  = "cadvisor"
  image = docker_image.cadvisor.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
  }

  volumes {
    host_path      = "/var/run"
    container_path = "/var/run"
  }

  volumes {
    host_path      = "/sys"
    container_path = "/sys"
  }

  volumes {
    host_path      = "/var/lib/docker"
    container_path = "/var/lib/docker"
  }

}




#############################
# POSTGRES EXPORTER
#############################

resource "docker_image" "postgres_exporter" {
  name = "quay.io/prometheuscommunity/postgres-exporter:latest"
}

resource "docker_container" "postgres_exporter" {

  name  = "postgres_exporter"
  image = docker_image.postgres_exporter.image_id

  restart = "unless-stopped"

  env = [
    "DATA_SOURCE_NAME=postgresql://postgres:password@postgres_db:5432/appdb?sslmode=disable"
  ]

  networks_advanced {
    name = var.network
  }

  ports {
    internal = 9187
    external = 9187
  }

}
