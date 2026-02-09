# Managed by Watchdog
# Current Upstream Version: 9.0.0

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "15.2.0"

  project_id   = "audit-project"
  network_name = "audit-vpc"
  
  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    }
  ]
}