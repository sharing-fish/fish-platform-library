provider "aws" {
  region = var.region
}

# the cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
  
  access_entries = {
    # One access entry with a policy associated
    cli-user = {
      kubernetes_groups = ["masters"]
      principal_arn = "arn:aws:iam::058264383067:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AWSAdministratorAccess_8011de86a821f726"

      policy_associations = {
        cli-user-admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
    pipeline = {
      kubernetes_groups = ["masters"]
      principal_arn = "arn:aws:iam::058264383067:role/OIDCReadyRole" # from bootsrap oidc provider role

      policy_associations = {
        pipeline-admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  }
}

# # iam role and user to access the cluster
# resource "aws_iam_user" "eks_user" {
#   name = "eks-user"
# }

# resource "aws_iam_user_policy_attachment" "eks_user_attach_policy" {
#   user       = aws_iam_user.eks_user.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role" "eks_role" {
#   name = "eks-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "eks_role_policy" {
#   name   = "eks-role-policy"
#   role   = aws_iam_role.eks_role.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = "sts:AssumeRole"
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_role_attach_policy" {
#   role       = aws_iam_role.eks_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_eks_access_entry" "eks_user_access_entry" {
#   cluster_name      = var.cluster_name
#   principal_arn     = aws_iam_role.eks_role.arn
# }

# resource "aws_eks_access_policy_association" "eks_user_access_policy_association" {
#   cluster_name  = var.cluster_name
#   policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
#   principal_arn = aws_iam_role.eks_role.arn
#   access_scope {
#     type       = "cluster"
#   }
# }