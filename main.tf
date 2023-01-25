module "vpc" {

  source     = "./modules/vpc"
  vpc_values = var.vpc_values

}


module "asg" {
   source       = "./modules/asg"
   appserver_sg = module.sg.sg_output.appserver_sg
   vpc_output   = module.vpc.vpc_output.private_subnet
   ec2_output   = module.ec2.ec2_output
   alb_output   = module.alb.alb_output
   asg_values   = var.asg_values

}

module "ec2" {
  source           = "./modules/ec2"
  public_subnet_id = module.vpc.vpc_output.public_subnet
  sg_output        = module.sg.sg_output
  ec2_values       = var.ec2_values
}

module "alb" {
  source         = "./modules/alb"
  vpc_output     = module.vpc.vpc_output
  sg_output      = module.sg.sg_output
}

module "rds" {
  source     = "./modules/rds"
  ssm_values = var.ssm_values
  vpc_output = module.vpc.vpc_output
  sg_output  = module.sg.sg_output
  rds_values = var.rds_values
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_output.vpc_id
  bastion_values = var.bastion_values
  db_server_values = var.db_server_values
  alb_values = var.alb_values
}