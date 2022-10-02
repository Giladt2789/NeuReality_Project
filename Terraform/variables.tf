variable "aws_region" {
  description = "Pre-defined region name by variable"
  type        = string
  default     = "eu-central-1"
}

variable "aws_key_pair" {
  description = "Pre-configured key pair by variable"
  type        = string
  default     = "GRKeypair"
}

variable "personal_ip" {
  description = "my local ip address, so i can control my infrastructure"
  type        = string
  default     = "213.57.121.34/32"
}

variable "location_of_key" {
  description = "The location of the saved key-pair"
  type        = string
  default     = "/home/gilad/Documents/Private/GRKeypair.pem"
}

variable "ami_id" {
  description = "The ami-id for the instances"
  type        = string
  default     = "ami-06148e0e81e5187c8"
}