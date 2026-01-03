data "aws_availability_zones" "available" {}
  
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMI, var.AWS_REGION)   # Amazon Linux 2 (example AMI)
  instance_type = "t2.micro"               # Free-tier eligible instance
  availability_zone = data.aws_availability_zones.available.names[0]

  provisioner "local-exec" {
    command = "echo ${aws_instance.MyFirstInstnace.private_ip} > private_ip.txt"
  }
    

  tags = {
    Name = "MyFirstInstance"
  }

  output "public_ip" {
  value = aws_instance.MyFirstInstnace.public_ip
  description = "Public IP of the instance"
}
}