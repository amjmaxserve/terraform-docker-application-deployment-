resource "grafana_dashboard" "node_dashboard" {
  
  depends_on = [grafana_data_source.prometheus]
  config_json = file("${path.module}/grafana-dashboards/node-dashboard.json")
}

resource "grafana_dashboard" "docker_dashboard" {

  depends_on = [grafana_data_source.prometheus]
  config_json = file("${path.module}/grafana-dashboards/docker-dashboard.json")
}

resource "grafana_dashboard" "postgres_dashboard" {

  depends_on = [grafana_data_source.prometheus]
  config_json = file("${path.module}/grafana-dashboards/postgres-dashboard.json")
}
