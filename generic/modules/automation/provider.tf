provider "google" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = jsondecode(github_actions_secret.CLOUD_JSON)
}

provider "google-beta" {
  project     = "quickstart-terraform"
  region      = "europe-north1"
  credentials = jsondecode(github_actions_secret.CLOUD_JSON)
}
