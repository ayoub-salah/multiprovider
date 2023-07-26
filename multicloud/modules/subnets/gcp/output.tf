output "subnet_ids" {
  value = {
    for subnet_key, subnet_value in google_compute_subnetwork.subnets : subnet_key => subnet_value.id
  }
}
