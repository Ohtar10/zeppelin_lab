

resource "aws_key_pair" "psl-ds-key" {
  key_name = "psl-ds-key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_eip" "psl-ds-training-big-eip" {
  instance = "${aws_instance.psl-ds-training-big.id}"
  vpc = true
}

resource "aws_instance" "psl-ds-training-big" {
  # Ubuntu 16.04 LTS on sa-east-1
  ami           = "ami-466b132a"
  instance_type = "t2.2xlarge"
  key_name = "${aws_key_pair.psl-ds-key.key_name}"

  # set the security group
  vpc_security_group_ids = ["${aws_security_group.psl-ds-lab.id}"]

  # set the VPC subnet
  subnet_id = "${aws_subnet.psl-ds-main-public.id}"

  root_block_device {
    volume_size = "200"
    volume_type = "gp2"
    delete_on_termination = true
  }

  tags {
    Name = "PSL DS Training Bigger"
    Description = "Data Science Lab Machine"
  }
}
