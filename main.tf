provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "example" {
ami = "ami-01816d07b1128cd2d"
instance_type = "t2.micro"
vpc_security_group_ids =    [aws_security_group.instance.id]

user_data = <<-EOF
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              sed -i 's/listen       80;/listen       8080;/g' /etc/nginx/nginx.conf
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Welcome to My Web Server on Port 8080</h1>" > /usr/share/nginx/html/index.html
            EOF
user_data_replace_on_change = true

tags = {
  Name = "terraform-exaple"
}

}


resource "aws_security_group" "instance" {
name = "terraform-example-instance"
ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}

