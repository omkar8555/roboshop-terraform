module "ec2" {
    for_each = var.instance
    source = "./modules"
    env = var.env
    app_port = each.value["app_port"]
    component_name = each.key
    instance_name = each.value["instance_name"]
    }