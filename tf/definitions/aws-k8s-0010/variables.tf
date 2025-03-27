# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

variable "eks_cluster_config" {
  type = object({
    k8s_version                      = string
    endpoint_public_access           = bool
    enable_creator_admin_permissions = bool
    subnet_ids                       = list(string)
    vpc_id                           = string
  })
}

variable "eks_kubectl_apply_retry_count" {
  type    = number
  default = 5
}
