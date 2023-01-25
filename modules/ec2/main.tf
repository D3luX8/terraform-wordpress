########### EC2 Instance ###########
resource "aws_instance" "bastion" {
  ami                    = var.ec2_values.instance_ami_ec2
  instance_type          = var.ec2_values.instance_type_ec2
  availability_zone      = "us-east-2a"
  subnet_id              = var.public_subnet_id.0
  vpc_security_group_ids = [var.sg_output.bastion_sg]
  # iam_instance_profile = var.aws_iam_instance_profile.test_profile
  key_name = var.ec2_values.keypair_name_ec2

  tags = {
    Name = "bastion"
  }
}

########### IAM Policy ###########

resource "aws_iam_role_policy" "wp-tf_test_policy" {
  name = "wp-tf_test_policy"
  role = aws_iam_role.wp-tf_test_role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:DescribeAssociation",
            "ssm:GetDeployablePatchSnapshotForInstance",
            "ssm:GetDocument",
            "ssm:DescribeDocument",
            "ssm:GetManifest",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:ListAssociations",
            "ssm:ListInstanceAssociations",
            "ssm:PutInventory",
            "ssm:PutComplianceItems",
            "ssm:PutConfigurePackageResult",
            "ssm:UpdateAssociationStatus",
            "ssm:UpdateInstanceAssociationStatus",
            "ssm:UpdateInstanceInformation"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "kms:*",
          "Resource" : "*"
        }
      ]
    }
  )
}

########### IAM Role ###########

resource "aws_iam_role" "wp-tf_test_role" {
  name = "wp-tf_test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

########### IAM Instance Profile ###########

resource "aws_iam_instance_profile" "wp-tf_profile_1" {
  name = "wp-tf_profile_1"
  role = aws_iam_role.wp-tf_test_role.id
}