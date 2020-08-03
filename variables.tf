#wsus server specification

variable "ami" {}
variable "instance_type" {}

#wsus enabled products
variable "enabled_products" {
  default = "windows server 2008*,windows server 2012*,windows server 2016*"
}

#wsus disabled products
variable "disabled_products" {
  default = "*language packs*,*drivers*"
}

#wsus language
variable "language" {
  default = "en"
}

#wsus root drive size (GB)
variable "root_volume_size" {
  default = "30"
}

#wsus root drive type
variable "root_volume_type" {
  default = "gp2"
}

# Extra volumes for data storage
variable "extra_ebs_blocks" {
  default = [
    {
      # D:\ for WSUS storage
      device_name = "xvdca"
      volume_size = "200"
      volume_type = "gp2"
    }
  ]
}

#wsus classifications - at least on must be set to 1

variable "critical_update" {
  default = "1"
}

variable "definition_updates" {
  default = "0"
}

variable "feature_packs" {
  default = "0"
}

variable "security_updates" {
  default = "0"
}

variable "service_packs" {
  default = "0"
}

variable "update_rollups" {
  default = "0"
}

variable "updates" {
  default = "0"
}

variable "drivers" {
  default = "0"
}

variable "driver_sets" {
  default = "0"
}

variable "tools" {
  default = "0"
}

variable "upgrades" {
  default = "0"
}

# WSUS targeting mode
# Client = use GPO
# Server = manually assign
variable "targeting_mode" {
  type = string
}

#environmentals

variable "envname" {
  type = string
}

variable "envtype" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "customer" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "timezone" {
  type    = string
  default = "GMT Standard Time"
}

variable "sg_name_overide" {
  type    = string
  default = ""
}

variable "wu_inbound_cidrs" {
  type    = list(string)
  default = [""]
}

#domain join vars

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "ad_domain_user" {
  type = string
}

variable "ad_domain_user_password" {
  type = string
}

variable "dns_servers" {
  type = list(string)
}

variable "local_password" {
  type = string
}

variable "ad_domain_name" {
  type = string
}

variable "userdata" {
  type    = string
  default = ""
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "instance_profile" {
  type = string
}
