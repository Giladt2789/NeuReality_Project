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
  default     = "46.121.252.41/32"
}