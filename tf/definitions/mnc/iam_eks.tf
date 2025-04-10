# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

module "cluster_0020_iam_eks_vpc_cni_role" {
  source                = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version               = "5.39.1"
  role_name             = "${local.eks_cluster_name_prefix}-vpc-cni"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks_cluster_0020.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
}
