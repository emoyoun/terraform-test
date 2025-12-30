# Mock provider to bypass authentication requirements during dry-run
provider "google" {
  project = "mock-project-id"
  region  = "us-central1"
}
