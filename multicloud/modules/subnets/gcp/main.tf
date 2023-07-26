resource "google_compute_subnetwork" "subnets" {
  for_each          = var.subnets
  name              = each.value.name
  ip_cidr_range     = each.value.ip_cidr_range
  region            = each.value.region
  network           = each.value.vpc_name
}