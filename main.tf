module "automation" {
  source        = "./generic/modules/automation"
  instance_name = ["test-web01"]
  salt_master   = false
}
