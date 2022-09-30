# NeuReality - Addmission project for acceptance

## Assumptions i've made for the project
1. The open port for the application is 8182<br/>
2. The OS for the instances was defined as Ubuntu Linux 20.04 (ami-0149b2da6ceec4bb0)
3. For convenience purposes i've decided to open the same ports in K8S cluster for both the Master and the workers 

## Python application
The python app uses Flask as an environment from within python.
The main idea of the application is to reverse the order of a string, given to the search bar.
For example - if the website address is:  
<ins>random.ip.address:8182/reverse?q=string%20to%20reverse</ins><br/>Then the app should print on the web page the result as a json, with this structure:  
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
SSH - port 20
HTTP - port 80
App base port - 8182 (see assumptions above)
ansible ping module (rides on the icmp protocol) - port 8 (this is for personal testing uses)
### Ingress - K8S: (the entire ports map are given in the official K8S website: https://kubernetes.io/docs/reference/ports-and-protocols/)
Kubernetes API server port - 6443
etcd server client API ports - 2379-2380
Kubelet API port - 10250
kube-scheduler - 10259
kube-controller-manager - 10257
NodePort services ports - 30000-32767
### egress:
HTTP - all

## Ansible roles and playbook
Configured each step as role, with the proper tasks directory (inside these directories are each task/s). Task list:<br/>
1. We need to run a local update for the system in order to work on the most recent updates of the OS<br/>
2. We need to create a dedicated user for the installation and management of K8S and docker/containerd (so that we don't work with root)
3. Now we install the K8S as a whole on the cluster
4. Now we configure the master node, and afterwards the workers (in our case - 1 master, 1 worker)

## K8S deployment



