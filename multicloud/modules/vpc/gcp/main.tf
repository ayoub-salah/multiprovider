resource "google_compute_network" "vpc" {
  for_each = var.vpcs
  name    = each.value.name
  auto_create_subnetworks = false
}