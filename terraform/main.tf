provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "lukasprogress-backend-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

output "visitor_counter_url" {
  value = "${aws_apigatewayv2_api.http_api.api_endpoint}/visits"
  description = "Public URL for the /visits endpoint"
}