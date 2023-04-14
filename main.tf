terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.21.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
}

module "iam" {
  source = "./modules/iam"
  role_name = var.role_name
  s3_bucket_arn = var.s3_bucket_arn
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets = module.vpc.public_subnets
  iam_role_arn = module.iam.iam_role_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "iam_role_arn" {
  value = module.iam.iam_role_arn
}
  
  https://github.com/satya-sw/jenkins-jira-integ/edit/dev-123/main.tf
  

  # webhook test
