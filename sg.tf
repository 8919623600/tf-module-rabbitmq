resource "aws_security_group" "rabbitmq_sg" {
  description = "mysql_sg created from terraform"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

tags = {
    Name = "roboshop-${var.ENV}-mysql-sg"
}

  
 ingress {
    from_port       = var.RABBITMQ_PORT
    to_port         = var.RABBITMQ_PORT
    protocol        = "tcp"
    # cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_ID, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]

  }
  
  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    # cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_ID, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]

  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


}
