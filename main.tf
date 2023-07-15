module "automation" {
  source        = "./generic/modules/automation"
  instance_name = ["test-saltmaster01"]
  salt_master   = true
}
