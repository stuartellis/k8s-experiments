# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

locals {
  eks_cluster_name_prefix = "${var.environment_name}-${var.variant}"
  ebs_claim_name          = "ebs-volume-pv-claim-${var.environment_name}-${var.variant}"
}
