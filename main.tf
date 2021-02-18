locals {
  vault-map = zipmap([for v in lxd_container.vault : v.id], [for v in lxd_container.vault : v.ipv4_address])
}

terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "1.5.0"
    }
  }
}

data "http" "template" {
  url = var.template
}

data "template_file" "template" {
  template = data.http.template.body
  vars = {
    dc            = var.dc-name,
    iface         = "eth0",
    consul_server = "consul01-${var.role}",
    license       = var.license
  }
}

resource "lxd_container" "vault" {
  for_each  = toset(var.lxd-profile)
  name      = "${format("vault%02d", index(var.lxd-profile, each.value) + 1)}-${var.role}"
  image     = "packer-vault"
  ephemeral = false
  profiles  = [each.value]

  config = {
    "user.user-data" = data.template_file.template.rendered
  }

}

output "hosts" {
  value = local.vault-map
}
