# Key Pair
resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# EC2 Instance
resource "aws_instance" "my_first_instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name

  tags = {
    Name = "custom_instance"
  }
}

# EBS Volume
resource "aws_ebs_volume" "ebs_volume_1" {
  availability_zone = aws_instance.my_first_instance.availability_zone
  size              = 20

  tags = {
    Name = "extra_ebs_volume"
  }
}

# Attach EBS Volume to EC2
resource "aws_volume_attachment" "ebs_volume_1" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_1.id
  instance_id = aws_instance.my_first_instance.id
}
