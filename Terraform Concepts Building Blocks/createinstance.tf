#############################
# variables.tf (optional)
#############################
variable "AWS_REGION" { default = "us-east-1" }
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c02fb55956c7d316" # Amazon Linux 2 example
  }
}
variable "INSTANCE_USERNAME" { default = "ec2-user" }
variable "PATH_TO_PUBLIC_KEY" {}
variable "PATH_TO_PRIVATE_KEY" {}

#############################
# main.tf
#############################

provider "aws" {
  region = var.AWS_REGION
}

# -------------------------
# Create Key Pair
# -------------------------
resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# -------------------------
# Create EC2 Instance
# -------------------------
resource "aws_instance" "MyFirstInstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name

  tags = {
    Name = "custom_instance"
  }

  # Upload script
  provisioner "file" {
    source      = "installNginx.sh"
    destination = "/tmp/installNginx.sh"
  }

  # Execute script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installNginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/installNginx.sh",
      "sudo /tmp/installNginx.sh"
    ]
  }

  # SSH connection settings
  connection {
    type        = "ssh"
    host        = coalesce(self.public_ip, self.private_ip)
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
