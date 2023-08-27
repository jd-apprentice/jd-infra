output "instance_public_dns" {
  value       = aws_instance.dyallab.public_dns
  description = "Public DNS of the instance"
}
