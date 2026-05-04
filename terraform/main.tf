locals {
  flux_operator_values = file("${path.module}/values/flux-operator.values.yml")
  flux_instance_values = file("${path.module}/values/flux-instance.values.yml")
}

resource "helm_release" "flux_operator" {
  name             = "flux-operator"
  repository       = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart            = "flux-operator"
  version          = var.flux_operator_chart_version
  namespace        = var.flux_namespace
  create_namespace = true
  wait             = true
  wait_for_jobs    = true

  values = [
    local.flux_operator_values
  ]
}

resource "helm_release" "flux_instance" {
  name             = "flux-instance"
  repository       = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart            = "flux-instance"
  version          = var.flux_instance_chart_version
  namespace        = var.flux_namespace
  create_namespace = true
  wait             = true
  wait_for_jobs    = true

  values = [
    local.flux_instance_values
  ]
  depends_on = [helm_release.flux_operator]
}
