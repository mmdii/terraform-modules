region     = "us-east-2"
vpc_id     = "default"
subnet_ids = ["subnet-xxxxxxxx"]

ami_id = "ami-04b70fa74e45c3917"

instance_type           = "t2.micro"
key_name                = "development"
allowed_ssh_cidr_blocks = ["0.0.0.0/0"]

user_data = <<-EOF
  #!/bin/bash
  apt update -y
  apt install -y apache2
  echo "Hello, World!" > /var/www/html/index.html
  systemctl start apache2
  systemctl enable apache2
EOF

asg_tag_name = "ASG-Instance"
