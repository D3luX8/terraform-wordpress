output "sg_output" {

  value = {
    bastion_sg   = aws_security_group.bastion_sg.id
    appserver_sg = aws_security_group.appserver_sg.id
    alb_sg       = aws_security_group.alb_sg.id
    db_sg        = aws_security_group.db_sg.id
  }
}



