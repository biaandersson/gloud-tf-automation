provider "google" {
  project = "quickstart-terraform"
  region  = "europe-north1"
  # credentials = file("secrets/secret.json")
}

provider "google-beta" {
  project = "quickstart-terraform"
  region  = "europe-north1"
  # credentials = file("secrets/secret.json")
}
