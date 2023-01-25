resource "aws_lb" "albtf" {
  name               = "albtf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_output.alb_sg]
  subnets            = var.vpc_output.public_subnet

  enable_deletion_protection = true

}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.albtf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtg.arn
  }

}


resource "aws_lb_target_group" "albtg" {
  name     = "albtftg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_output.vpc_id
}