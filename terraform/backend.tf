# terraform/backend.tf

resource "aws_s3_bucket" "tf_state" {
  bucket = "lukasprogress-backend-terraform-state"
  force_destroy = true
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
