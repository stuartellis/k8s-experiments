# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

locals {
  alb_name_prefix         = "${var.product_name}-${var.environment_name}-${var.variant}"
  app_name                = var.product_name
  eks_cluster_name_prefix = "${var.environment_name}-${var.variant}"
  ebs_claim_name          = "ebs-volume-pv-claim-${var.environment_name}-${var.variant}"

  aws_tags = {
    Environment = var.environment_name
    Product     = var.product_name
    Provisioner = "Terraform"
    Stack       = var.stack_name
    Variant     = var.variant
  }
}
