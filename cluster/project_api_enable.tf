resource "google_project_service" "project" {
  project = "rmk-demo-344812"
  service = ["iam.googleapis.com", "servicenetworking.googleapis.com", "artifactregistry.googleapis.com", "container.googleapis.com", "clouddeploy.googleapis.com", "cloudbuild.googleapis.com", "sourcerepo.googleapis.com", "cloudresourcemanager.googleapis.com", "servicenetworking.googleapis.com"] 
}