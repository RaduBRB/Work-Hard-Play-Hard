resource "aws_autoscaling_group" "Terra_ASG" {
  name                = "ASG-new"
  vpc_zone_identifier = [aws_subnet.TerraSubnet1.id, aws_subnet.TerraSubnet2.id]
  target_group_arns   = [aws_lb_target_group.ALB1.arn]
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id      = aws_launch_template.amazon_linux.id
    version = "$Latest"
  }
}
