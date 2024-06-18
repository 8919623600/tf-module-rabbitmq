#provision rabbitmq on a ec2 instance

resource "aws_spot_instance_request" "public_instance" {      
  ami                     = data.aws_ami.rabbitmq.id  # fetching ami id from datasource
  instance_type           = var.RABBITMQ_INSTANCE_TYPE
  subnet_id               = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids  = aws_security_group.rabbitmq_sg.id
  wait_for_fulfillment    = true          #  aws waits for 10 mins to provision ( only in case if aws experiences resource limitation  )

  
  

  
  tags = {
    Name = "roboshop-${var.ENV}-rabbitmq"
  }
  
}


