variable "resource_limits" {
  description = "The deployment resource limits"
  type = object({
    cpu    = string
    memory = string
  })
  default = {
    cpu    = "60m"
    memory = "50Mi"
  }
}

variable "resource_requests" {
  description = "The deployment resource requests"
  type = object({
    cpu    = string
    memory = string
  })
  default = {
    cpu    = "30m"
    memory = "30Mi"
  }
}

variable "image_tag" {
  description = "Image tag of State Metrics"
  type        = string
  default     = "v1.9.8"
}