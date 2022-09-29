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

variable "instance_name" {
  description = "Pre-defined name for both of the EC2 instances"
  type        = string
  default     = "NeuReality_Nodes"
}