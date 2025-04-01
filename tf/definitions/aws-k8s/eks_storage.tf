# SPDX-FileCopyrightText: 2025-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#

resource "kubernetes_storage_class" "ebs_cluster_0015" {
  metadata {
    name = "ebs-storage-class"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "ebs.csi.eks.amazonaws.com"
  reclaim_policy      = "Delete"
  volume_binding_mode = "WaitForFirstConsumer"

  parameters = {
    type      = "gp3"
    encrypted = "true"
  }

  depends_on = [module.eks_cluster_0015]
}

resource "kubernetes_persistent_volume_claim_v1" "ebs_pvc_cluster_0015" {
  metadata {
    name = local.ebs_claim_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "2Gi"
      }
    }

    storage_class_name = "ebs-storage-class"

  }

  wait_until_bound = false

  depends_on = [module.eks_cluster_0015]
}
