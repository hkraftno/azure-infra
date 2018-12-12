# Infrastructure

The infrastructure configuration is separated between a general basis infrastructure, and infrastructure specific for each application.

## Prerequisites:

There's a couple of tools you'll need installed to make changes to the infrastructure.

- First you'll need to have the password store set up to be able to work with the cloud infrastructure. See https://github.com/hkraftno/.password-store for details.
- You'll also need the various _cloud tools_ installed. See https://github.com/hkraftno/cloud-tools.

## Basis infrastructure

Basis infrastructure is configured using Terraform, with the configuration in this repo.

To set up or change, run the following commands (in the same folder as the appropriate `main.tf` file):

```bash
envchain az terraform init -backend-config access_key=$(gopass show azure/common/storage_account_access_key)
envchain az terraform-az plan
```

