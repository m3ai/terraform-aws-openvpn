module "openvpn_meta" {
  source  = "registry.terraform.io/cloudposse/label/null"
  version = "0.25.0"
  context = module.this.context
}

module "dns_meta" {
  source  = "registry.terraform.io/cloudposse/label/null"
  version = "0.25.0"
  context = module.this.context

  namespace           = data.aws_route53_zone.public.name
  stage               = null
  name                = null
  attributes          = []
  delimiter           = "."
  regex_replace_chars = "/[^a-zA-Z0-9-.]/"
  label_order         = ["name", "namespace"]
}


#------------------------------------------------------------------------------
# EC2 VPN Auto Scale Group Labels
#------------------------------------------------------------------------------
module "ec2_asg_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.openvpn_meta.context
  name       = "ec2"
  attributes = ["asg"]
}

module "ec2_asg_dns_meta" {
  source  = "registry.terraform.io/cloudposse/label/null"
  version = "0.25.0"
  context = module.dns_meta.context
  name    = "vpn"
}


#------------------------------------------------------------------------------
# EC2 VPN Auto Scale Group IAM Labels
#------------------------------------------------------------------------------
module "ec2_asg_role_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_asg_meta.context
  attributes = ["role"]
}


module "ec2_asg_lifecycle_role_meta" {
  source          = "registry.terraform.io/cloudposse/label/null"
  version         = "0.25.0"
  context         = module.ec2_asg_meta.context
  attributes      = ["lifecycle", "role"]
  id_length_limit = 63
}

module "ec2_asg_lifecycle_policy_meta" {
  source          = "registry.terraform.io/cloudposse/label/null"
  version         = "0.25.0"
  context         = module.ec2_asg_meta.context
  attributes      = ["lifecycle", "policy"]
  id_length_limit = 63
}

#module "ec2_openvpn_asg_sns_role_meta" {
#  source     = "registry.terraform.io/cloudposse/label/null"
#  version    = "0.25.0"
#  context    = module.ec2_openvpn_meta.context
#  attributes = ["sns", "role"]
#}
#
#module "ec2_openvpn_asg_sns_policy_meta" {
#  source     = "registry.terraform.io/cloudposse/label/null"
#  version    = "0.25.0"
#  context    = module.ec2_openvpn_meta.context
#  attributes = ["sns", "policy"]
#}


#------------------------------------------------------------------------------
# EC2 VPN Auto Scale Group Secrets Manager Labels
#------------------------------------------------------------------------------
module "ec2_asg_secrets_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_asg_meta.context
  attributes = ["configuration"]
}

module "ec2_asg_secrets_kms_meta" {
  source  = "registry.terraform.io/cloudposse/label/null"
  version = "0.25.0"
  context = module.ec2_asg_secrets_meta.context
}

#------------------------------------------------------------------------------
# EC2 VPN Auto Scale Group Security Group Labels
#------------------------------------------------------------------------------
module "ec2_asg_sg_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_asg_meta.context
  attributes = ["sg"]
}


#------------------------------------------------------------------------------
# EC2 VPN Auto Scale Group SSM Labels
#------------------------------------------------------------------------------
module "ec2_asg_ssm_initialization_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_asg_meta.context
  attributes = ["initialization"]
}

module "ec2_asg_ssm_ssl_certificate_refresh_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_asg_meta.context
  attributes = ["ssl", "certificate", "refresh"]
}


#------------------------------------------------------------------------------
# EC2 VPN S3 Labels
#------------------------------------------------------------------------------
module "ec2_asg_scripts_bucket_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_asg_meta.context
  attributes = ["scripts"]
}

