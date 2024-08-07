#provision rabbitmq on a ec2 instance

resource "aws_spot_instance_request" "rabbitmq" {    
  ami                     = data.aws_ami.rabbitmq.id  # fetching ami id from datasource
  instance_type           = var.RABBITMQ_INSTANCE_TYPE
  subnet_id               = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[1]
  vpc_security_group_ids  = [aws_security_group.rabbitmq_sg.id]
  wait_for_fulfillment    = true          #  aws waits for 10 mins to provision ( only in case if aws experiences resource limitation  )

  

  tags = {
    Name = "roboshop-${var.ENV}-rabbitmq"
  }
  
}

# Once the server is provisioned, I would like run a playbook that should Configure the RabbitMQ Installation 
resource "null_resource"  "app_install" {
    connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = aws_spot_instance_request.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
    inline = [
        "ansible-pull -U https://github.com/8919623600/ansible.git -e ENV=dev -e COMPONENT=rabbitmq project/ansible-pull.yaml"
    ]
  }
}

