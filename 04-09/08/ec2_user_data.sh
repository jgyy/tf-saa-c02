#!/bin/bash
yum update -y
yum install -y httpd amazon-efs-utils
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" >/var/www/html/index.html
