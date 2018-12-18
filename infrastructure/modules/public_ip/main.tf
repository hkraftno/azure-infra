resource "azurerm_public_ip" "publicip" {
    name                         = "${var.name}"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    sku                          = "Basic"
    public_ip_address_allocation = "Dynamic"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

