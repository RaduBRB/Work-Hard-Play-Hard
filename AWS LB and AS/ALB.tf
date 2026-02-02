
resource "aws_lb" "terra_alb" {
  name               = "appLB"
  internal           = false #AWS automatically gives the alb public ip, public dns and internet reachability
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb.id]
  subnets = [aws_subnet.TerraSubnet1.id,
  aws_subnet.TerraSubnet2.id]

  enable_deletion_protection = true
}
resource "aws_lb_target_group" "ALB1" {
  name     = "Terra-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.TerraVPC.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}

#The alb listener is a key component as this is what connects the ALB -> Target Group -> EC2 Instance
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.terra_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB1.arn
  }

}