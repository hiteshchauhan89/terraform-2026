variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIARQTU3FTHXSYXDNS6"
}

variable "AWS_SECRET_KEY" {
    type = string
    default = "J43AWDdQn558jjTIbleJ+RzpXq+kKCJnOButDHYW"
}

variable "AWS_REGION" {
default = "us-east-1"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0ecb62995f68bb549"
        us-east-2 = "ami-0f5fcdfbd140e4ab7"
        us-west-2 = "ami-00f46ccd1cbfb363e"
        us-west-1 = "ami-0e6a50b0059fd2cc3"
    }
}

variable "iam_instance_profile_name" {
  description = "Existing IAM instance profile name"
  default     = "s3-levelupbucket-instance-profile"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}