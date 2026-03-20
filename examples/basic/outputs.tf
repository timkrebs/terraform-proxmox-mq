output "endpoint" {
  description = "AMQP connection endpoint"
  value       = module.mq.endpoint
}

output "address" {
  description = "Message broker IP address"
  value       = module.mq.address
}

output "amqp_port" {
  description = "AMQP port"
  value       = module.mq.amqp_port
}

output "management_url" {
  description = "RabbitMQ management UI URL"
  value       = module.mq.management_url
}

output "amqp_connection_string" {
  description = "AMQP connection string"
  value       = module.mq.amqp_connection_string
  sensitive   = true
}

output "ssh_connection" {
  description = "SSH connection for management"
  value       = module.mq.ssh_connection
}
