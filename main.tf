provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "example" {
ami = "ami-01816d07b1128cd2d"
instance_type = "t2.micro"
key_name      = "mykey"
vpc_security_group_ids = [aws_security_group.instance.id]

user_data = <<-EOF
    #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Welcome to My Web Server</h1>" > /usr/share/nginx/html/index.html
            EOF


tags = {
  Name = "terraform-exaple"
}

}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
ingress {
    description = "Allow 443 from the Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 80802
    to_port     = 80802
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from all IPs
  }

   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from all IPs
  }
}
