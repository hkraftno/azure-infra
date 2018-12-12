resource "azurerm_resource_group" "resourcegroup" {
    name     = "${var.env}ResourceGroup"
    location = "${var.location}"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

resource "azurerm_virtual_network" "network" {
    name                = "${var.env}Vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

resource "azurerm_subnet" "gwsubnet" {
    name                 = "${var.env}GatewaySubnet"
    resource_group_name  = "${azurerm_resource_group.resourcegroup.name}"
    virtual_network_name = "${azurerm_virtual_network.network.name}"
    address_prefix       = "10.0.1.0/24"
}


# VPN resources

resource "azurerm_public_ip" "publicip" {
    name                         = "${var.env}PublicIP"
    location                     = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name          = "${azurerm_resource_group.resourcegroup.name}"
    sku                          = "Basic"
    public_ip_address_allocation = "Static"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

resource "azurerm_virtual_network_gateway" "vnetgw" {
    name                = "${var.env}VirtualNetworkGW"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
    type     = "Vpn"
    vpn_type = "RouteBased"
    active_active = false
    enable_bgp    = false
    sku           = "Basic"

    ip_configuration {
      name                          = "${var.env}VnetGatewayConfig"
      public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = "${azurerm_subnet.gwsubnet.id}"
    }

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

resource "azurerm_local_network_gateway" "onpremise" {
    name                = "onpremise"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
    gateway_address     = "${var.gateway_address}"
    address_space       = ["10.1.1.0/24"]
}

resource "azurerm_virtual_network_gateway_connection" "vnetgwconnection" {
    name                = "onpremise"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
    type                       = "IPsec"
    virtual_network_gateway_id = "${azurerm_virtual_network_gateway.vnetgw.id}"
    local_network_gateway_id   = "${azurerm_local_network_gateway.onpremise.id}"
    shared_key = "${var.vpn_shared_key}"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}


# Management resources

resource "azurerm_subnet" "mgmtsubnet" {
    name                 = "${var.env}ManagementSubnet"
    resource_group_name  = "${azurerm_resource_group.resourcegroup.name}"
    virtual_network_name = "${azurerm_virtual_network.network.name}"
    address_prefix       = "10.0.2.0/24"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "securitygroup" {
    name                = "${var.env}PingSecurityGroup"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

resource "azurerm_network_security_rule" "networksecurityrule" {
    name                        = "${var.env}SecurityRule"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "0-8"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "${azurerm_resource_group.resourcegroup.name}"
    network_security_group_name = "${azurerm_network_security_group.securitygroup.name}"
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    name                      = "${var.env}NIC"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.resourcegroup.name}"
    network_security_group_id = "${azurerm_network_security_group.securitygroup.id}"

    ip_configuration {
        name                          = "${var.env}NicConfiguration"
        subnet_id                     = "${azurerm_subnet.mgmtsubnet.id}"
        private_ip_address_allocation = "dynamic"
    }

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

# Create virtual machine
resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.env}PingVM"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "Basic_A0"

    storage_os_disk {
        name              = "${var.env}OsDisk"
        caching           = "None"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.env}ping"
        admin_username = "azureuser"
    }

    os_profile_linux_config {
        disable_password_authentication = true
    }

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

