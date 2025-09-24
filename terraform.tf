terraform {
  cloud {
    organization = "AndriusOrg" # Replace with your Terraform Cloud org

    workspaces {
      name = "FlexTeraform" # Replace with your TFC workspace name
      execution_mode = "remote"  # forces local CLI execution (remote/local)
    }
  }
}