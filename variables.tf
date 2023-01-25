
variable "vpc_values" {
  type = object({
    public_subnet_cidr_block  = list(string)
    private_subnet_cidr_block = list(string)
    vpc_cidr_block            = string
  })
}

variable "ssm_values" {
  type = object({
    db_password = string
    db_name     = string
    db_username = string
  })
}


variable "asg_values" {
  type = object({

    instance_ami         = string
    keypair_name         = string
    instances_desired_no = string
    instances_max_no     = string
    instances_min_no     = string
    instance_type        = string
  })
}

variable "ec2_values" {
  type = object({

    instance_ami_ec2  = string
    keypair_name_ec2  = string
    instance_type_ec2 = string
  })
}

variable "rds_values" {
  type = object({

    db_engine            = string
    db_engine_version    = string
    db_instance_class    = string
    db_allocated_storage = string
  })
}


variable "bastion_values" {
  type = object({

    inbound_ports  = list(string)
    outbound_ports = list(string)

  })
}

variable "db_server_values" {
  type = object({

    inbound_ports  = list(string)
    outbound_ports = list(string)

  })
}

variable "alb_values" {
  type = object({

    inbound_ports  = list(string)
    outbound_ports = list(string)

  })
}
