provider "aws" {
  region = var.AWS_REGION
}

module "ec2-cluster" {
    source  = "terraform-aws-modules/ec2-instance/aws"

    name = "my-cluster"
    ami = "ami-0ecb62995f68bb549"
    instance_type= "t2.micro"
    subnet_id ="subnet-0ca16fdf866acfc79"
    count = var.environment == "Production" ? 2 : 1

    tags={
    Terraform = "true"
    Environment = "dev"
    }
  
}