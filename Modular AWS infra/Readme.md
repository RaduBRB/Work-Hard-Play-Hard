# Modular AWS Infrastructure with ECS, Lambda, RDS & Monitoring (Terraform)

A production-style, multi-compute AWS architecture built entirely with Terraform modules.

This project includes:
- VPC + Subnets + Routing
- ECS Cluster (primary compute layer)
- Lambda (serverless compute)
- EC2 (optional compute)
- RDS Database
- CloudWatch Monitoring
- SNS Alerts
- IAM Roles & Policies
- Optional integrations (S3 triggers, API Gateway, ALB autoscaling)

## 🗺️ Roadmap (Milestones)

### **PART 1 — Project Setup**
- Create folder structure
- Configure providers
- Create empty module templates

### **PART 2 — Networking**
- VPC
- Subnets
- IGW + NAT
- Route tables
- Security groups

### **PART 3 — ECS (Primary Compute Layer)**
- ECS cluster
- Task definition
- ECS service
- ECR repository
- ALB integration
- IAM task roles
- Autoscaling

### **PART 4 — EC2 (Optional)**
- Launch template
- IAM instance role
- Security groups

### **PART 5 — Lambda**
- Lambda function
- IAM execution role
- CloudWatch log groups

### **PART 6 — RDS**
- Subnet group
- Parameter group
- Security groups
- SSM for credentials

### **PART 7 — Monitoring & Alerts**
- CloudWatch metrics
- ECS alarms
- RDS alarms
- SNS notifications

### **PART 8 — Optional Enhancements**
- S3 → Lambda triggers
- API Gateway → Lambda
- ALB autoscaling
- VPC Flow Logs
- CloudWatch dashboards

---

## 🎯 Goals

By the end of this project, you will understand:
- How to design a real AWS architecture
- How to deploy ECS, Lambda, EC2, and RDS together
- How to build reusable Terraform modules
- How to manage dependencies cleanly
- How to monitor and alert on containers, compute, and databases
- How to structure Terraform like a professional cloud engineer

---

## 🏗️ Deployment

