variable "env" {}
variable "vpn_shared_key" {}
variable "marketing_automation_db_user" {}
variable "marketing_automation_db_password" {}

variable "info_tag" {
  default = "Provisioned with Terraform"
}

variable "virtual_network_address_space" {
  default = "10.0.0.0/16"
}

variable "gwsubnet_address_prefix" {
  default = "10.0.1.0/24"
}

variable "mgmtsubnet_address_prefix" {
  default = "10.0.2.0/24"
}

variable "applicationsubnet_address_prefix" {
  default = "10.0.3.0/24"
}

variable "appsubnet_address_prefix" {
  default = "10.0.4.0/24"
}

variable "externalapisubnet_address_prefix" {
  default = "10.0.5.0/24"
}

variable "marketingsubnet_address_prefix" {
  default = "10.0.6.0/24"
}

variable "onpremise_gateway_address" {
  default = "109.247.251.246"
}

variable "onpremise_network_gateway_address_space" {
  default = "10.193.20.0/23"
}

variable "algo_vpn_ip" {
  default = "40.127.202.23"
}

variable "location" {
  default = "North Europe"
}

variable "simo_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAo114ixCPpMS66KVIsj+wEKyjpNSIh48abP8bAK73JHFNVqyJn1kz015oyoc0NZJn7pd318evAlYF82Vu25cpJK7rFL+2QvI/asgrj0XmwV3DUuqWlieV6DR6XdWHJYUPvs+mPftX23ctmbIO7JfUPZ+pD5ixCdcvAQYFTu6ofwSP51sR7JXv3fxoHhfS03u65893IIjm8ct/tHwBBM76q1ln4TIMIUWFgFFDjoUwWbve8nXBpF0iwVJk93Owde19tDfaLj0cbCVIjkTHbTi9z9N68vBZbGzZLDKDZB6C72/4WOD7JhQ51jBkrufNCQTIagGC5OF7/EMdJRgQ9rNUVw== stein.inge.morisbak@hkraft.no"
}

variable "peha_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNWlxk+pdbl27IGIJ6LSd3K2St2U/u8paeaWCvBbsngfLMzpNO2p6v1ZhlGtD99zVlR8hZR5hPKP3+U1iUP/2nUA3tyhkIRbSoNfVCE2+YBztxaTItVPTbDl1AcoeqM+3LcDS22vpHnIdZuPaIhGgfz0h71ewwMW/P90j4GwcYWjtTY2i0gtgxDLm17eE0npuvXhDlp4KbKoXxz20Fb/5MVEtCwdx4JWN3Iag7r4Xtp3Ff8Dj64+0e4oQE4iZ81+IUILzqswygnhmXhgUUwUQsKb1y2HMmKv3qTx4vyGB9/94pX11QrGfIxTw3w4SzMlu9gcsHAqyor7YLZYY8XlpSLpyGtXixrCDnb0FbV8QM7tQA1ml26Q94drdBNZPYZQ2k+D07PyMTNjCaetr6Q5xhHLPXM5Axfl4RvLIpz92vAW1bjgLS9WXyCk2a9fgFiYXiHT5PUNF4XGEkyh8XY0AYyEAkH9WJljHdqnelzovNGwgnFTyKRZk5HcGkrsuLaKz6hJqyRbQDrLa5eQpAtOfgzS58lQ2OwcPegQA+fxjx0b88OG0FpihHMJICeeM3qcI+kerWKoj3+Ds0Ao++P3YWLZ6lITP99oMUFXFWf5EqPQL9P7bnGBmbGhDF4FqT9AJcOA7pIKSz5qyKG1Bu7OuoXALviNBZu0cobZAuQIO1TQ== petter.hareim@hkraft.no"
}

variable "karlgustav_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbP2jXVoKD0wI3KUA6MYRk013metaX2/zZlXB2jI9dPe7KUHsDjGvfV5Kr5wlSTPAOPnvb4K6u9VRjZ58lhYCBjdwhxpE7d4UnAn/QY5Muqk402xWKqoNfZZLZP5J/LTvOEm3xuw2/k2yavcn6Y07gEFBsD05jIxxgEr+K6jOxlBV79H1pgpLK8LCR1ofi5aWSMYsNeKLG2eAAMvbV3x76nfA/LuKrKZYPgUOhbB43rlN/nBW/dFCfU/bw5MDiEyE5NOZ3ZJOHyNTJnwO0tQdpDA/eOLG5JEgMDqiy37dcaPMTPqfmLBWHN/ntLzGcPB4CsZkCjnchWLHknJTS0U6Z karlgustav@Karls-MacBook-Pro.local"
}

