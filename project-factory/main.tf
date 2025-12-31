# Managed by Watchdog
# Current Upstream Version: 14.4.0

module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "18.2.0"

  name              = "audit-factory-project"
  random_project_id = true
  org_id            = "1234567890"
  billing_account   = "000000-000000-000000"
}