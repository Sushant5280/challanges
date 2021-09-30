## Provision AWS Resources ##

This document provides an overview of the `Terraform` based
resources created on AWS like VPC,Subnets,EKS Cluster and worker nodes.

### Pre-requisites ###
* Install terraform on your system: https://learn.hashicorp.com/tutorials/terraform/install-cli
* Install AWS CLI on your system: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
* Install kubectl on your system: https://kubernetes.io/docs/tasks/tools/

It does the following:

#### Runs Terraform and Kuberentes Deployments
​
* Check terraform install on your system "terraform --version"
* Run "terraform init" to Initialize a Terraform working directory and download provider plugin
* Run "terraform plan" Generate and show an execution plan
* It will ask for access key & secret key of IAM user
* After putting secret credentials it will deploy services in "us-east-1"
* Run "terraform apply" apply manifest (it will take time 15 to 20min to deploy stack)
* Run "tail -f terrform.log" to see the logs
* After deployment complated it will kubeconfig from terraform output and save as "kubeconfig"
* Either add kubeconfig to your local ~/.kube/config or "export KUBECONFIG=kubeconfig"
* You can verify the worker nodes are joining the cluster via: "kubectl get nodes"
* Run "terraform destroy" to destroy resources created by terraform (it will take time 15 to 20min to destroy stack).