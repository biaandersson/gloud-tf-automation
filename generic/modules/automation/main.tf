# BEGIN: 7f8d9bcejpp
resource "google_compute_address" "ephemeral" {
  name         = "ephemeral-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "generic" {
  machine_type = var.instance_type
  for_each     = var.instance_name
  zone         = var.instance_zone
  tags         = var.network_tags
  name         = each.value

  boot_disk {
    initialize_params {
      image = var.instance_image
      size  = var.instance_disk_size
    }
  }

  network_interface {
    network = var.instance_network
    access_config {
      nat_ip = google_compute_address.ephemeral.address
    }
  }

  metadata_startup_script = local.metadata_startup_script

  metadata = {
    block-project-ssh-keys = true
  }
}

locals {
  # if salt_master = true, then use saltmaster.sh, else use saltminion.sh
  metadata_startup_script = var.salt_master ? file("${path.module}/scripts/saltmaster.sh") : file("${path.module}/scripts/saltminion.sh")
}
