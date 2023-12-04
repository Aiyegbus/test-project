resource "aws_alb" "main_lb" {
  name               = "public-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer.id]
  subnets            = aws_subnet.main_sub.*.id
}

resource "aws_lb_target_group" "main_lb_target" {
  name        = "Load-balancer-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/health_check"
    interval            = "30"
    timeout             = "3"
    matcher             = "200"
    healthy_threshold   = "3"
    protocol            = "HTTP"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_listener" "main_lb_listener" {
  load_balancer_arn = aws_alb.main_lb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_lb_target.id
  }
}
