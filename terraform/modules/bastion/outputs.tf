output "bastion_host_ip" {
  description = "public IP address for bastion host"
  value       = data.aws_instance.bastion_host_data.public_ip
}

output "bastion_host_dns" {
  description = "dns for bastion host"
  value       = data.aws_instance.bastion_host_data.public_dns
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tpl",
    {
      bastion_dns = data.aws_instance.bastion_host_data.public_dns,
      bastion_ip  = data.aws_instance.bastion_host_data.public_ip
    }
  )
  filename = "inventory.ini"
}
