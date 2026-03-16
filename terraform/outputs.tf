output "frontend_url" {
  value = "http://192.168.29.88:${var.frontend_port}"
}

output "backend_url" {
  value = "http://192.168.29.88:${var.backend_port}"
}
