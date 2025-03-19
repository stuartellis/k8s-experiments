# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

module "eks_cluster_0010" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.34"

  cluster_name    = "${local.eks_cluster_name_prefix}-0010"
  cluster_version = var.eks_cluster_config["k8s_version"]

  # Optional
  cluster_endpoint_public_access = var.eks_cluster_config["endpoint_public_access"]

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = var.eks_cluster_config["enable_creator_admin_permissions"]

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = var.eks_cluster_config["vpc_id"]
  subnet_ids = var.eks_cluster_config["subnet_ids"]

  tags = {
    TfModule = "eks_cluster_0010"
  }
}

data "aws_eks_cluster_auth" "cluster_0010" {
  name = module.eks_cluster_0010.cluster_name
}
