########## Bastion Security Group ###########

# locals {
# inbound_ports = var.sg_values.bastion.inbound_ports
# outbound_ports = var.sg_values.bastion.outbound_ports
# # inbound_ports_app=var.sg_values.appserver_sg.inbound_ports_app
# # outbound_ports_app=var.sg_values.appserver_sg.outbound_ports_app
# }

resource "aws_security_group" "bastion_sg" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.bastion_values.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.bastion_values.outbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    }
  }

  tags = {
    Name = "bastion_sg"
  }
}

######### DataBase-Server Security Group ###########

resource "aws_security_group" "db_sg" {

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.db_server_values.inbound_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = [aws_security_group.appserver_sg.id]

    }
  }
  dynamic "egress" {
    for_each = var.db_server_values.outbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    }
  }
}

########## ALB Security Group ###########

resource "aws_security_group" "alb_sg" {

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.alb_values.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }
  dynamic "egress" {
    for_each = var.alb_values.outbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    }
  }
}

########## App-Server Security Group ###########

resource "aws_security_group" "appserver_sg" {

  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "appserver_sg"
  }

}