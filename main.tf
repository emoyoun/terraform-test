# Managed by Watchdog
# Current Commit: HEAD (auto-updated by workflow)

module "gke" {
  # We pull directly from the master branch of the GKE module
  source = "git::https://github.com/terraform-google-modules/terraform-google-kubernetes-engine.git?ref=master"

  project_id     = "my-audit-project"
  name           = "audit-cluster"
  region         = "us-central1"
  network        = "default"
  subnetwork     = "default"
  ip_range_pods  = "pods"
  ip_range_services = "services"
  
  # Minimal configuration to ensure 'terraform validate' passes
  zones = ["us-central1-a"]
}
