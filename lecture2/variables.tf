variable "AWS_ACCESS_KEY" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_KEY" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "AWS_REGION" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "Security_Group" {
  type = list(string)
  default = ["sg-0bde8ebdc70a9a65d"]
}

variable "AMI" {
    type = map
    default = {
        "us-east-1" = "ami-0c6b1d09930fac512"
        "us-west-1" = "ami-013196b2eaab486da"
        "eu-west-1" = "ami-0d7a7616765cce740"
        "us-east-2" = "ami-05803413c51f242b7"
    }
  
}