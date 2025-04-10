# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

data "aws_caller_identity" "current" {}

data "aws_vpc" "main" {
  id = var.eks_cluster_config["vpc_id"]
}

data "aws_route53_zone" "domain" {
  provider = aws.us-east-1
  name     = var.app_domain_name
}
