module "ec2_autoscale_group_ssm_initialization_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_autoscale_group_meta.context
  attributes = ["initialization"]
}

module "ec2_autoscale_group_ssm_ssl_certificate_refresh_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_autoscale_group_meta.context
  attributes = ["ssl", "certificate", "refresh"]
}

#------------------------------------------------------------------------------
# EC2 VPN SSM Document for VPN Initialization
#------------------------------------------------------------------------------
resource "aws_ssm_document" "ec2_autoscale_group_initialization" {
  count           = module.ec2_autoscale_group_meta.enabled ? 1 : 0
  name            = module.ec2_autoscale_group_ssm_initialization_meta.id
  document_format = "JSON"
  document_type   = "Command"

  tags = module.ec2_autoscale_group_ssm_initialization_meta.tags
  content = templatefile("${path.module}/scripts/ssm.tftpl", {
    environment       = module.ec2_autoscale_group_ssm_initialization_meta.environment
    scripts_bucket_id = module.ec2_autoscale_group_scripts_bucket.bucket_id
    region            = data.aws_region.current[0].name
    config_cmds       = local.openvpn_config_scripts
    time_zone         = var.openvpn_time_zone
  })
}

resource "aws_ssm_association" "ec2_autoscale_group_initialization" {
  count            = module.ec2_autoscale_group_meta.enabled ? 1 : 0
  association_name = module.ec2_autoscale_group_ssm_initialization_meta.id
  name             = aws_ssm_document.ec2_autoscale_group_initialization[0].name
  targets {
    key    = "tag:Name"
    values = [module.ec2_autoscale_group_meta.id]
  }
  dynamic  "output_location" {
    for_each       = var.openvpn_ssm_association_output_bucket_name != null ? [1]: []
    content {
      s3_bucket_name = var.openvpn_ssm_association_output_bucket_name
      s3_key_prefix = aws_ssm_document.ec2_autoscale_group_initialization[0].name
    }
  }
}
