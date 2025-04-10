# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

# ARN of AWS role for TF
tf_exec_role_arn = "arn:aws:iam::333594256635:role/stuartellis-org-tf-exec-role"

app_domain_name = "stuartellis.org"

tf_dns_exec_role_arn = "arn:aws:iam::119559809358:role/stuartellis-org-tf-exec-role"

k8s_cluster_hostname = "a0010"

eks_cluster_config = {
  k8s_version                      = "1.27"
  endpoint_public_access           = true
  enable_creator_admin_permissions = true
  subnet_ids                       = ["subnet-07b4d67d", "subnet-5ac87816", "subnet-eca28485", ]
  vpc_id                           = "vpc-ac85d9c4"
}

human_admins_role_arn = "arn:aws:iam::333594256635:role/stuartellis-org-human-ops-role"
