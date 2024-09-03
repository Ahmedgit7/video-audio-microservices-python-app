resource "aws_s3_bucket" "videotoaudiobackendbucket" {
    bucket = var.bucket

    
    tags = {
        Name = "Terraform State Storage"
        }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_name
  billing_mode = var.billing_mode
  hash_key     = "LockID"

  read_capacity  = 1  # Minimum value is 1
  write_capacity = 1  # Minimum value is 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform Lock Table"
  }
}

