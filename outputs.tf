output "mq_instance_id" {
  description = "The Proxmox VM ID of the message broker instance"
  value       = proxmox_virtual_environment_vm.mq_instance.vm_id
}

output "mq_instance_name" {
  description = "The VM name of the message broker instance"
  value       = proxmox_virtual_environment_vm.mq_instance.name
}

output "endpoint" {
  description = "The AMQP connection endpoint (address:port)"
  value       = "${local.instance_address}:${var.amqp_port}"
}

output "address" {
  description = "The IP address of the message broker instance"
  value       = local.instance_address
}

output "amqp_port" {
  description = "The AMQP port the broker is listening on"
  value       = var.amqp_port
}

output "management_url" {
  description = "The RabbitMQ management UI URL"
  value       = "http://${local.instance_address}:${var.management_port}"
}

output "amqp_connection_string" {
  description = "AMQP connection string"
  value       = "amqp://${var.admin_username}:${var.admin_password}@${local.instance_address}:${var.amqp_port}${var.vhost}"
  sensitive   = true
}

output "ssh_connection" {
  description = "SSH connection string for management"
  value       = "${var.ssh_user}@${local.instance_address}"
}
