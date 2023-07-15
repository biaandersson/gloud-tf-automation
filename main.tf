module "automation" {
  source        = "./generic/modules/automation"
  instance_name = ["test-web02"]
  salt_master   = false
}
