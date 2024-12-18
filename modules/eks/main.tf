provider "aws" {
  region = var.region
}

# the cluster woof
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
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
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
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  }
}