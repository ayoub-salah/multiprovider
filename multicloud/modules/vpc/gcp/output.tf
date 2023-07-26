output "vpc_name" {
  value = {
    for vpc_key, vpc_value in google_compute_network.vpc : vpc_key => vpc_value.name
  }
}
