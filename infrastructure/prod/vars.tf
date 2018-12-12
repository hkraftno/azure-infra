variable "env"                                     {}
variable "vpn_shared_key"                          {}
variable "info_tag"                                { default = "Provisioned with Terraform" }
variable "virtual_network_address_space"           { default = "10.0.0.0/16" }
variable "gwsubnet_address_prefix"                 { default = "10.0.1.0/24" }
variable "mgmtsubnet_address_prefix"               { default = "10.0.2.0/24" }
variable "onpremise_gateway_address"               { default = "109.247.251.246" }
variable "onpremise_network_gateway_address_space" { default = "10.193.20.0/23" }
variable "location"                                { default = "North Europe" }
