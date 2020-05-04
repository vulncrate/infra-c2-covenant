
# VulnCrate: C2 Covenant (Red Team Infrastructure)
This project will use Terraform and Ansible to set up a server on Digital Ocean. I threw in Ansible so that if need be, a different cloud solution provider could be used. That way it's more flexible...

## Covenant C2
Covenant is a .NET Core command and control (C2) framework that was built to make use of the .NET Core Framework for penetration testers. This is a cross-platform application that we will run on an Ubuntu server.

[https://github.com/cobbr/Covenant](https://github.com/cobbr/Covenant)
 
## What does this create?
This will use Terraform to create multiple servers to mask the true identity of the C2 server where Covenant will run.

## This Project is Influenced By
We stole the concept of relaying the requests through a HTTP/S and DNS Redirector from the articles below. I highly recommend that you read those. They are very informative.

[https://ired.team/offensive-security/red-team-infrastructure/automating-red-team-infrastructure-with-terraform](https://ired.team/offensive-security/red-team-infrastructure/automating-red-team-infrastructure-with-terraform)  

[https://rastamouse.me/2017/08/automated-red-team-infrastructure-deployment-with-terraform-part-1/](https://rastamouse.me/2017/08/automated-red-team-infrastructure-deployment-with-terraform-part-1/)

## Terraform
I'm running Terraform on Windows in a Docker container in PowerShell. If you are using Linux, do change "${pwd}" to "$(pwd)". Once in the container you will need to change the permissions to execute and run the setup.sh script to configure your ssh keys properly. You will also need to initialize the Terraform plugins. Run the init function after running the setup.sh script.

docker run -d -it --name terraform --entrypoint "/usr/bin/tail" -v ${pwd}:/workspace -w /workspace hashicorp/terraform:light -f /dev/null  
docker exec -it terraform sh

chmod +x setup.sh  
terraform apply  

### Initialize Terraform Plugins & Providers
terraform init

### Create variables.tf File
Be sure to set the required variables by creating a variables.tf file and configuring it appropriately.
Required variables are: sshdo, dotoken

### Test Plan
terraform plan

### Destroying & Removing the Container
terraform destroy  
exit  
docker rm -f terraform  

## Ansible
Maybe you don't want to host it on Digital Ocean and there isn't an API to create cloud infrastructure. Using Ansible you can configure the server.  

Comming soon...

## Vagrant
Comming soonn...

## Covenant Service
systemctl status covenant.service
journalctl -fu covenant.service