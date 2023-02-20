#!/bin/bash

# This migration assumes we are creating a new Terraform project, rather than adjusting an existing one.
# If adjusting the existing project, simply use terraform state mv instead of import.

echo "Importing namespace resource..."
terraform import module.cluster_addons_state_metrics.kubernetes_namespace.main mon

echo "Importing service account resources..."
terraform import module.cluster_addons_state_metrics.kubernetes_manifest.state_metrics_sa "apiVersion=v1,kind=ServiceAccount,namespace=mon,name=state-metrics"
terraform import module.cluster_addons_state_metrics.kubernetes_secret.state_metrics_sa mon/state-metrics-token

echo "Importing rbac resources..."
terraform import module.cluster_addons_state_metrics.kubernetes_cluster_role.main state-metrics 
terraform import module.cluster_addons_state_metrics.kubernetes_cluster_role_binding.main state-metrics-binding

echo "Importing deployment resource..."
terraform import module.cluster_addons_state_metrics.kubernetes_deployment.main mon/state-metrics