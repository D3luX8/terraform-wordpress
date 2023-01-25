vpc_values = {
  vpc_cidr_block            = "10.0.0.0/16"
  public_subnet_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]
}

ssm_values = {
  db_password = "admin123"
  db_name     = "tfdb"
  db_username = "admin"
}


asg_values = {
  instance_ami         = "ami-0fe23c115c3ba9bac"
  keypair_name         = "wp-tf"
  instances_desired_no = "1"
  instances_max_no     = "1"
  instances_min_no     = "1"
  instance_type        = "t2.micro"
}

ec2_values = {
  instance_ami_ec2  = "ami-0fe23c115c3ba9bac"
  keypair_name_ec2  = "wp-tf"
  instance_type_ec2 = "t2.micro"
}

rds_values = {
  db_engine            = "mysql"
  db_engine_version    = "8.0"
  db_instance_class    = "db.t2.micro"
  db_allocated_storage = "10"
}

bastion_values = {

  inbound_ports  = ["22"]
  outbound_ports = ["0"]

}

db_server_values = {
  inbound_ports  = ["3306"]
  outbound_ports = ["0"]

}

alb_values = {
  inbound_ports  = ["80", "443"]
  outbound_ports = ["0"]
}