# tf-aws-wsus

This module is for implementing a WSUS server in AWS. The module is configured allows the configuration of classifications, and products. Additionally, a list of wildcards can be supplied to enable prodcuts, followed by a list of wildcards to disbale products.

`The default product vars enable Windows 2008*, Windows 2012*, Windows 2016* , and disables the sub products of langauge and drivers.`

`The default classification vars enable only critical updates`

Updates are automatically downloaded based on the product and classification options.

No auto authorisation rules have been set

NB. The complete build currently take a approximately an hour to complete

## Terraform Version Compatibility

Module Version|Terraform Version
---|---
v2.0.0|0.12.x
v1.3.3|0.11.x

## Usage

Declare a module in your Terraform file, for example:

```
module "wsus" {
  source = "../localmodules/tf-aws-wsus"

  ami            = data.aws_ami.windows.id
  userdata       = data.template_file.domain_connect_userdata.rendered
  instance_type  = "m4.large"
  subnet_id      = element(data.terraform_remote_state.vpc.private_subnets, 1)
  vpc_id         = data.terraform_remote_state.vpc.vpc_id
  envname        = var.envname
  envtype        = var.envtype
  customer       = var.customer
  key_name       = "bowser-test"
  targeting_mode = "Server"

  vpc_security_group_ids = [
    data.terraform_remote_state.mgmt.ads_sg_id,
    data.terraform_remote_state.mgmt.mgmt_sg_id,
  ]
}
```

## Variables

- `customer`           - name of customer
- `envtype`            - name of environment type
- `envname`            - name of environment

- `ami_id`                 - id of windows ami for runner instance
- `instance_type`          - name of ec2 instance_type for runner instance
- `key_name`               - name of ec2 keypair for runner instance
- `subnet_id`              - id of subnet for runner instance
- `vpc_id`                 - id of vpc
- `vpc_security_group_ids` - list of additional security groups the wsus server needs to be added to
- `userdata`               - rendered userdata for domain join scripts etc
- `language`               - default wsus language
  - `default = "en"`
- `targeting_mode`         - WSUS targeting mode
- `extra_ebs_blocks`       - Additional EBS blocks to be attached to the instance

  ```
  default = [
    {
      # D:\ for WSUS storage
      device_name = "xvdca"
      volume_size = "200"
      volume_type = "gp2"
    }
  ]
  ```

### PRODUCTS

- `enabled_products`       - list of Products to enable. Wildcards accepted
  - `default = "windows server 2008*,windows server 2012*,windows server 2016*"`
- `disabled_products`      - list of disabled products. Wilcards accepted
  - `default = "*language packs*,*drivers*"`

### CLASSIFICATIONS

- `critical_update`    - set to 1 if enabled
- `definition_updates` - set to 1 if enabled
- `feature_packs`      - set to 1 if enabled
- `security_updates`   - set to 1 if enabled
- `service_packs`      - set to 1 if enabled
- `update_rollups`     - set to 1 if enabled
- `updates`            - set to 1 if enabled
- `drivers`            - set to 1 if enabled
- `driver_sets`        - set to 1 if enabled
- `tools`              - set to 1 if enabled
- `upgrades`           - set to 1 if enabled
