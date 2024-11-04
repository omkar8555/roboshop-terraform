module "ec2" {
  for_each       = var.instances
  source         = "./modules"
  env            = var.env
  app_port       = each.value["app_port"]
  component_name = each.key
  instance_type  = each.value["instance_type"]
}