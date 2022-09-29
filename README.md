# NeuReality - Addmission project for acceptance

## Assumptions i've made for the project
1. The open port for the application is 8182<br/>
2. The OS for the instances was defined as Ubuntu Linux 20.04 (ami-0149b2da6ceec4bb0
)

## Python application
The python app uses Flask as an environment from within python.
The main idea of the application is to reverse the order of a string, given to the search bar.
For example - if the website address is:  
<ins>random.ip.address:8182/reverse?q=string%20to%20reverse</ins><br/>Then the app should print on the web page the result as a json, with this structure:  
{Result: <ins>reverse to string</ins>}

## Terraform script and dependencies files
The environment is defined with EC2 instances, of type t3.medium.<br/>
Pre-defined key-pair was created prior to the task, and its name is provided below as variable. <br/>
The only 2 variables that the user should provide is: <br/>
1. Region (in this project - defined as "eu-central-1")<br/>
2. Key-pair, which at the moment provided as my own ("Gilad")
The security group created for this project containing these ports: <br/>
### Ingress:
SSH - port 20
HTTP - port 80
App base port - 8182 (see assumptions above)
### egress:
HTTP - all

## Ansible roles and playbook
Configured each step as role, with the proper tasks directory (inside these directories are each task/s). <br/>
### K8S isn't installed yet

## K8S deployment



