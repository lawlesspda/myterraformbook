provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "example" {
ami = "ami-01816d07b1128cd2d"
instance_type = "t2.micro"

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
