output "ec2_output" {

  value = {
    xyz         = var.public_subnet_id
    role_policy = aws_iam_role_policy.wp-tf_test_policy.id
    iam_role    = aws_iam_role.wp-tf_test_role.id
    iam         = aws_iam_instance_profile.wp-tf_profile_1
  }

}