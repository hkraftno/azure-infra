variable "env"                                     {}
variable "vpn_shared_key"                          {}
variable "info_tag"                                { default = "Provisioned with Terraform" }
variable "virtual_network_address_space"           { default = "10.0.0.0/16" }
variable "gwsubnet_address_prefix"                 { default = "10.0.1.0/24" }
variable "mgmtsubnet_address_prefix"               { default = "10.0.2.0/24" }
variable "onpremise_gateway_address"               { default = "109.247.251.246" }
variable "onpremise_network_gateway_address_space" { default = "10.193.20.0/23" }
variable "algo_vpn_ip"                             { default = "13.79.17.145" }
variable "location"                                { default = "North Europe" }
variable "simo_public_ssh_key" {
default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAo114ixCPpMS66KVIsj+wEKyjpNSIh48abP8bAK73JHFNVqyJn1kz015oyoc0NZJn7pd318evAlYF82Vu25cpJK7rFL+2QvI/asgrj0XmwV3DUuqWlieV6DR6XdWHJYUPvs+mPftX23ctmbIO7JfUPZ+pD5ixCdcvAQYFTu6ofwSP51sR7JXv3fxoHhfS03u65893IIjm8ct/tHwBBM76q1ln4TIMIUWFgFFDjoUwWbve8nXBpF0iwVJk93Owde19tDfaLj0cbCVIjkTHbTi9z9N68vBZbGzZLDKDZB6C72/4WOD7JhQ51jBkrufNCQTIagGC5OF7/EMdJRgQ9rNUVw== stein.inge.morisbak@hkraft.no"
}
#variable "peha_public_ssh_key" {
#default = "ssh-rsa ..."
#}
