module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

module "compute" {
  source       = "./modules/compute"
  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  subnets      = module.network.private_subnets
  security_group_ids = [module.network.ec2_sg_id]
}

module "load_balancer" {
  source       = "./modules/load_balancer"
  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  public_subnets = module.network.public_subnets
  target_group_arns = [module.compute.target_group_arn]
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}

module "monitoring" {
  source       = "./modules/monitoring"
  project_name = var.project_name
}
