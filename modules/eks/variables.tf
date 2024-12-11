variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Desired EKS cluster name"
  type        = string
  default     = "sharing-fish-eks-cluster"
}