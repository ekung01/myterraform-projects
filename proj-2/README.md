# project-01
The objective of this project is to create reuseable terraform AWS infrastructure codes to facilitate deployment.
 This codes will deploy AWS resources in the aws cloud and resources are charged.
 When deploye it will create a custom VPC name my-vpc with cidr block of 10.0.0.0/16. The VPC is configured to be deployed in us-west-2 region. 
 
 To deploy this resource, you will need to own an AWS account. The code have been broken down into four files: main.tf where the resource block, terraform and provider blocks of the code are defined, variable.tf file which defines variables used in the project. We also have an output.tf, this file holds resources output values. 
 To launch this Custom VPC, you will need to use the following commands from within the folder where the template codes are: terraform init, to initialize the plugin of the provider; terraform validate to check if syntaxes are correctly written, terraform plan to see the actual state resourses to be deployed, (note that that terraform will be able to tell you if the resource you want to deploy exit and react by leting you this resource will be modified or creat if the resource doesnt exit in your environment), terraform apply will deploy the current state as annouced by plan to desire region. Terraform destroy can be use to tierdown the infrastructure if it is not longer needed.
