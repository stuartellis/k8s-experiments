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

variable "k8s_cluster_hostname" {
  type = string
}

variable "app_domain_name" {
  type = string
}

variable "tf_dns_exec_role_arn" {
  type = string
}

variable "tf_exec_role_arn" {
  type = string
}
