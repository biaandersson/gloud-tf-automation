variable "path" {
  description = "Path to the google service account credentials file"
  default     = "secrets/"
}

provider "google" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = file("${var.path}/secret.json")
}

provider "google-beta" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = file("${var.path}/secret.json")
}
