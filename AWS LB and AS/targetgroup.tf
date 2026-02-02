# This target group is the component that 
#-receives traffic from the Applicaiton Load Balancer
#-knows which EC2 isntance belong to it
#-runs health checks
#-tells the ALB which instances are healthy
#-allows the ASG to automatically register/deregister instances
#-Meeting point between tehe ALB and EC2
resource "aws_lb_target_group" "TerraTG" {
  name     = "asg-taget-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.TerraVPC.id

  health_check {
    path                = "/" #checks the root page
    protocol            = "HTTP"
    matcher             = "200" #expects a 200 OK
    interval            = 30    #checks every 30 seconds
    timeout             = 5
    healthy_threshold   = 2 #needs 2 good checks to be healthy
    unhealthy_threshold = 2 #needs 2 failures to be unhealthy


  }

}
  