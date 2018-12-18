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
variable "peha_public_ssh_key" {
default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNWlxk+pdbl27IGIJ6LSd3K2St2U/u8paeaWCvBbsngfLMzpNO2p6v1ZhlGtD99zVlR8hZR5hPKP3+U1iUP/2nUA3tyhkIRbSoNfVCE2+YBztxaTItVPTbDl1AcoeqM+3LcDS22vpHnIdZuPaIhGgfz0h71ewwMW/P90j4GwcYWjtTY2i0gtgxDLm17eE0npuvXhDlp4KbKoXxz20Fb/5MVEtCwdx4JWN3Iag7r4Xtp3Ff8Dj64+0e4oQE4iZ81+IUILzqswygnhmXhgUUwUQsKb1y2HMmKv3qTx4vyGB9/94pX11QrGfIxTw3w4SzMlu9gcsHAqyor7YLZYY8XlpSLpyGtXixrCDnb0FbV8QM7tQA1ml26Q94drdBNZPYZQ2k+D07PyMTNjCaetr6Q5xhHLPXM5Axfl4RvLIpz92vAW1bjgLS9WXyCk2a9fgFiYXiHT5PUNF4XGEkyh8XY0AYyEAkH9WJljHdqnelzovNGwgnFTyKRZk5HcGkrsuLaKz6hJqyRbQDrLa5eQpAtOfgzS58lQ2OwcPegQA+fxjx0b88OG0FpihHMJICeeM3qcI+kerWKoj3+Ds0Ao++P3YWLZ6lITP99oMUFXFWf5EqPQL9P7bnGBmbGhDF4FqT9AJcOA7pIKSz5qyKG1Bu7OuoXALviNBZu0cobZAuQIO1TQ== petter.hareim@hkraft.no"
}
