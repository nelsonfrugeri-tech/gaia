provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "eks-demo-key-pair" {
  key_name   = "eks-demo-key-pair"
  public_key = file("~/.ssh/gaia_rsa.pub")
}

output "key_name" {
  value = aws_key_pair.eks-demo-key-pair.key_name
}
