resource "kubernetes_config_map" "aws_auth" {
  depends_on = [module.eks]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = aws_iam_role.eks_role.arn
        username = "eks-role"
        groups   = ["system:masters"]
      }
    ])

    mapUsers = jsonencode([
      {
        userarn  = aws_iam_user.eks_user.arn
        username = "eks-user"
        groups   = ["system:masters"]
      }
    ])
  }
}