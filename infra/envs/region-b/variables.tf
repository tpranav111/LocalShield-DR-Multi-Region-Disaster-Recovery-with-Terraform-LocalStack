variable "aws_region" {
  type = string
}

variable "localstack_endpoint" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
