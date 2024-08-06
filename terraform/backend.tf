terraform {
  backend "s3" {
    bucket = "vaibhav12223"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}

