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
    address_space       = ["${var.virtual_network_address_space}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

# VPN Gateway

resource "azurerm_subnet" "gwsubnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = "${azurerm_resource_group.resourcegroup.name}"
    virtual_network_name = "${azurerm_virtual_network.network.name}"
    address_prefix       = "${var.gwsubnet_address_prefix}"
}


module "network_gateway_public_ip" {
    source              = "../modules/public_ip"
    name                = "${var.env}PublicIP"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
    env			= "${var.env}"
    info_tag            = "${var.info_tag}"
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
      public_ip_address_id          = "${module.network_gateway_public_ip.id}"
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = "${azurerm_subnet.gwsubnet.id}"
    }

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

# On premise VPN gateway

resource "azurerm_local_network_gateway" "onpremise" {
    name                = "${var.env}OnPremiseNetworkGateway"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
    gateway_address     = "${var.onpremise_gateway_address}"
    address_space       = ["${var.onpremise_network_gateway_address_space}"]
}

resource "azurerm_virtual_network_gateway_connection" "vnetgwconnection" {
    name                       = "${var.env}OnPremiseNetworkGatewayConnection"
    location                   = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name        = "${azurerm_resource_group.resourcegroup.name}"
    type                       = "IPsec"
    virtual_network_gateway_id = "${azurerm_virtual_network_gateway.vnetgw.id}"
    local_network_gateway_id   = "${azurerm_local_network_gateway.onpremise.id}"
    shared_key                 = "${var.vpn_shared_key}"

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
    address_prefix       = "${var.mgmtsubnet_address_prefix}"
}

resource "azurerm_network_security_group" "securitygroup" {
    name                = "${var.env}PingSecurityGroup"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
    }
}

# Management server

module "mgmtserver_public_ip" {
    source              = "../modules/public_ip"
    name                = "${var.env}MgmtPublicIP"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
    env                 = "${var.env}"
    info_tag            = "${var.info_tag}"
}

module "mgmtserver_nic" {
    source                = "../modules/public_nic"
    name                  = "${var.env}MgmtNIC"
    location              = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
    security_group_id     = "${azurerm_network_security_group.securitygroup.id}"
    ip_configuration_name = "${var.env}MgmtNicConfiguration"
    subnet_id             = "${azurerm_subnet.mgmtsubnet.id}"
    public_ip_address_id  = "${module.mgmtserver_public_ip.id}"
    env                   = "${var.env}"
    info_tag              = "${var.info_tag}"
}

resource "azurerm_virtual_machine" "mgmtvm" {
    name                          = "${var.env}MgmtVM"
    location                      = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name           = "${azurerm_resource_group.resourcegroup.name}"
    network_interface_ids         = ["${module.mgmtserver_nic.id}"]
    vm_size                       = "Basic_A0"
    delete_os_disk_on_termination = "true"

    storage_os_disk {
        name              = "${var.env}MgmtOsDisk"
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
        admin_username = "azureuser"
        computer_name  = "${var.env}mgmtserver"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys = {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "${var.simo_public_ssh_key}"
        }
    }

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
        note        = "Management server"
    }
}

resource "azurerm_virtual_machine_extension" "mgmtvmext" {
    name                 = "${var.env}mgmtserver"
    location             = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name  = "${azurerm_resource_group.resourcegroup.name}"
    virtual_machine_name = "${azurerm_virtual_machine.mgmtvm.name}"
    publisher            = "Microsoft.Azure.Extensions"
    type                 = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
      {
        "fileUris": [ "https://raw.githubusercontent.com/hkraftno/azure-infra/master/infrastructure/scripts/create_user.sh" ],
        "commandToExecute": "./create_user.sh simo '${var.simo_public_ssh_key}' && ./create_user.sh peha '${var.peha_public_ssh_key}' && ./create_user.sh tof '${var.tof_public_ssh_key}' && ./create_user.sh karlgustav '${var.karlgustav_public_ssh_key}' && ./create_user.sh stian '${var.stian_public_ssh_key}' && ./create_user.sh jarlerik '${var.jarlerik_public_ssh_key}'"
    }
SETTINGS

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
        note        = "Create users"
   }
}

resource "azurerm_network_security_rule" "networksecurityrule_ssh_from_algo" {
    name                        = "${var.env}SecurityRuleSshFromAlgo"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "${var.algo_vpn_ip}"
    destination_address_prefix  = "${module.mgmtserver_nic.private_ip_address}"
    resource_group_name         = "${azurerm_resource_group.resourcegroup.name}"
    network_security_group_name = "${azurerm_network_security_group.securitygroup.name}"
}

resource "azurerm_network_security_rule" "networksecurityrule_ssh_from_algo_vpn" {
    name                        = "${var.env}SecurityRuleSshFromAlgoVPN"
    priority                    = 102
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "${var.new_algo_vpn_ip}"
    destination_address_prefix  = "${module.mgmtserver_nic.private_ip_address}"
    resource_group_name         = "${azurerm_resource_group.resourcegroup.name}"
    network_security_group_name = "${azurerm_network_security_group.securitygroup.name}"
}

# Server to ping for the VPN tunnel to stay up

module "ping_nic" {
    source                = "../modules/private_nic"
    name                  = "${var.env}NIC"
    location              = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
    security_group_id     = "${azurerm_network_security_group.securitygroup.id}"
    ip_configuration_name = "${var.env}NicConfiguration"
    subnet_id             = "${azurerm_subnet.mgmtsubnet.id}"
    env                   = "${var.env}"
    info_tag              = "${var.info_tag}"
}

resource "random_string" "password" {
  length = 16
  special = true
}

resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.env}PingVM"
    location              = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
    network_interface_ids = ["${module.ping_nic.id}"]
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
        admin_password  = "${random_string.password.result}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "${var.env}"
        info        = "${var.info_tag}"
        note        = "This server is used as a server to ping for the VPN tunnel to stay up"
    }
}

resource "azurerm_network_security_rule" "networksecurityrule" {
    name                        = "${var.env}PingSecurityRule"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "0-8"
    source_address_prefix       = "*"
    destination_address_prefix  = "${module.ping_nic.private_ip_address}"
    resource_group_name         = "${azurerm_resource_group.resourcegroup.name}"
    network_security_group_name = "${azurerm_network_security_group.securitygroup.name}"
}


resource "azurerm_sql_server" "marketingsqlserver" {
  name                         = "${var.env}-marketing-sql-server"
  resource_group_name          = "${azurerm_resource_group.resourcegroup.name}"
  location                     = "${azurerm_resource_group.resourcegroup.location}"
  version                      = "12.0"
  administrator_login          = "${var.marketing_automation_db_user}"
  administrator_login_password = "${var.marketing_automation_db_password}"

  tags {
    environment = "${var.env}"
    info        = "${var.info_tag}"
    note        = "This is the SQL-database used by Marketing Automation"
  }
}
