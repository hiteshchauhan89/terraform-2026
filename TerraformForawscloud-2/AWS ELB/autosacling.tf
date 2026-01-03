# AutoScaling Launch Template
resource "aws_launch_template" "levelup_launchtemplate" {
  name_prefix   = "levelup-launchtemplate-"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name

  vpc_security_group_ids = [
    aws_security_group.levelup-instance.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get -y install net-tools nginx
    MYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`
    echo 'Hello Team
    This is my IP: '$MYIP > /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "LevelUp Custom EC2 instance via LB"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Generate Key
resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Autoscaling Group
resource "aws_autoscaling_group" "levelup-autoscaling" {
  name                = "levelup-autoscaling"
  vpc_zone_identifier = [
    aws_subnet.levelupvpc-public-1.id,
    aws_subnet.levelupvpc-public-2.id
  ]

  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 200
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.levelup-elb.name]
  force_delete              = true

  launch_template {
    id      = aws_launch_template.levelup_launchtemplate.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "LevelUp Custom EC2 instance via LB"
    propagate_at_launch = true
  }
}

output "ELB" {
  value = aws_elb.levelup-elb.dns_name
}
