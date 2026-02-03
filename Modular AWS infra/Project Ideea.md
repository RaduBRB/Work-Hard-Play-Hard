THE PROJECT: “Modular AWS Infrastructure with Compute, Serverless, Database & Monitoring”
I’ll build a real architecture that includes:
- VPC
- Public & private subnets
- Internet Gateway & NAT Gateway
- Route tables
- EC2 instance(s)
- Lambda function (with full explanation)
- RDS database
- SNS topic for alerts
- CloudWatch alarms & logs
- IAM roles & policies
- Optional extras (S3, API Gateway, Load Balancer)
All organised into Terraform modules.
project/
  main.tf
  variables.tf
  outputs.tf
  providers.tf

  modules/
    vpc/
    subnets/
    igw/
    nat/
    route_tables/
    ec2/
    lambda/
    rds/
    sns/
    cloudwatch/
    iam/

🗂️ ROADMAP — BROKEN INTO PARTS (Your multi‑day plan)
Each part is a self‑contained milestone.
PART 1 — Project Setup & Module Skeletons
Goal: Build the folder structure, providers, and empty module templates.
I’ll learn:
- How to structure a multi‑module project
- How to pass variables between modules
- How to keep code clean and reusable

PART 2 — VPC + Subnets + Routing
Goal: Build the full network foundation.
Modules:
- vpc
- subnets
- igw
- nat
- route_tables
I’ll learn:
- CIDR planning
- Public vs private subnets
- NAT vs IGW
- Route table associations
- How modules depend on each other
This becomes your “production‑ready” network.

PART 3 — EC2 Module (Compute Layer)
Goal: Deploy an EC2 instance in a private subnet.
Modules:
- ec2
- iam (instance role)
- security_groups
I'll learn:
- Launch templates
- User data
- IAM roles for EC2
- Security group design
- How to expose EC2 via public subnet or ALB (optional)

PART 4 — Lambda Function (Serverless Layer)
Goal: Deploy my first Lambda function with Terraform.
Modules:
- lambda
- iam (lambda execution role)
- cloudwatch (logs)
I’ll learn:
- How Lambda works
- How to package code (zip)
- How to attach IAM permissions
- How to trigger Lambda (SNS, API Gateway, CloudWatch Events)
This is usually the part people struggle with — I’ll explain everything step by step.

PART 5 — RDS Database (Persistence Layer)
Goal: Deploy a secure RDS instance in private subnets.
Modules:
- rds
- security_groups
I’ll learn:
- Subnet groups
- Parameter groups
- DB security
- Storing credentials in SSM
- Connecting EC2 → RDS
- Why RDS must be private

PART 6 — Monitoring & Alerts
Goal: Add observability to the system.
Modules:
- cloudwatch
- sns
I’ll learn:
- CloudWatch metrics
- Alarms (CPU, status checks, DB connections)
- SNS notifications (email/SMS)
- Lambda → SNS alerts
- EC2 → SNS alerts
This is where the architecture becomes “production‑like.”

PART 7 — Optional Extras (Choose Your Adventure)
I can add any of these:
Option A — S3 Bucket + Lambda Trigger
- Upload file → triggers Lambda
- Lambda processes file
- Sends SNS alert
Option B — API Gateway + Lambda
- Build a serverless API
- Add authentication
- Add logging
Option C — Application Load Balancer
- Put EC2 behind ALB
- Add health checks
- Add autoscaling (you already know this)
Option D — VPC Flow Logs
- Capture traffic logs
- Store in S3 or CloudWatch

🎯 What I gain from this project
By the end, I’ll understand:
- How to design a real AWS architecture
- How to break infrastructure into reusable modules
- How to manage dependencies cleanly
- How to deploy serverless + compute + database together
- How to monitor and alert on your system
- How to structure Terraform like a professional cloud engineer
This is the kind of project that belongs in a portfolio.
