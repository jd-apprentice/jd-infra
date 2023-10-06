output "instance_public_dns" {
  value       = aws_instance.nginx_proxy_manager.public_dns
  description = "Public DNS of the instance"
}
