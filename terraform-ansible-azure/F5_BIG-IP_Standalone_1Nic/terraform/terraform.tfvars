#Name of the owner of this deployment (no space)
owner = "owner"

#Name of the project
project_name = "AutomateTemplate"

#Azure Region to use
azure_region = "eastus"

#Azure AZ to use. Need 2
azure_az1 = "1"
azure_az2 = "2"

#Public key to use to access the instances - azure need it in this format
key_path = "~/.ssh/id_rsa.pub"

#Public IPs used to access your instances
AllowedIPs = ["0.0.0.0/32"]

#F5 Image to deploy
f5_version = "latest"
f5_image_name = "f5-bigip-virtual-edition-25m-best-hourly"
f5_product_name = "f5-big-ip-best"

#Value assigned to the tag key Application - will be used for AS3 Service Discovery
app_tag_value = "www-NGINX"