resource "azurerm_network_interface" "nic" {
  name                      = "${var.name}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${var.security_group_id}"

  ip_configuration {
    name                          = "${var.ip_configuration_name}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }

  tags = {
    environment = "${var.env}"
    info        = "${var.info_tag}"
  }
}
