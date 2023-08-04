provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 19.0"

  cluster_name    = "eks-cluster-demo"
  cluster_version = "1.27"
  cluster_endpoint_public_access  = true

  vpc_id          = "vpc-0b3cb0ba36cb1f7eb"
  subnet_ids = ["subnet-03f7fb399ceb0674d", "subnet-0dd23de8dbd591a9d", "subnet-0fe9436cd0ca116eb"]

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 3
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKSWorkerNodePolicy"
      username = "AmazonEKSWorkerNodePolicy"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKS_CNI_Policy"
      username = "AmazonEKS_CNI_Policy"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEC2ContainerRegistryReadOnly"
      username = "AmazonEC2ContainerRegistryReadOnly"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/SecretsManagerReadWrite"
      username = "SecretsManagerReadWrite"
      groups   = ["system:masters"]
    },
  ]
}

# Caller account
data "aws_caller_identity" "current" {}

variable "key_name" {
  description = "Nome da chave EC2 para acessar os nós"
  type        = string
}
