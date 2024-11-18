terraform {
  cloud {
    organization = "Webbio"

    workspaces {
      name = "YoreM_CodePipeline_SlackNotifications"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  required_version = ">= 1.9.8"
}

provider "aws" {
  region = var.region_name
}

module "csnotification" {
  source = "./modules/csnotification"
  slack_channel_id = var.slack_channel_id
  codenotification_pipeline_arn = var.codenotification_pipeline_arn
  }
