# NeuReality - Addmission project for acceptance

## Assumptions i've made for the project
1. The open port for the application is 8182<br/>
2. The OS for the instances was defined as Ubuntu Linux 20.04 (ami-0149b2da6ceec4bb0)
   (note: this ami is valid via eu-central-1)
3. For convenience purposes i've decided to open the same ports in K8S cluster for both the Master and the workers 

## Python application
The python app uses Flask as an environment from within python.
The main idea of the application is to reverse the order of a string, given to the search bar.
For example - if the website address is:  
<ins>random.ip.address:31590/reverse?q=string%20to%20reverse</ins><br/>Then the app should print on the web page the result as a json, with this structure:  
{Result: <ins>reverse to string</ins>}

## Terraform script and dependencies files
The environment is defined with EC2 instances, of type t3.medium.<br/>
Pre-defined key-pair was created prior to the task, and its name is provided below as variable. <br/>
The only variables that the user should provide is: <br/>
1. Region (in this project - defined as "eu-central-1")<br/>
2. Key-pair, which at the moment provided as my own ("Gilad")
3. In order to connect to ths VM's from the owners public ip, there's a variable named "personal_ip"
The security group created for this project containing these ports: <br/>

### Ingress - global:
SSH - port 20<br/>
HTTP - port 80<br/>
App base port - 8182 (see assumptions above)<br/>
ansible ping module (rides on the icmp protocol) - port 8 (this is for personal testing uses)<br/>
### Ingress - K8S: (the entire ports map are given in the official K8S website: https://kubernetes.io/docs/reference/ports-and-protocols/)
Kubernetes API server port - 6443<br/>
etcd server client API ports - 2379-2380<br/>
Kubelet API port - 10250<br/>
kube-scheduler - 10259<br/>
kube-controller-manager - 10257<br/>
NodePort services ports - 30000-32767<br/>
### egress:
HTTP - all<br/>

Upon creating the infrastructure, the public ip addresses of the new vm's should appear on screen.<br/>
Those ip addresses should be written to the ansible hosts file (located at: /etc/ansible/hosts)

## Ansible roles and playbook
In order to connect to those vm's to run the ansible playbooks, the private key should be provided in the configuration file at (/home/<user_name>/.ansible.cfg) <br/>
Before everything, the dedicated user (that controls the infrastructure) should go to: /etc/ansible/hosts and insert the following:<br/>
[K8S_Master]<br/>
  default_os_user@public_ipv4_dns <br/>
[K8S_Nodes] <br/>
  default_os_user@public_ipv4_dns <br/>
------------------------------------------------<br/>
For example, this is how i did it on my machine: (don't worry, these ip's aren't valid anymore)<br/>
[K8S_Master]<br/>
  ubuntu@ec2-18-156-199-195.eu-central-1.compute.amazonaws.com 
[K8S_Nodes] <br/>
  ubuntu@ec2-3-66-210-81.eu-central-1.compute.amazonaws.com

Upon doing this, and copying the following file (from this repo): <.ansible.cfg> to the location: </home/USER/>.<br/>
Now, with each step configured as role, with the proper tasks directory (inside these directories are each task/s) we can run the Playbook.yaml file. Task list:<br/>
1. Create a dedicated user for the installation and management of K8S and docker/containerd (so that we don't work with root). In this role it is prompted the user to define the new user name. i chose the name: kube, but you can choose as you like <br/>
2. Then, we install relevant packages, including updating the OS (as much as needed), installing docker, containerd and so on. <br/>
3. Now, i've initialized the cluster (with the role under the same name). the network supplier for the cluster that i chose was calico, but with specific modification - you can choose another (like Weave, Flannel and so on).
4. After initializing the cluster, the master will create a token command and will address this to the worker node/s. Afterwards - the cluster is complete.
5. Once the entire cluster is prepared for deployments, the final stage is to run the deployment:<br/>
5.1. First deployment is of the ingress controller (in order to expose the application to the outer web).<br/>
5.2. Second deployment is of the application (which has already been uploaded to the Dockerhub - the Dockerfile is in the Python directory)<br/>

In order to test the app, one should simply type:<br/>
k8s.node.ip.address:31590/reverse?q=string%20to%20reverse <br/>
(as mentioned above: 31590 - the port that k8s exposes from the app)<br/>
and the output should be:
{"Result": "reverse to string"}



