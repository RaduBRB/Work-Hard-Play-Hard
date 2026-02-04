                          ┌──────────────────────────────┐
                          │            AWS               │
                          │      (Your Architecture)     │
                          └──────────────────────────────┘
                                      │
                                      ▼
                        ┌──────────────────────────┐
                        │         VPC              │
                        │   10.0.0.0/16            │
                        └──────────────────────────┘
                          │                    │
          ┌───────────────┘                    └──────────────────────┐
          ▼                                                            ▼
┌──────────────────────┐                                   ┌──────────────────────┐
│   Public Subnets      │                                   │   Private Subnets     │
│  (ALB, NAT Gateway)   │                                   │ (ECS, RDS, Lambda)    │
└──────────────────────┘                                   └──────────────────────┘
          │                                                            │
          ▼                                                            ▼
┌──────────────────────┐                                   ┌────────────────────────┐
│ Application Load      │  <─── routes traffic ───         │ ECS Cluster            │
│ Balancer (ALB)        │                                   │ - ECS Service         │
└──────────────────────┘                                   │ - Task Definition     │
          │                                                │ - Containers (ECR)     │
          ▼                                                └────────────────────────┘
┌────────────────────────┐                                  │
│   ECS Service           │                                  │
│   (Fargate or EC2)      │                                  ▼
└────────────────────────┘                        ┌────────────────────────┐
                                                  │ RDS Database (Private) │
                                                  │ - Subnet Group         │
                                                  │ - Security Groups      │
                                                  └────────────────────────┘
                                                              │
                                                              ▼
                                                  ┌────────────────────────┐
                                                  │ CloudWatch Monitoring  │
                                                  │ - ECS metrics          │
                                                  │ - RDS metrics          │
                                                  │ - Lambda logs          │
                                                  └────────────────────────┘
                                                              │
                                                              ▼
                                                  ┌────────────────────────┐
                                                  │ SNS Alerts             │
                                                  │ - Email/SMS            │
                                                  └────────────────────────┘

Optional:
- EC2 instance in private subnet
- S3 → Lambda triggers
- API Gateway → Lambda
- VPC Flow Logs → S3/CloudWatch