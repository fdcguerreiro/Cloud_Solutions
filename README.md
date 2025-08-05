
# Cloud Solutions Inc. Terraform Project

This project provisions a secure, scalable, and global infrastructure on AWS using Terraform. It supports multiple environments (e.g. `dev`, `prod`) and stores Terraform state in a remote backend using S3 and DynamoDB for safe, concurrent usage.

---

## Project Structure

```
cloud-solutions-app/
├── setup-backend.tf             # Initializes remote state infrastructure (run once)
├── modules/                     # Reusable Terraform modules
│   ├── compute/                 # EC2 & Auto Scaling
│   ├── load_balancer/          # Application Load Balancer
│   ├── monitoring/             # CloudWatch setup
│   ├── network/                # VPC, subnets, routing
│   ├── state-backend/          # S3 + DynamoDB backend resources
│   └── storage/                # S3 buckets
├── environments/
│   ├── dev/                    # Dev environment
│   │   ├── main.tf
│   │   └── backend.tf
│   └── prod/                   # Prod environment
│       ├── main.tf
│       └── backend.tf
├── main.tf                     # Main module orchestrator
├── provider.tf                 # AWS provider configuration
├── variables.tf                # Global variables
├── outputs.tf                  # Global outputs
└── README.md                   # You're reading it!
```

---

## Initial Setup (one-time only)

Before deploying environments, create the remote backend infrastructure:

### 1. Deploy Remote Backend (S3 + DynamoDB)

```bash
cd cloud-app-terraform
terraform init
terraform apply -target=module.state_backend
```

This will:

- Create an S3 bucket with versioning enabled
- Create a DynamoDB table for state locking

---

## Deploying Environments

Each environment has its own isolated configuration and state.

### 2. Deploy `dev` Environment

```bash
cd environments/dev
terraform init        # Initializes and connects to remote backend
terraform plan
terraform apply
```

### 3. Deploy `prod` Environment

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

>  Each environment uses its own backend configuration (see `backend.tf` inside each folder).

---

## Remote State Details

- **S3 Bucket**: `terraform-state-cloud-app`
- **DynamoDB Table**: `terraform-locks`
- **Encryption**: Enabled
- **State Key Format**:
  - `dev/terraform.tfstate`
  - `prod/terraform.tfstate`

---

## Key Modules

| Module         | Purpose                                     |
|----------------|---------------------------------------------|
| `network`      | VPC, subnets, internet/NAT gateway          |
| `compute`      | EC2 instances + Auto Scaling                |
| `load_balancer`| Application Load Balancer                   |
| `storage`      | S3 bucket for logs or static assets         |
| `monitoring`   | CloudWatch log groups                       |
| `state-backend`| Remote state infra (S3 + DynamoDB)          |

---

## Requirements

- Terraform ≥ 1.5.0
- AWS CLI configured with appropriate credentials
- AWS IAM user with permissions for:
  - EC2
  - VPC
  - S3
  - DynamoDB
  - CloudWatch
  - IAM (if needed)

---


