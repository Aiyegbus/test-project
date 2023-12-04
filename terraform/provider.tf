terraform {
  cloud {
    organization = "Ayodev"

    workspaces {
      name = "test-projet"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}
