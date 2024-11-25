variable "bucket_name" {
  default     = "terraform-state-bucket" # Should be globally unique
  description = "The name of the S3 bucket to store Terraform state"
}

variable "dynamodb_table_name" {
  default     = "terraform-locks"
  description = "The name of the DynamoDB table to lock Terraform state"
}

variable "region" {
  default     = "us-east-2"
  description = "The region of the S3 bucket to store Terraform state"
}