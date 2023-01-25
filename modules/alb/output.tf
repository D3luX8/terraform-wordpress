output "alb_output" {

  value = {
    tg_arn = aws_lb_target_group.albtg.arn

  }

}