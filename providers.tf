terraform {
  required_version = ">= 1.2.1" 
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11" 
    }
  }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
  config_context = "minikube"
}