variable "tof_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC65giMLpDwaV5b0RaiaH8hVUsOLnI7dlGAAxWvhlVl/WFRrVvC90WKHQVedTEfGn3NPlAOgqXooARxSdImy+kQDFqW6Z7l+RVm9o4LO4yM3TIp0zPJXek/o2oU6+3glYs5pSXJ2TNydIKigzUBl97bYOGWjIqdCLdVWXuKJdsMARGEUURw9vbA/jmfvt9cKF2oWmaKbDGTngkC3L85CcnYiTrqTK0hUsmsE5gJlHbhmAfbwKFhlsJOdjP0lfzT9SafEYmVUxqHcHAy+5b4/nwp/E4tGnsjBCyu+HaYQaJ5Y11MU1xjokAEO9ZdddacmR2X4QssrMKO7x0u0i80j2w5 torleivfossum@Torleivs-MacBook-Pro.local"
}

variable "stian_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAveOzUWoE3SPwdSb/dJ+jUlIjznU7h4tpnHnDxPsm8BTJsGuiiGZU1NU//ZcugyaQ+rqV0xKq2Q5106TfzE2pMcwkZotW4dwDTIEfs9wvxbl5iCHlwmb6dWATXUwdJu9/6N6CHahZNeHS6b12HayP68Jo1TAqEfHdEcsJcmyBfHtBnIpVaiPKjox88Uba98aZ5TZktS0l1JdjmUPY5W/lquP1UDdsmC2xDM6Tu4yT9B5dUfwhdBlxCPD5QPDwUpq1xSpG+qvEkOoIHd+Vbv3PUm79KEzGXowbz+c6Lz3VhXlumu69Wv9iNUkcIa2Z3u7HFeRePBYxgiphCm3PZ2aOuw== stian@appex.no"
}

variable "jarlerik_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAnZR4zkJkF79UkNDE+fyDPF3oJ7MgUCESR6bRQ1ujCmfCCszcLhUISFuJqYKuCM/niEc/irdD0Bt5L4hxLoaAzskEmjTbiXrwF3A+TAhFVAvALps0o1eFauJFbAQqCPBZV8Dj9XM2CneWmyLq++TaqXe6mebDxmlUxQgqVMshTbM/1Wf8s2SxM5p06Gl+loHMYHej4/UXTCj48eGw+zipMfkHk+Gr3gFp7vmPLmYGwR7q8Yu4Q9e5YFZR0jh0Ort2tOmPoI0gvizc5nNHdUeP+Cd1QJaI0+aStSSP193Lp8y4sjkGbC1mPb1TIxrzlVF7JQQ3Ur56CKukSYroEHfJqQ== jarl.erik.schmidt@appex.no"
}

variable "fratle_public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuvEALHPxVRGqBFkrgqBEBHJUu6vwMAv/OufbI9ue8mEkJfRxmf9qKlse/rJlaT8zzIDBBSOyeLATgdJr659QViNGrFoQ2Z8UT2DAt8zEZDMHIIGmLL7tMc9YJ+VR3xYedrJMHcKrfwJjMI4I0hpV4vi8M2rFQ7Cj+FRYsEXnLAGxvLJ/6Sp4OypSGAjQEM6IXur2c82QllsBoq2px2lPxFEkAVJqimsPTaf11CY6xSQd4oPASWkWB+h9gI5Uo4ixbGEhB2zU/118x9tJ2OzdeavHgKeZIAbF4op1rG0ICSE3NdCznGSMBD2EGqk21NHDozo/kKYLRlT+xKfmA4dxvb9QL6vFlU1xM4hSrGZU8DerP/TDf2Cs00d5xclkSyZJw50xx1jc6Fgy9ltO9c3G6S2iZfVyTEJkCm81yUNOcW5qiMO67Mx8XsTLAiWWsD7FYwjhUUZPVxaYjzsb2GBNJSC4a/dSMaDJ/tTOcDhf5TAgiNzcN9tEYSZe6i4WE7d1qOfcg9q3O3pM0zE7aHekAiZ6x7WqnD3GaOHu9fbKqXvvQxI3w/CTrSyLLGAywZSacG6e67iXum7p3wR3dcPVBU09Xc5h43PGBwciXX5+QCZBphji0In5RSShR3kDM6D9C5J/C91xSetF0+AsbRCr9ouoQ6RylNqzzPU5Im2f84Q== frank.rod@hkraft.no"
}
