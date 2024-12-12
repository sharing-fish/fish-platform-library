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
variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}