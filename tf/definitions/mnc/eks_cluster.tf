# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

module "eks_cluster_0020" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.35"

  cluster_name    = "${local.eks_cluster_name_prefix}-0020"
  cluster_version = var.eks_cluster_config["k8s_version"]

  cluster_endpoint_public_access = var.eks_cluster_config["endpoint_public_access"]

  authentication_mode = "API"

  # Adds the current caller identity as an administrator with a cluster access entry
  enable_cluster_creator_admin_permissions = var.eks_cluster_config["enable_creator_admin_permissions"]

  access_entries = {
    aws_admin_role = {
      kubernetes_groups = []
      principal_arn     = var.human_admins_role_arn
      policy_associations = {
        kubeadmin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }

  vpc_id     = var.eks_cluster_config["vpc_id"]
  subnet_ids = var.eks_cluster_config["subnet_ids"]

  tags = {
    TfModule = "eks_cluster_0020"
  }

  cluster_addons = {
    vpc-cni = {
      most_recent                 = true
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = module.cluster_0020_iam_eks_vpc_cni_role.iam_role_arn
    }
  }

  eks_managed_node_groups = {
    mng0001 = {
      # Starting on 1.30, AL2023_x86_64_STANDARD is the default AMI type for EKS managed node groups
      ami_type       = "AL2_x86_64"
      instance_types = ["m6a.large"]

      min_size     = 2
      max_size     = 6
      desired_size = 2
    }
  }

  eks_managed_node_group_defaults = {
    instance_types = ["m6a.large", "m6i.large"]

    iam_role_attach_cni_policy = true
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      policies                     = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    }

    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 1
    }

    cluster_security_group_additional_rules = {
      node_vpc_cp_access = {
        description = "Allow nodes to access control plane"
        from_port   = 443
        to_port     = 443
        type        = "ingress"
        cidr_blocks = [data.aws_vpc.main.cidr_block]
      }
    }
  }
}

data "aws_eks_cluster_auth" "cluster_0020" {
  name = module.eks_cluster_0020.cluster_name
}
