resource "kubernetes_manifest" "state_metrics_sa" {
  manifest = {
    apiVersion = "v1"
    kind       = "ServiceAccount"

    metadata = {
      namespace = kubernetes_namespace.main.metadata[0].name
      name      = local.state_metrics_name

      labels = {
        app = local.state_metrics_name
      }
    }

    automountServiceAccountToken = false
  }
}

resource "kubernetes_secret" "state_metrics_sa" {
  metadata {
    name      = "${local.state_metrics_name}-token"
    namespace = kubernetes_namespace.main.metadata[0].name

    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_manifest.state_metrics_sa.manifest.metadata.name
    }
  }

  type = "kubernetes.io/service-account-token"
}