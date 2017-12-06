
output "ds-lab-dns" {
  value = "${aws_instance.psl-ds-training-big.public_dns}"
}
