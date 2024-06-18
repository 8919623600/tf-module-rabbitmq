# datasource that reads the info from vpc statefile 
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-devops29master"
    key    = "dev/terrafile/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "rabbitmq" {                       # ansible is installed on this to run ansible for configuration
  most_recent      = true
  name_regex       = "devops-workstation-image"
  owners           = ["851725330688"]

}