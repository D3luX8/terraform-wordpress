#!/bin/bash
yum install amazon-linux-extras httpd -y 
amazon-linux-extras install php7.2 -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf latest.tar.gz
chmod -R 755 /var/www/html/*
chown -R apache:apache /var/www/html/*
cp wp-config-sample.php wp-config.php
dbname=$(aws ssm get-parameter --name /wp-tf/dbcredentials/dbname --region us-east-2 --output text --with-decryption --query 'Parameter.Value')
endpoint=$(aws ssm get-parameter --name /wp-tf/dbcredentials/endpoint --region us-east-2 --output text --with-decryption --query 'Parameter.Value')
password=$(aws ssm get-parameter --name /wp-tf/dbcredentials/dbpassword --region us-east-2 --output text --with-decryption --query 'Parameter.Value')
username=$(aws ssm get-parameter --name /wp-tf/dbcredentials/dbusername --region us-east-2 --output text --with-decryption --query 'Parameter.Value') 

 sed -i "s/database_name_here/$dbname/" wp-config.php
 sed -i "s/username_here/$username/" wp-config.php
 sed -i "s/password_here/$password/" wp-config.php
 sed -i "s/localhost/$endpoint/" wp-config.php
 
