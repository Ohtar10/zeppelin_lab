
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "INGRESS_ALLOWED_IP_1" {}
variable "INGRESS_ALLOWED_IP_2" {}
variable "PATH_TO_PUBLIC_KEY" {
  default = "../keys/psl-ds-key.pub"
}
variable "AWS_REGION" {
  default = "sa-east-1"
}

