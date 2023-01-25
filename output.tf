output "all_op_values" {
  value = {

    vpc_output = module.vpc.vpc_output
    sg_output  = module.sg.sg_output
    ec2        = module.ec2.ec2_output
    alb_output = module.alb.alb_output
    asg_output = module.asg.asg_output
    rds_output = module.rds.rds_output
  }
}