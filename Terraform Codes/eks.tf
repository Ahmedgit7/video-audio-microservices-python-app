# EKS Cluster

resource "aws_eks_cluster" "videotoaudiocluster" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.videotoaudioPublicSubnet1.id,
      aws_subnet.videotoaudioPublicSubnet2.id
    ]
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceController
   ]
  
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.videotoaudiocluster.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.1-eksbuild.11" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.videotoaudiocluster.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.18.1-eksbuild.3" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name                = aws_eks_cluster.videotoaudiocluster.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.30.3-eksbuild.2" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name                = aws_eks_cluster.videotoaudiocluster.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.3.0-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.videotoaudiocluster.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.33.0-eksbuild.1"  # Replace with a compatible version
  resolve_conflicts_on_update = "PRESERVE"
}


output "eks_cluster_status" {
  value = aws_eks_cluster.videotoaudiocluster.status
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.region} --name ${aws_eks_cluster.videotoaudiocluster.name}"
  }

  depends_on = [
    aws_eks_cluster.videotoaudiocluster
  ]
}