output "vm_ips" {
  value = {
    for vm_key, vm_value in google_compute_instance.vm : vm_key => vm_value.network_interface[0].access_config[0].nat_ip
  }
}
