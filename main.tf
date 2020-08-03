#wsus instance

locals {
  common_tags = {
    Name        = "wsus"
    Environment = var.envname
    Service     = var.envtype
  }
}

resource "aws_instance" "wsus" {
  ami                     = var.ami
  instance_type           = var.instance_type
  user_data               = "<powershell>${data.template_file.additional_drive.rendered}${data.template_file.wsus_domain_connect_userdata.rendered}${data.template_file.wsus.rendered}${var.userdata}</powershell><persist>true</persist>"
  subnet_id               = var.subnet_id
  iam_instance_profile    = var.instance_profile
  vpc_security_group_ids  = flatten([var.vpc_security_group_ids, aws_security_group.wsus.id])
  disable_api_termination = false
  key_name                = var.key_name

  tags = merge(
      local.common_tags,
      var.additional_tags
    )

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  dynamic "ebs_block_device" {
    for_each = var.extra_ebs_blocks
    iterator = block

    content {
      device_name = block.value["device_name"]
      volume_size = block.value["volume_size"]
      volume_type = block.value["volume_type"]
    }
  }
}

#wsus security group

resource "aws_security_group" "wsus" {
  name        = "wsus"
  vpc_id      = var.vpc_id
  description = "wsus security group"

  tags = {
    Name = coalesce(var.sg_name_overide, "${var.customer}-${var.envname}-wsus")
  }
}

resource "aws_security_group_rule" "wsus_in" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8530
  to_port           = 8531
  security_group_id = aws_security_group.wsus.id
  cidr_blocks       = var.wu_inbound_cidrs
}

resource "aws_security_group_rule" "windows_update_80" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.wsus.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "windows_update_443" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  security_group_id = aws_security_group.wsus.id
  cidr_blocks       = ["0.0.0.0/0"]
}
