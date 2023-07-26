resource "google_compute_firewall" "firewall" {
  for_each = var.vms
  name    = "${each.value.name}-firewall"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = each.value.ports
  }

  target_tags = [each.value.name]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm" {
  for_each     = var.vms
  name         = each.value.name
  machine_type = each.value.type
  zone         = each.value.zone
  tags         = [each.value.name]
  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }

  network_interface {
    network = var.network
    subnetwork = each.value.subnet 
    access_config {}
  }

  metadata_startup_script = file(each.value.userdata_script)
}
