
resource "kubernetes_deployment" "main" {
  metadata {
    name      = local.state_metrics_name
    namespace = kubernetes_namespace.main.metadata[0].name

    labels = {
      app = local.state_metrics_name
    }
  }

  spec {
    replicas = 1

    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        app = local.state_metrics_name
      }
    }

    progress_deadline_seconds = 180

    template {
      metadata {
        namespace = kubernetes_namespace.main.metadata[0].name
        labels = {
          app = local.state_metrics_name
        }

        annotations = {
          # Full DD integradion doc:
          # https://github.com/DataDog/integrations-core/blob/master/kubernetes_state/datadog_checks/kubernetes_state/data/conf.yaml.example
          "ad.datadoghq.com/state-metrics.check_names"  = jsonencode(["kubernetes_state"])
          "ad.datadoghq.com/state-metrics.init_configs" = "[{}]"
          "ad.datadoghq.com/state-metrics.instances" = jsonencode([{
            kube_state_url          = "http://%%host%%:18080/metrics"
            prometheus_timeout      = 30
            min_collection_interval = 30
            telemetry               = true
            label_joins = {
              kube_deployment_labels = {
                labels_to_match = ["deployment"]
                labels_to_get = [
                  "label_app",
                  "label_deploy_env",
                  "label_type",
                  "label_magic_net",
                  "label_canary",
                ]
              }
            }
            labels_mapper = {
              # We rename following labels because app and deploy_env are our "well known labels"
              label_app        = "app"
              label_deploy_env = "deploy_env"
            }
          }])
        }
      }

      spec {
        enable_service_links            = false
        service_account_name            = kubernetes_manifest.state_metrics_sa.manifest.metadata.name
        automount_service_account_token = true

        host_network = true

        container {
          image                    = "k8s.gcr.io/kube-state-metrics/kube-state-metrics:${var.image_tag}"
          image_pull_policy        = "IfNotPresent"
          name                     = local.state_metrics_name
          termination_message_path = "/dev/termination-log"
          command = [
            "/kube-state-metrics",
            "--port=18080",
            "--telemetry-port=18081",
          ]

          readiness_probe {
            http_get {
              path = "/healthz"
              port = "18080"
            }

            initial_delay_seconds = 5
            timeout_seconds       = 5
          }

          resources {
            requests = var.resource_requests
            limits   = var.resource_limits
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_cluster_role_binding.main,
  ]
}