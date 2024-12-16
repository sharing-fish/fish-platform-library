output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_token" {
  description = "The authentication token for the EKS cluster"
  value       = data.aws_eks_cluster_auth.cluster.token
}