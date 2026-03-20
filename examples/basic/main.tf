terraform {
  required_version = ">= 1.13.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.94"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true

  ssh {
    agent       = false
    username    = "root"
    private_key = var.ssh_private_key
  }
}

module "mq" {
  source = "../../"

  identifier     = "my-rabbitmq"
  engine_version = "3.13"
  instance_class = "mq.t3.medium"

  allocated_storage = 20
  amqp_port         = 5672
  management_port   = 15672
  admin_username    = "admin"
  admin_password    = var.rabbitmq_password

  target_node = "pve"
  template_id = 9000

  ip_address     = "192.168.1.71/24"
  gateway        = "192.168.1.1"
  network_bridge = "vmbr0"

  ssh_user        = "ubuntu"
  ssh_public_keys = [var.ssh_public_key]

  allowed_cidrs = ["192.168.1.0/24"]

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
