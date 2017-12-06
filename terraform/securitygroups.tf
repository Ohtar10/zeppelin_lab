
resource "aws_security_group" "psl-ds-lab" {
  vpc_id = "${aws_vpc.psl-ds-main.id}"
  name = "psl-ds-lab"
  description = "security group that allows ssh from a specific IP, http from all addresses and all egress traffic"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.INGRESS_ALLOWED_IP_1}"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.INGRESS_ALLOWED_IP_1}", "${var.INGRESS_ALLOWED_IP_2}"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["${var.INGRESS_ALLOWED_IP_1}"]
  }

  tags {
    Name = "psl-ds-lab"
  }
}