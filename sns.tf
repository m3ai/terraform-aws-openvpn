module "ec2_autoscale_group_sns_meta" {
  source     = "registry.terraform.io/cloudposse/label/null"
  version    = "0.25.0"
  context    = module.ec2_autoscale_group_meta.context
  attributes = ["sns"]
  enabled    = var.create_autoscale_sns_topic && module.ec2_autoscale_group_meta.enabled
}


#------------------------------------------------------------------------------
# EC2 Auto Scaling Group SNS Topic
#------------------------------------------------------------------------------
resource "aws_sns_topic" "ec2_autoscale_group" {
  count                               = module.ec2_autoscale_group_sns_meta.enabled ? 1 : 0
  name                                = module.ec2_autoscale_group_sns_meta.id
  lambda_failure_feedback_role_arn    = aws_iam_role.ec2_autoscale_group_sns[0].arn
  lambda_success_feedback_role_arn    = aws_iam_role.ec2_autoscale_group_sns[0].arn
  lambda_success_feedback_sample_rate = 100
  tags                                = module.ec2_autoscale_group_sns_meta.tags
}

resource "aws_cloudwatch_log_group" "sns" {
  count             = module.ec2_autoscale_group_sns_meta.enabled ? 1 : 0
  name              = "sns/${data.aws_region.current[0].name}/${data.aws_caller_identity.current[0].account_id}/${module.ec2_autoscale_group_sns_meta.id}"
  retention_in_days = var.cloudwatch_logs_expiration_days
  tags              = module.ec2_autoscale_group_sns_meta.tags
}

resource "aws_autoscaling_lifecycle_hook" "ec2_autoscale_group_instance_launching" {
  count                   = module.ec2_autoscale_group_sns_meta.enabled ? 1 : 0
  autoscaling_group_name  = module.ec2_autoscale_group.autoscaling_group_name
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_LAUNCHING"
  name                    = "${module.ec2_autoscale_group_meta.id}-instance-launching"
  default_result          = var.autoscale_sns_topic_default_result
  heartbeat_timeout       = var.autoscale_sns_topic_heartbeat_timeout
  notification_target_arn = aws_sns_topic.ec2_autoscale_group[0].arn
  role_arn                = aws_iam_role.ec2_autoscale_group_lifecycle_role[0].arn
}

resource "aws_autoscaling_lifecycle_hook" "ec2_autoscale_group_instance_terminating" {
  count                   = module.ec2_autoscale_group_sns_meta.enabled ? 1 : 0
  autoscaling_group_name  = module.ec2_autoscale_group.autoscaling_group_name
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                    = "${module.ec2_autoscale_group_meta.id}-instance-terminating"
  default_result          = var.autoscale_sns_topic_default_result
  heartbeat_timeout       = var.autoscale_sns_topic_heartbeat_timeout
  notification_target_arn = aws_sns_topic.ec2_autoscale_group[0].arn
  role_arn                = aws_iam_role.ec2_autoscale_group_lifecycle_role[0].arn
}
