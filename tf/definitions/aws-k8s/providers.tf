# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

provider "aws" {

  assume_role {
    role_arn = var.tf_exec_role_arn
  }

  default_tags {
    tags = {
      Environment = var.environment_name
      Product     = var.product_name
      Provisioner = "Terraform"
      Stack       = var.stack_name
      Variant     = var.variant
    }
  }
}

# Provider alias to use AWS region us-east-1  
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  assume_role {
    role_arn = var.tf_dns_exec_role_arn
  }
}

# Manages the default EKS cluster
provider "kubernetes" {
  host                   = module.eks_cluster_0015.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster_0015.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster_0015.token
}

# Deploys manifests to the default EKS cluster
provider "kubectl" {
  host                   = module.eks_cluster_0015.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster_0015.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster_0015.token
  load_config_file       = false
  apply_retry_count      = var.eks_kubectl_apply_retry_count
}
