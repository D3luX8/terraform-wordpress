output "asg_output" {

  value = {
    lt_id = aws_launch_template.wp-tf_lt.id

  }

}