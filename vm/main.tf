# Managed by Watchdog
# Current Upstream Version: 11.0.0

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "14.2.0"

  region          = "us-central1"
  project_id      = "audit-project"
  network         = "default"
  service_account = {
    email  = "sa@audit-project.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}