provider "aws" {
  region                  = "${local.region}"
  profile                 = "personal_admin"
  shared_credentials_file = "../credentials/credentials"
  version                 = "~> 1.37"
}
