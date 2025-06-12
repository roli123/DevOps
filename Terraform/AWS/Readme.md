## 📄 **Terraform Document: Launch EC2 Instance on AWS**

---

### ✅ **Step 1: Create an IAM User (If Not Already Created)**

1. Log in to the **AWS Console**.
2. Navigate to **IAM** service.
3. In the left sidebar, click **Users**.
4. Click **Add users**:

   * Enter a **username** (e.g., `terraform-user`)
   * Click **Next**
5. Set permissions:

   * Choose **Attach policies directly**
   * Search for **AdministratorAccess**
   * Select it and click **Next**
6. Click **Create user**

---

### 🔐 **Step 2: Create Access Key for the User**

1. Click on the IAM user you just created.
2. Go to the **Security credentials** tab.
3. Click **Create access key**.
4. Choose **Command Line Interface (CLI)**, then click **Next**.
5. Confirm and click **Create access key**.
6. **Copy and save** the **Access Key ID** and **Secret Access Key**.

---

### 📁 **Step 3: Set Up Terraform Configuration**

#### 🧭 Where to Copy Terraform Code From

1. Go to the [Terraform Registry](https://registry.terraform.io/).
2. Click on **Browse Providers** > Select **AWS**.
3. Click **Use Provider** – copy the **provider block** into your `main.tf` file.
4. Scroll to the **Authentication** section of the AWS provider documentation.
5. Copy the version that uses `access_key` and `secret_key`.

---

### 🧾 **main.tf Example File**

Create a file named `main.tf` and paste the following:

```hcl
# Use the provider block from Terraform Registry's AWS Provider page
provider "aws" {
  region     = "us-east-1" # or your preferred region
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

# Search for aws_instance on Terraform Registry and copy the sample resource block
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Example: Amazon Linux 2 AMI (update for your region)
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformEC2"
  }
}
```

> 🔍 Get latest AMI ID from AWS EC2 Console by manually starting to launch a new instance and copying the AMI ID.

---

### ⚙️ **Step 4: Run Terraform Commands**

Run these commands in the terminal from the directory where `main.tf` is located:

```bash
terraform init           # Initializes the project
terraform validate       # Checks for syntax errors
terraform plan -out plan.out  # Prepares the execution plan
terraform apply plan.out      # Applies the plan and launches EC2
terraform destroy        # Tears down the infrastructure
```

---

### 🛡️ **Security Tip**

Avoid hardcoding credentials in `main.tf`. Use environment variables or an AWS credentials file (`~/.aws/credentials`) in production.