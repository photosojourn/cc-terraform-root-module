# Terraform Block
terraform {
  required_version = "~> 1.8.5"

  required_providers {
    # AWS provider example:
    # aws = {
    #     source = "hashicorp/aws"
    #     version = ">= 4.0"
    # }

    # AzureRM provider example:
    # azurerm = {
    #     source  = "hashicorp/azurerm"
    #     version = ">= 3.0"
    # }
  }
}
