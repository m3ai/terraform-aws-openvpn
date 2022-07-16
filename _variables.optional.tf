variable "create_ec2_autoscale_sns_topic" { default = false }
variable "create_nlb" { default = false }
variable "create_openvpn_secret" { default = false }

variable "cloudwatch_enabled" { default = true }
variable "cloudwatch_logs_expiration_days" { default = 90 }


#------------------------------------------------------------------------------
# EC2 Inputs
#------------------------------------------------------------------------------
variable "ec2_user_data" { default = "" }
variable "ec2_associate_public_ip_address" { default = true }
variable "ec2_ami_id" { default = "ami-037ff6453f0855c46" } # "This module was built using ami-037ff6453f0855c46 which is a BYOL, but supports 2 free connections."
variable "ec2_autoscale_desired_count" { default = 1 }
variable "ec2_autoscale_instance_type" { default = "t3.micro" }
variable "ec2_autoscale_max_count" { default = 1 }
variable "ec2_autoscale_min_count" { default = 1 }
variable "ec2_autoscale_sns_topic_default_result" { default = "CONTINUE" }
variable "ec2_autoscale_sns_topic_heartbeat_timeout" { default = 180 }
variable "ec2_additional_security_group_ids" { default = [] }
variable "ec2_key_name" { default = null }


#------------------------------------------------------------------------------
# NLB Inputs
#------------------------------------------------------------------------------
variable "nlb_access_logs_prefix_override" { default = null }
variable "nlb_access_logs_s3_bucket_id" { default = null }
variable "nlb_acm_certificate_arn" { default = null }
variable "nlb_deletion_protection_enabled" { default = false }
variable "nlb_subnet_ids" { default = [] }
variable "nlb_tls_ssl_policy" { default = "ELBSecurityPolicy-TLS13-1-2-2021-06" }


#------------------------------------------------------------------------------
# OpenVPN Inputs
#------------------------------------------------------------------------------
variable "openvpn_client_cidr_blocks" { default = ["172.27.0.0/16"] }
variable "openvpn_client_dhcp_network" { default = ["172.27.32.0"] }
variable "openvpn_client_dhcp_network_mask" { default = "20" }
variable "openvpn_client_static_addresses_enabled" { default = false }
variable "openvpn_client_static_network" { default = "172.27.64.0" }
variable "openvpn_client_static_network_mask" { default = "20" }
variable "openvpn_config_scripts_additional" { default = [] }
variable "openvpn_daemon_ingress_blocks" { default = ["0.0.0.0/0"] }
variable "openvpn_daemon_tcp_port" { default = 443 }
variable "openvpn_daemon_udp_port" { default = 1194 }
variable "openvpn_s3_access_logs_prefix_override" { default = null }
variable "openvpn_s3_access_logs_s3_bucket_id" { default = null }
variable "openvpn_s3_force_destroy" { default = true }
variable "openvpn_s3_lifecycle_configuration_rules" { default = [] }
variable "openvpn_s3_versioning_enabled" { default = true }
variable "openvpn_secret_admin_password_key" { default = "ADMIN_PASSWORD" }
variable "openvpn_secret_arn" { default = "" }
variable "openvpn_secret_enable_kms_key_rotation" { default = true }
variable "openvpn_secret_kms_key_arn" { default = null }
variable "openvpn_ssm_association_output_bucket_name" { default = null }
variable "openvpn_time_zone" { default = "America/Chicago" }
variable "openvpn_ui_https_port" { default = 943 }
variable "openvpn_ui_ingress_blocks" { default = ["0.0.0.0/0"] }
variable "openvpn_web_server_name" { default = "OpenVPN Server" }






