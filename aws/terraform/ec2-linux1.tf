resource "aws_instance" "linux1" {
  ami               = "ami-04681a1dbd79675a5"
  instance_type     = "t2.micro"

  vpc_security_group_ids    = ["${aws_security_group.allow_all.id}"]
  subnet_id                 = "${aws_subnet.main.id}"
  availability_zone         = "${var.default_az}"
  key_name 		            = "${var.default_key}"

  #private_ip        = "11.0.1.20"

  tags {
    Name = "linux1"
  }
}