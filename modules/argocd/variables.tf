variable "argocd_admin_password" {
  description = "Admin password for ArgoCD"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  type        = string
}

variable "cluster_ca_cert" {
  description = "The certificate authority data for the EKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}