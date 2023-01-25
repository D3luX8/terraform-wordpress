########### Launch Template ###########

resource "aws_launch_template" "wp-tf_lt" {
  name = "wp-tf_lt"

  ebs_optimized = false

  image_id = var.asg_values.instance_ami

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.asg_values.instance_type

  key_name = var.asg_values.keypair_name

  monitoring {
    enabled = false
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.appserver_sg]
  }

  iam_instance_profile {
    name = var.ec2_output.iam.id
  }

  placement {
    availability_zone = "us-east-2a"
  }

  user_data = filebase64("${path.module}/script.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-server"
    }
  }
}

########## Auto Scaling Group ###########

resource "aws_autoscaling_group" "wp-tf_asg" {
  desired_capacity    = var.asg_values.instances_desired_no
  max_size            = var.asg_values.instances_max_no
  min_size            = var.asg_values.instances_min_no
  vpc_zone_identifier = var.vpc_output
  target_group_arns   = [var.alb_output.tg_arn]


  launch_template {
    id      = aws_launch_template.wp-tf_lt.id
    version = "$Latest"
  }
}
