resource "null_resource" "wait_for_grafana" {

  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting for Grafana to be ready..."
      until curl -s http://192.168.29.88:3001/api/health | grep '"database":"ok"'; do
        sleep 5
      done
      echo "Grafana is ready!"
    EOT
  }

  depends_on = [
    module.observability
  ]

}
