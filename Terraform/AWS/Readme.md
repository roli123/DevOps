
## 📄 **Terraform Document: Launching AWS EC2 Instance**


### ✅ **Step 1: Create an IAM User (If Not Already Created)**

1. Log in to **AWS Console**.
2. Navigate to **IAM** service.
3. On the left sidebar, click **Users**.
4. Click **Add users**:

   * **User name**: (e.g., `terraform-user`)
   * Click **Next**
5. Set permissions:

   * Choose **Attach policies directly**
   * Search and select **AdministratorAccess** (for full permissions)
   * Click **Next** and then **Create user**

---

### 🔐 **Step 2: Create Access Key**

1. After creating the user, click on the username.
2. Go to the **Security credentials** tab.
3. Click **Create access key**.
4. Choose **Command Line Interface (CLI)**, then **Next**.
5. Confirm and click **Create access key**.
6. **Copy the Access Key and Secret Key**.

---

### 📁 **Step 3: Create Terraform Configuration**

1. Create a directory for your Terraform project:

   ```bash
   mkdir terraform-ec2
   cd terraform-ec2
   touch main.tf
   ```

2. Open `main.tf` and add the following configuration:

```hcl
# main.tf

provider "aws" {
  region     = "us-east-1" # Change as needed
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (change based on region)
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformEC2"
  }
}
```

> 🔒 **Note**: Avoid hardcoding credentials in production. Use environment variables or AWS credentials file for security.

---

### ⚙️ **Step 4: Initialize and Deploy Terraform**

Run the following commands in your terminal:

```bash
# Initialize Terraform
terraform init

# Validate the configuration
terraform validate

# Create an execution plan
terraform plan -out plan.out

# Apply the plan
terraform apply plan.out

# To destroy the resources
terraform destroy
```

---

### 📝 **Extra Tips**

* To find the latest AMI ID:

  * Go to AWS EC2 Console → Launch Instance → Choose an AMI → Copy its ID
* Keep your access keys secure.
* Use `terraform output` if you want to view instance details after creation.