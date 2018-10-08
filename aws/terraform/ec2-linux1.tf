data "aws_ami" "linux_ami" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  owners     = ["amazon"]

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
