# Terraform AWS Initial Setup

This setup creates the required AWS resources to manage your Terraform state, including an S3 bucket for storing state files and a DynamoDB table for state locking.

## Steps to Use

1. **Update Variables**
   Modify the values of the variables in `variables.tf` or pass them directly when running Terraform commands. The key variables to update are:
   - region: The AWS region to deploy resources in.
   - bucket_name: The name for the S3 bucket.
   - dynamodb_table_name: The name for the DynamoDB table.

2. **Initialize and Plan**
   Run the following commands to initialize and validate the setup:
   terraform init
   terraform plan

3. **Apply Changes**
   Apply the plan to create the resources:
   terraform apply

4. **Migrate State to S3**
   After creating the resources, move your existing Terraform state file (terraform.tfstate) to the newly created S3 bucket. Use the AWS CLI or another method:
   aws s3 cp terraform.tfstate s3://<your_bucket_name>/terraform.tfstate

5. **Enable Remote State**
   Uncomment the remote backend configuration in your Terraform code (if commented out), pointing to the created S3 bucket and DynamoDB table:

   terraform {
     backend "s3" {
       bucket         = "<your_bucket_name>"
       key            = "terraform.tfstate"
       region         = "<your_region>"
       dynamodb_table = "<your_dynamodb_table_name>"
     }
   }

6. **Reinitialize with Remote Backend**
   Reinitialize Terraform to enable the remote backend:
   terraform init

## Notes
- The S3 bucket has versioning enabled and public access blocked for security.
- The DynamoDB table is configured to ensure state locking and prevent concurrent state updates.
- Adjust read_capacity and write_capacity in aws_dynamodb_table if handling a high volume of changes.

Happy Terraforming!
