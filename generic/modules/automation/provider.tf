variable "path" {
  type    = string
  default = "./secrets"
}

provider "google" {
  project = "quickstart-terraform"
  region  = "europe-north1"
  # credentials = "${var.path}/secret.json"
}

provider "google-beta" {
  project = "quickstart-terraform"
  region  = "europe-north1"
  # credentials = "${var.path}/secret.json"
}
