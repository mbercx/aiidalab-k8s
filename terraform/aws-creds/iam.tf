# There are several ways that we could implement a minimal policy set
# The minimal policy set is found here: 
# https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/iam-permissions.md

provider "aws" {
  region  = var.region
  profile = var.profile
}

# Here are a few implementations

# Create a new user named terraform-bot
# Create policy in IAM and attach to terraform-bot
# TODO: You will need to manually generate access keys for this user
# TODO: You will need to manually configure awscli to use these access keys

resource "aws_iam_user" "user" {
  name = "terraform-bot"
}

resource "aws_iam_policy" "terraform_iam_policy" {
    name = "terraform-policy"
    path = "/"
    description = "Permissions for Terraform-controlled EKS cluster creation and management"
    policy = data.aws_iam_policy_document.terraform_iam_policy_source.json
}

resource "aws_iam_user_policy_attachment" "attach-terraform-permissions" {
  user        = aws_iam_user.user.name
  policy_arn  = aws_iam_policy.terraform_iam_policy.arn
}

resource "aws_iam_user_policy_attachment" "attach-efs-policies" {
  user        = aws_iam_user.user.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
}


# Create a role with the policy json
# Allow a user to assume this role
# TODO: You will need to manually allow a user to assume this role
# Probably want to make a standalone user like above
# Probably not recommended

#resource "aws_iam_role" "terraform_role" {
#  name = "terraform-deployment-role"
#  path = "/"
#  assume_role_policy = data.aws_iam_policy_document.terraform_iam_policy_source.json
#}


# Create the policy in IAM
# Attach the policy to the default awscli configuration profile
# Will leave the policy on the user EVEN AFTER finishing the terraform configuration
# For this reason, I think this is not recommended

#resource "aws_iam_policy" "terraform_iam_policy" {
#    name = "terraform-policy"
#    path = "/"
#    description = "Permissions for Terraform-controlled EKS cluster creation and management"
#    policy = data.aws_iam_policy_document.terraform_iam_policy_source.json
#}

#resource "aws_iam_user_policy_attachment" "attach-terraform-permissions" {
#  user        = split("/", data.aws_caller_identity.current.arn)[1]
#  policy_arn  = aws_iam_policy.terraform_iam_policy.arn
#}

#data "aws_caller_identity" "current" {}


# This is the data for the policy needed to run terraform to create an eks cluster
data "aws_iam_policy_document" "terraform_iam_policy_source" {
	version = "2012-10-17"

  statement {
    sid     = "VisualEditor0"

    effect  = "Allow"

    actions = [
      "autoscaling:AttachInstances",
      "autoscaling:CreateAutoScalingGroup",
      "autoscaling:CreateLaunchConfiguration",
      "autoscaling:CreateOrUpdateTags",
      "autoscaling:DeleteAutoScalingGroup",
      "autoscaling:DeleteLaunchConfiguration",
      "autoscaling:DeleteTags",
      "autoscaling:Describe*",
      "autoscaling:DetachInstances",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:UpdateAutoScalingGroup",
      "autoscaling:SuspendProcesses",
      "ec2:AllocateAddress",
      "ec2:AssignPrivateIpAddresses",
      "ec2:Associate*",
      "ec2:AttachInternetGateway",
      "ec2:AttachNetworkInterface",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateDefaultSubnet",
      "ec2:CreateDhcpOptions",
      "ec2:CreateEgressOnlyInternetGateway",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateNetworkInterface",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:CreateVpc",
      "ec2:DeleteDhcpOptions",
      "ec2:DeleteEgressOnlyInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteTags",
      "ec2:DeleteVolume",
      "ec2:DeleteVpc",
      "ec2:DeleteVpnGateway",
      "ec2:Describe*",
      "ec2:DetachInternetGateway",
      "ec2:DetachNetworkInterface",
      "ec2:DetachVolume",
      "ec2:Disassociate*",
      "ec2:ModifySubnetAttribute",
      "ec2:ModifyVpcAttribute",
      "ec2:ModifyVpcEndpoint",
      "ec2:ReleaseAddress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
      "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateLaunchTemplateVersion",
      "ec2:DeleteLaunchTemplate",
      "ec2:DeleteLaunchTemplateVersions",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:GetLaunchTemplateData",
      "ec2:ModifyLaunchTemplate",
      "ec2:RunInstances",
      "eks:CreateCluster",
      "eks:DeleteCluster",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:ListFargateProfiles",
      "eks:ListNodegroups",
      "eks:ListTagsForResource",
      "eks:TagResource",
      "eks:UntagResource",
      "eks:UpdateClusterConfig",
      "iam:AddRoleToInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:CreateInstanceProfile",
  	  "iam:CreateOpenIDConnectProvider",
      "iam:CreateServiceLinkedRole",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:DeleteInstanceProfile",
		  "iam:DeleteOpenIDConnectProvider",
      "iam:DeletePolicy",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteServiceLinkedRole",
      "iam:DetachRolePolicy",
      "iam:GetInstanceProfile",
		  "iam:GetOpenIDConnectProvider",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:List*",
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy"
    ]

    resources = ["*"]
  }
} 
