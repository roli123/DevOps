**Terraform Notes**

Terraform is an open-source infrastructure as code (IaC) tool developed in the Go programming language. It uses the HashiCorp Configuration Language (HCL) and follows a declarative approach to define and manage infrastructure resources. The latest version of Terraform as of now is **1.10.5**.

## Purpose of Terraform
Terraform is primarily used for provisioning and managing infrastructure on various cloud platforms, including **AWS, Azure, Google Cloud, and more**. It allows for automated infrastructure deployment, versioning, and reproducibility.

## Basic Terraform Workflow
### 1. **Initialize Terraform**
Before using Terraform, the working directory must be initialized with the following command:
```bash
terraform init
```
This command initializes the directory, downloads necessary provider plugins, and prepares the Terraform environment.

### 2. **Define Infrastructure**
Terraform configurations are written in **.tf** files (e.g., `main.tf`). These files contain provider details and resource definitions. An example configuration for AWS might look like this:
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```

### 3. **Validate Configuration**
Before applying changes, it is recommended to validate the configuration using:
```bash
terraform validate
```
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

