#Name of the owner of this deployment (no space)
owner = "NicoM"

#Name of the project
project_name = "TestTerraform"

#AWS Region to use
aws_region = "eu-west-1"

#AWS AZ to use. Need 2
aws_az1 = "eu-west-1b"
aws_az2 = "eu-west-1c"

#Public key to use to access the instances
key_path = "/Users/menant/.ssh/id_rsa.pub"

#Public IPs used to access your instances
AllowedIPs = "109.7.65.101/32"

#Value assigned to the tag key Application - will be used for AS3 Service Discovery
app_tag_value = "www-NGINX"