data "aws_ami" "linux_ami" {
  most_recent      = true
  executable_users = ["self"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["Amazon Linux*"]
  }

}


resource "aws_instance" "linux1" {
  ami               = "${data.aws_ami.linux_ami.id}"
  instance_type     = "t2.micro"

  vpc_security_group_ids    = ["${aws_security_group.allow_all.id}"]
  subnet_id                 = "${aws_subnet.primary.id}"
  availability_zone         = "${data.aws_availability_zones.available.names[0]}"
  key_name 		            = "${var.default_key}"

  #private_ip        = "11.0.1.20"

  tags {
    Name = "linux1"
  }
}

output "linux1_public_dns" {
  value = "${aws_instance.linux1.public_dns}"
}
