provider "google" {
  credentials = "${file("credentials.json")}"
  project = "focal-time-241415"
  region = "us-central1"
}
