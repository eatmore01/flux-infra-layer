variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"

  validation {
    condition     = can(file(var.kubeconfig_path)) || var.kubeconfig_path == ""
    error_message = "kubeconfig_path must point to an existing file or be empty."
  }
}

variable "kubeconfig_context" {
  default = "kubernetes-admin@cluster.local"
  type    = string
}

variable "flux_namespace" {
  description = "Kubernetes namespace where Flux Operator and Flux Instance are deployed"
  type        = string
  default     = "flux-system"

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.flux_namespace))
    error_message = "flux_namespace must be a valid Kubernetes namespace name (lowercase, alphanumeric, hyphens)."
  }
}


# https://artifacthub.io/packages/helm/flux-operator/flux-operator
variable "flux_operator_chart_version" {
  description = "Version of the flux-operator Helm chart to deploy"
  type        = string
  default     = "0.48.0"
}

variable "flux_instance_chart_version" {
  description = "Version of the flux-instance Helm chart to deploy"
  type        = string
  default     = "0.48.0"
}
