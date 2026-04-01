# Managed by Watchdog
# Current Upstream Version: 18.0.0

module "sql-db" {
  source  = "terraform-google-modules/sql-db/google//modules/mysql"
  version = "28.0.1"

  name             = "audit-sql"
  database_version = "28.0.1"
  project_id       = "audit-project"
  zone             = "us-central1-a"
  region           = "us-central1"
}