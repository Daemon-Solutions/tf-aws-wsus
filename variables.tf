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

#wsus data drive size (GB)
variable "drive_size" {
  default = "200"
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

#environmentals

variable "envname" {}
variable "envtype" {}
variable "subnet_id" {}
variable "key_name" {}
variable "customer" {}
variable "vpc_id" {}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "timezone" {
  default = "GMT Standard Time"
}

variable "sg_name_overide" {
  default = ""
}

variable "wu_inbound_cidrs" {
  default = [""]
  type    = "list"
}

#domain join vars

variable "region" {
  default = "eu-west-1"
}

variable "ad_domain_user" {}
variable "ad_domain_user_password" {}

variable "dns_servers" {
  type = "list"
}

variable "local_password" {}
variable "ad_domain_name" {}

variable "userdata" {
  default = ""
}
