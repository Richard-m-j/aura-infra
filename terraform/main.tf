terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "aura-app-richard" 
    key            = "terraform.tfstate"       
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-richard"   
    encrypt        = true
  }
}
 
provider "aws" {
  region = "us-east-1"
}