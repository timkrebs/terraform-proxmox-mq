################################################################################
# Instance Identity
################################################################################

variable "identifier" {
  type        = string
  description = "Name of the message broker instance (used as VM name)"
}

variable "vm_id" {
  type        = number
  default     = null
  description = "Proxmox VM ID (auto-assigned if not specified)"
}

################################################################################
# Engine
################################################################################

variable "engine_version" {
  type        = string
  description = "RabbitMQ version"
  default     = "3.13"

  validation {
    condition     = contains(["3.12", "3.13"], var.engine_version)
    error_message = "engine_version must be one of: 3.12, 3.13."
  }
}

################################################################################
# Instance Class (Proxmox sizing)
################################################################################

variable "instance_class" {
  type        = string
  description = "Instance class defining CPU and memory (e.g., 'mq.t3.small', 'mq.t3.medium')"
  default     = "mq.t3.small"

  validation {
    condition     = contains(["mq.t3.small", "mq.t3.medium", "mq.t3.large", "mq.t3.xlarge", "mq.t3.2xlarge", "custom"], var.instance_class)
    error_message = "instance_class must be one of: mq.t3.small, mq.t3.medium, mq.t3.large, mq.t3.xlarge, mq.t3.2xlarge, custom."
  }
}

variable "custom_cores" {
  type        = number
  default     = null
  description = "CPU cores (only used when instance_class = 'custom')"
}

variable "custom_memory" {
  type        = number
  default     = null
  description = "Memory in MB (only used when instance_class = 'custom')"
}

variable "cpu_type" {
  type        = string
  description = "CPU type for the VM (see Proxmox documentation for available types)"
  default     = "x86-64-v2-AES"
}

################################################################################
# Storage
################################################################################

variable "allocated_storage" {
  type        = number
  description = "Disk size in GB for the message broker VM"
  default     = 20
}

variable "storage_pool" {
  type        = string
  description = "Proxmox storage pool for the VM disk"
  default     = "local-lvm"
}

variable "snippets_storage" {
  type        = string
  description = "Proxmox storage for cloud-init snippets (must support 'snippets' content type)"
  default     = "local"
}

################################################################################
# RabbitMQ Configuration
################################################################################

variable "amqp_port" {
  type        = number
  description = "Port for AMQP connections"
  default     = 5672
}

variable "management_port" {
  type        = number
  description = "Port for RabbitMQ management UI"
  default     = 15672
}

variable "admin_username" {
  type        = string
  description = "Admin username for the RabbitMQ broker"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the RabbitMQ broker"
  sensitive   = true
}

variable "vhost" {
  type        = string
  description = "RabbitMQ virtual host to create"
  default     = "/"
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to connect to the broker (used for iptables rules)"
  default     = ["0.0.0.0/0"]
}

################################################################################
# Proxmox Target
################################################################################

variable "target_node" {
  type        = string
  description = "Proxmox node to deploy the VM on"
}

variable "template_id" {
  type        = number
  description = "VM template ID to clone from (must have cloud-init and qemu-guest-agent)"
}

################################################################################
# Network
################################################################################

variable "ip_address" {
  type        = string
  description = "Static IP in CIDR notation (e.g., '192.168.1.71/24')"

  validation {
    condition     = can(cidrhost(var.ip_address, 0))
    error_message = "ip_address must be a valid CIDR notation (e.g., '192.168.1.71/24')."
  }
}

variable "gateway" {
  type        = string
  description = "Network gateway IP address"

  validation {
    condition     = can(regex("^(\\d{1,3}\\.){3}\\d{1,3}$", var.gateway))
    error_message = "gateway must be a valid IPv4 address (e.g., '192.168.1.1')."
  }
}

variable "network_bridge" {
  type        = string
  description = "Proxmox network bridge"
  default     = "vmbr0"
}

################################################################################
# SSH / Cloud-Init
################################################################################

variable "ssh_user" {
  type        = string
  description = "Cloud-init user for SSH access"
  default     = "ubuntu"
}

variable "ssh_public_keys" {
  type        = list(string)
  description = "SSH public keys for VM access"
}

################################################################################
# Tags
################################################################################

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the VM (converted to Proxmox tag list)"
  default     = {}
}
