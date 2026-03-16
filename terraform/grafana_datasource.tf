provider "grafana" {
  url  = "http://192.168.29.88:3001"
  auth = "admin:admin"
}

resource "grafana_data_source" "prometheus" {
  
  depends_on = [null_resource.wait_for_grafana]

  name = "Prometheus"
  type = "prometheus"
  url  = "http://prometheus:9090"

}

resource "grafana_data_source" "loki" {
  
  depends_on = [null_resource.wait_for_grafana]
  
  name = "Loki"
  type = "loki"
  url  = "http://loki:3100"

}
