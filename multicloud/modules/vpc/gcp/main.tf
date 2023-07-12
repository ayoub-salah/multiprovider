resource "google_compute_network" "main" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}