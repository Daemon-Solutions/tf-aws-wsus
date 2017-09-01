## datasources
data "template_file" "additional_drive" {
  template = "${file("${path.module}/include/additional_drive.tmpl")}"
}

data "template_file" "wsus" {
  template = "${file("${path.module}/include/wsus.tmpl")}"

  vars {
    #catagories
    critical_update    = "${var.critical_update}"
    definition_updates = "${var.definition_updates}"
    feature_packs      = "${var.feature_packs}"
    security_updates   = "${var.security_updates}"
    service_packs      = "${var.service_packs}"
    update_rollups     = "${var.update_rollups}"
    updates            = "${var.updates}"
    drivers            = "${var.drivers}"
    driver_sets        = "${var.driver_sets}"
    tools              = "${var.tools}"
    upgrades           = "${var.upgrades}"

    #global settings
    language = "${var.language}"

    #products
    enabled_products  = "${var.enabled_products}"
    disabled_products = "${var.disabled_products}"
  }
}
