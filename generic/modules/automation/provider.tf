provider "google" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = file("secret.json")
}

provider "google-beta" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = file("secret.json")
}
