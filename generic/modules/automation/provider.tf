provider "google" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = file("${path.module}/secrets/secret.json")
}

provider "google-beta" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = file("${path.module}/secrets/secret.json")
}
