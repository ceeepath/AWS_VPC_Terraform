terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }

  cloud {
    organization = "ceeepath"

    workspaces {
      name = "aws-services"
    }
  }
}

provider "aws" {
  # Configuration options
}