# Creating Azure Virtual Network (VNet) using Terraform

## Introduction

This guide walks you through the steps to create an Azure Virtual Network (VNet) using Terraform. Like other Azure resources, VNets are also created within a resource group defined in a `.tf` file.

## Steps to Create VNet

### 1. Define a Resource Block

VNets in Terraform are defined using the `resource` block. This block will contain all the necessary configuration details.

### 2. Get the VNet Resource Definition

* Go to [terraform.io](https://www.terraform.io/)
* Navigate to **Registry** → **Browse Providers** → **Azure (azurerm)** → **Documentation**
* Use the filter to search for **virtual network**
* Locate `azurerm_virtual_network`
* Copy the example code provided
* Paste the code into your existing `main.tf` file or any Terraform configuration file

### 3. Execute Terraform Commands

Run the following commands in your terminal:

```bash
terraform init
terraform validate
terraform plan -out vnet.tfplan
terraform apply vnet.tfplan
```

These commands will:

* Initialize the project and download necessary plugins
* Validate your configuration
* Create an execution plan and save it
* Apply the saved plan to provision the VNet

## Note:

When creating a VNet, Azure may automatically create a resource group named **NetworkWatcherRG** for monitoring purposes. This group is not created by Terraform and therefore:

* **It will not be destroyed** when you run `terraform destroy`
* If not needed, **you must delete it manually** from the Azure portal

---

You now have a virtual network created and managed via Terraform!
