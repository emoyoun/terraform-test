# Managed by Watchdog
# Current Upstream Version: 42.0.0

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  # The workflow will update this specific line
  version = "42.0.0"

  project_id     = "my-audit-project"
  name           = "audit-cluster"
  region         = "us-central1"
  network        = "default"
  subnetwork     = "default"
  ip_range_pods  = "pods"
  ip_range_services = "services"
  zones          = ["us-central1-a"]
}
