variable "argocd_admin_password" {
  description = "Admin password for ArgoCD"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  type        = string
}

variable "cluster_token" {
  description = "The authentication token for the EKS cluster"
  type        = string
}