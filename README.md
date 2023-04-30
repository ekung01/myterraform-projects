# myterraform-projects
The objective of this project is to create reuseable AWS infrastructure codes using terraform. We used AWS resources to build the solution in this folder We will start by creation a custom VPC name my-vpc with cidr block of 10.0.0.0/16. The VPC is configured to be deployed in us-west-2 region. To deploy this resource, you will need to own an AWS account. We have created three files: main.tf that handles the resource block, terraform and provider blocks of the code, variable.tf file that handles variables values used for the project. We also have an output.tf file that handles resources output values. To launch this Custom VPC, you will need to use the following commands from within the folder where the template codes are: terraform init, to initialize the plugin of the provider; terraform validate to check if syntaxes are correctly written, terraform plan to see the actual state resourses to be deployed, (note that that terraform wil be able to tell you if the resource you want to deploy exit and react by leting you this resource will be modified or creat if the resource doesnt exit in your environment), terraform apply will deploy the the current state as annouced by plan to desire region. Terraform destroy can be use to tierdown the infrastructure if it is not longer needed.
