## ----------------------------------------------------------------------------
##  Copyright 2023 SevenPico, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
## ----------------------------------------------------------------------------

## ----------------------------------------------------------------------------
##  ./_variables.required.tf
##  This file contains code written by SevenPico, Inc.
## ----------------------------------------------------------------------------

variable "openvpn_dhcp_option_domain" {
  type = string
}

variable "openvpn_hostname" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_cidr_blocks" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}