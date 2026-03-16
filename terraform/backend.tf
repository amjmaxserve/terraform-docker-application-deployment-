terraform {

  backend "s3" {

    bucket = "terraform-state"
    key    = "3tier/terraform.tfstate"
    region = "us-east-1"

    access_key = "admin"
    secret_key = "password"

    endpoints = {
      s3 = "http://192.168.29.88:9000"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_region_validation      = true

    force_path_style = true
  }

}
