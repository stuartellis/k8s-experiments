# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

locals {
  handle          = "${var.stack_name}"
  standard_prefix = "${var.environment_name}-${var.variant}-${local.handle}"
}
