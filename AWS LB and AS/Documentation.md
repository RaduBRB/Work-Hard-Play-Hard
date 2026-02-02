I wanted to challenge myself by building a full AWS autoscaling architecture entirely with Terraform — no console clicking, no shortcuts. My goal was to create something production‑like: a VPC, public subnets, an internet gateway, a load balancer, an auto scaling group, and EC2 instances that configure themselves automatically using user‑data.
It turned out to be a much deeper learning experience than I expected. I didn’t just “get it working”; I learned how AWS actually behaves under the hood, especially when Terraform is involved. This is the full story of what I built, what went wrong, and how I fixed it.

🌐 1. Building the VPC and Networking
I started by creating a VPC with a /16 CIDR block. Inside it, I created two public subnets in different availability zones. I made sure each subnet had map_public_ip_on_launch = true, because I knew my EC2 instances would need public IPs to install packages during boot.
Next, I added an Internet Gateway and a route table with a 0.0.0.0/0 route pointing to it. I associated both subnets with this route table, officially making them public subnets.
At this point, the networking layer was ready: the subnets could reach the internet, and anything launched inside them should have outbound access.

🔐 2. Creating Security Groups
I created two security groups:
- One for the Application Load Balancer
- One for the EC2 instances
The ALB SG allowed inbound HTTP from anywhere.
The EC2 SG allowed inbound HTTP only from the ALB SG, which is the correct, secure pattern.
At this point, I thought everything was perfect. Spoiler: it wasn’t.

🚀 3. Writing the Launch Template
I created a launch template that used Amazon Linux, installed Apache via user‑data, and wrote a simple “Hello from ASG instance” message to /var/www/html/index.html.
I also added:
associate_public_ip_address = true


so that instances would get public IPs. This part turned out to be crucial later.

📈 4. Creating the Auto Scaling Group and Load Balancer
I created:
- An Application Load Balancer spanning both subnets
- A target group with health checks
- An Auto Scaling Group that launched EC2 instances using my launch template
Everything applied cleanly. Terraform showed no errors.
I expected to see healthy instances behind the ALB.
Instead, everything was unhealthy.

🐛 5. The Troubleshooting Journey
This is where the real learning began.
Problem 1: EC2 instances were always unhealthy
The ALB kept marking every instance as unhealthy. I checked the system logs and noticed something strange: the user‑data script wasn’t running. Apache wasn’t installed. Port 80 wasn’t open.
That meant the instance couldn’t reach the internet to install packages.
Problem 2: I couldn’t SSH into the instances
Even when I tried to SSH into the instances, the connection failed. That told me something was fundamentally wrong with networking.
Problem 3: Outbound traffic was blocked
This was the big discovery.
Terraform does not add default outbound rules to security groups.(Although the UI version does, check terraform documentation for more information)
The AWS console does — but Terraform doesn’t.
My EC2 security group had no outbound rule, which meant:
- No internet access
- No yum
- No Apache
- No user‑data
- No health checks
Once I added the correct outbound rule, everything changed.
Problem 4: I had created manual network interfaces
At one point, I created ENIs manually for each subnet. I assumed the ASG would use them. It doesn’t. ASGs create their own ENIs.
My manual ENIs were unused and confusing the situation, so I removed them.
Problem 5: ALB SG needed an outbound rule
Even though security groups are stateful, the ALB SG still needed an explicit outbound rule for Terraform to manage it cleanly. Once I added that, the ALB could reliably communicate with EC2.
Problem 6: SSH wasn’t allowed
I had forgotten to add an inbound SSH rule to the EC2 SG. Once I added it, I could finally connect and verify that Apache was running.

🎉 6. The Moment Everything Worked
After fixing the outbound rules, cleaning up the ENIs, and ensuring the launch template assigned public IPs, the ASG launched new instances.
This time:
- user‑data ran
- Apache installed
- the index page was created
- port 80 opened
- the ALB health checks passed
Seeing the target group flip to healthy was the moment everything clicked.

🧠 7. What I Learned
This project taught me more than I expected:
- Terraform does not add default outbound rules
- ASGs do not use manually created ENIs
- Public subnets require both a route to the IGW and public IP assignment
- Launch templates must explicitly assign public IPs
- ALB → EC2 communication depends on correct SG rules
- Health checks are the truth — if they fail, something deeper is wrong
- Debugging cloud infrastructure is about following the chain of dependencies
Most importantly, I learned how to think like an AWS engineer:
start at the network, follow the traffic, and verify each layer.

📌 8. Final Thoughts
This wasn’t just an exercise in writing Terraform.
It was an exercise in understanding how AWS actually works.
I didn’t just build an autoscaling architecture — I debugged it, broke it, fixed it, and learned the logic behind every moving part.
If you’re reading this on GitHub, I hope this walkthrough helps you understand not just what I built, but how I approached the problems and solved them.
Another thing that I've learned is the fact that using every resource at your hand is working smart not being lazy. In a continuously evolving world we have to use new tools to keep up.

