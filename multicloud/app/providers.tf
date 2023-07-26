provider "google" {
  credentials = file("creds.json")
  project     = jsondecode(file("creds.json")).project_id
  region      = "europe-west1"
}
