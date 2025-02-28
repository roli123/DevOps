# Terraform Overview

## Introduction
Terraform is an open-source infrastructure-as-code (IaC) tool written in Go language and uses HashiCorp Configuration Language (HCL), which is declarative. Terraform allows users to provision and manage infrastructure across multiple cloud providers like AWS, Azure, and Google Cloud Platform (GCP). The latest version of Terraform is **1.10.5**.

## Terraform Workflow
1. **Initialize Terraform**
   ```bash
   terraform init
   ```
   This initializes Terraform and downloads the necessary provider plugins.

2. **Create Terraform Configuration File**
   - Create a `.tf` file (e.g., `main.tf`) and specify the provider and resources to be created.

3. **Validate the Configuration**
   ```bash
   terraform validate
   ```
   This performs a dry run and checks for syntax errors.

4. **Plan Execution**
   ```bash
   terraform plan
   ```
   This shows a preview of the changes Terraform will make to the infrastructure.

5. **Apply the Configuration**
   ```bash
   terraform apply
   ```
   This executes the planned changes and provisions the infrastructure.

6. **Destroy Infrastructure**
   ```bash
   terraform destroy
   ```
   This removes all resources defined in the configuration file.

## Using Terraform for AWS
Terraform provides pre-written modules and configurations for AWS, which can be found in the **Terraform Registry**.
- Visit [Terraform Registry](https://registry.terraform.io/)
- Search for "AWS" to find various modules and configurations for AWS services.

## Configuring Azure with Terraform
### Prerequisites
1. **Create an Azure Account**
2. **Get Subscription ID**
   - Go to **Azure Portal** → **Subscriptions** → Copy the Subscription ID.
3. **Get Tenant ID**
   - Navigate to **Microsoft Entra ID** (formerly Azure Active Directory) → Copy the Tenant ID.
4. **Register an Application**
   - Go to **App Registrations** → Click on **New Registration**.
   - Provide a name and select **Accounts in this organizational directory only (Single tenant)**.
   - Click **Register** and copy the **Client ID**.
5. **Generate Client Secret**
   - In the **Certificates & Secrets** section, click on **New Client Secret**.
   - Provide a description and click **Add**.
   - Copy the **Secret Value** (this will not be visible later).

### Terraform Configuration for Azure
After obtaining the required credentials, use them in the Terraform configuration file (`main.tf`) to authenticate and manage Azure resources.

### Execution Steps
```bash
terraform init
terraform validate
terraform plan -out "main.tf"
terraform apply "main.tf"
```
<<<<<<< HEAD
=======
This command checks for syntax errors and potential issues in the `.tf` files.

### 4. **Preview Execution Plan**
To see what actions Terraform will take without applying changes, use:
```bash
terraform plan
```
This command outputs a detailed plan of the resources that will be created, updated, or destroyed.

### 5. **Apply Changes**
To execute the plan and create/update resources as defined in the configuration, use:
```bash
terraform apply
```
Terraform will prompt for confirmation before making changes. To proceed without confirmation, use the `-auto-approve` flag.

### 6. **Destroy Infrastructure**
If resources need to be removed, Terraform provides an easy way to destroy all managed infrastructure:
```bash
terraform destroy
```
This command removes all resources defined in the configuration.

## Finding Terraform Code for AWS
To find Terraform code examples for AWS, you can search for **"Terraform AWS"** on:
- [Terraform Registry](https://registry.terraform.io/)
- [HashiCorp Documentation](https://developer.hashicorp.com/terraform/)

By following these steps, Terraform enables efficient infrastructure management, reducing manual intervention and ensuring infrastructure consistency across environments.
>>>>>>> 51a82a357571b14f1bfc401461bb4b7c2ba21843

This completes the setup and deployment of Azure resources using Terraform.