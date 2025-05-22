# Terraform Overview

## Introduction

Terraform is an open-source infrastructure-as-code (IaC) tool written in Go language and uses HashiCorp Configuration Language (HCL), which is declarative. Terraform allows users to provision and manage infrastructure across multiple cloud providers like AWS, Azure, and Google Cloud Platform (GCP). The latest version of Terraform is **1.12.0**

## Terraform Workflow

1. **Initialize Terraform**

   ```bash
   terraform init
   ```

   This initializes Terraform and downloads the necessary provider plugins.

2. **Create Terraform Configuration File**

   * Create a `.tf` file (e.g., `main.tf`) and specify the provider and resources to be created.

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

* Visit [Terraform Registry](https://registry.terraform.io/)
* Search for "AWS" to find various modules and configurations for AWS services.

## Configuring Azure with Terraform

### Prerequisites

1. **Create an Azure Account**
2. **Get Subscription ID**

   * Go to **Azure Portal** → **Subscriptions** → Copy the Subscription ID.
3. **Get Tenant ID**

   * Navigate to **Microsoft Entra ID** (formerly Azure Active Directory) → Copy the Tenant ID.
4. **Register an Application**

   * Go to **App Registrations** → Click on **New Registration**.
   * Provide a name and select **Accounts in this organizational directory only (Single tenant)**.
   * Click **Register** and copy the **Client ID**.
5. **Generate Client Secret**

   * In the **Certificates & Secrets** section, click on **New Client Secret**.
   * Provide a description and click **Add**.
   * Copy the **Secret Value** (this will not be visible later).

### Assigning Roles to the Application

After using these credentials in the `main.tf` file:

1. Go to **Subscriptions** in the Azure Portal.
2. Click on your subscription name.
3. Navigate to **Access Control (IAM)**.
4. Click the **Add** button, then select **Add role assignment**.
5. Under **Role**, choose **Contributor**, then click **Next**.
6. Under **Assign access to**, select **User, group, or service principal**.
7. In the **Select members** step, click **Select members** and choose the application you created.
8. Click **Review + assign** to grant access to the application.

### Creating a Resource Group

Once the role has been assigned to the application:

1. Go to the [Terraform Official Website](https://www.terraform.io/).
2. Click on **Registry** at the top.
3. Select **Browse Providers**, then choose **Azure (azurerm)**.
4. Navigate to **Documentation**, and in the filter box, search for **resource group**.
5. From the search results, click on **azurerm\_resource\_group**.
6. Copy the sample code provided for creating a resource group.
7. Paste this code into your `main.tf` file to define a resource group.

## Creating Azure Storage Account, Container, and Uploading Data

1. Visit the [Terraform Registry](https://registry.terraform.io/) → Select **Azure** Provider → Click on **Documentation**.
2. In the search/filter bar, type `azurerm_storage_blob`.
3. You’ll find example code for creating storage resources: `azurerm_storage_account`, `azurerm_storage_container`, and `azurerm_storage_blob`.
4. Add this code **after** the resource group block in your `main.tf` file.

### Configure Storage Account

* Assign a reference name (e.g., `storage`).
* Use a globally unique name (e.g., `mystorageaccount1234`).
* Use the same `resource_group_name` and `location` as the resource group.

### Configure Storage Container

* Assign a reference name (e.g., `container`).
* Define a `name`.
* Set `storage_account_id`:

  * Go to Azure Portal → Select the created storage account.
  * Click on **JSON View** at the top-right.
  * Copy the `resource ID` and paste it in `storage_account_id`.
* Set `container_access_type` to `container`.

### Configure Storage Blob

* Assign a reference name (e.g., `blob`).
* Set `name` as the file you want to upload.
* Provide:

  * `storage_account_name`
  * `storage_container_name`
  * `type` = `Block`
  * `source` = the file to upload (e.g., `main.tf`)

> **Note:** Creating all these resources at once may cause errors due to dependency order. For example, the storage account must exist before creating a container or blob. Use Terraform's built-in dependency management or the `depends_on` attribute to manage order.

> **Note:** *Blob* stands for *Binary Large Object*.
