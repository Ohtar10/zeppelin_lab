# PSL Data Science Lab with Zeppelin

## Introduction
This repository contains several artifacts to bring up from scratch a fully functional infrastructure on aws to work
with zeppelin notebooks for a data science training laboratory. This repo also contains some notebooks that can be
imported in the running zeppelin instance.

## Prerequisites
* An aws account and a user with full access on EC2 and S3 modules
* aws access keys
* Ansible 2.3.x.x or above
* Terraform version 0.10.x or above
* Docker CE 17.09.0-ce or above (for local development or testing, this will be installed automatically on the aws instances)
* An S3 bucket

## Pre setup
Prior deploying the environment we need to set some artifacts first:

### SSH Key Pair
When creating the infrastructure with terraform we would need to specify a SSH Key pair to access the instances as well as
let ansible access them via ssh or manually for the mather, we can generate the keys with the following command, executed in the 
root folder of this repository:
```
$ ssh-keygen -b 4096 -t rsa -f ./keys/psl-ds-key
```
For testing purposes, don't bother giving a passphrase for unlocking the private key, just hit enter till you get both
the private and public key in place in the 'keys' folder

### Terraform.tfvars
In order make terraform work, we need to specify the aws access keys, these are not committed into the repo hence we need
to create the corresponding file manually.
Create the following file: `./terraform/terraform.tfvars` and add the following content:
```
AWS_ACCESS_KEY = "<YOUR ACCESS KEY>"
AWS_SECRET_KEY = "<YOUR ACCESS SECRET>"
INGRESS_ALLOWED_IP_1 = "<YOUR PUBLIC IP ADDRESS>/32"
INGRESS_ALLOWED_IP_2 = "<SOME OTHER PUBLIC IP ADDRESS>/32"
```

### S3 Bucket
By default, thi inner configuration files for this zeppelin lab will look for a bucket called '*psl-ds-training*' you have
two options, either you create this bucket in your availability zone or create any other then modify some configuration
files prior deploying the infrastructure.

In case you picked the #2, the files that you need to edit are:
* zeppelin-env.sh : look for the word *psl-ds-training* and change it with the bucket name you want
* zeppelin-site.xml : look for the word *psl-ds-training* and change it with the bucket name you want

This lab is configured so that Zeppelin stores the notebooks in this bucket so the can be persisted no matter what
happens to the docker container or the actual instance.

### Unzip Icfes dataset
This laboratory depends on some testing data that for optimization purposes is compressed in the dataset folder, prior 
deploy, please unzip the content of this file `./datasets/icfes_dataset.zip` in the datasets folder. 

### (Optional) Generate credentials for Zeppelin
Zeppelin by default comes with no authentication and authorization enabled, this laboratory performs a small tweak in this
part to enable this feature, however in the most basic and static way through shiro file configuration, if you want to fine
control this you can edit the ./docker/zeppelin/assets/shiro.ini file. by default the file enables AA with a fixed number of users
starting from admin and then 40 regular users, if you open this file you'll notice the passwords are sha256 hashes, the
passwords are as follows: 

#### Passwords

* admin = psl-datascience-lab2017!
* user1 = psl-ds-lab-20171
* user2 = psl-ds-lab-20172
* user3 = psl-ds-lab-20173
* user# = psl-ds-lab-2017# (til # = 40)

In case you want to setup different user accounts, you can generate new ones with `./bin/zeppelin-users.sh`, you can edit this
file to generate the regular users and passwords you need. In case you want to generate a single sha256 password just execute:
```
$ echo -n "mypassword123" | shasum -a 256
```
The output will be the sha256 hash to put on the corresponding shiro.ini file

## Deploy Infrastructure
Just hit `./bin/deploy.sh`, this will execute the terraform apply, create the necessary infrastructure artifacts
and initial setup on the aws instance

#### Access the host 
One the infrastructure is created, the last output in the console usually will be the public dns of the instance, take note
of this since this will be the domain name to be used to access the web interface later.

In case you forget this, you always can know what is the public dns of the instance either by looking in the aws web console,
the `./ansible/host-inventory` file, or hit:
```
$ cd terraform
$ terraform output
``` 
 
## Deploy Zeppelin
After the previous step is completed, you can deploy the actual zeppelin environment through:
```
$ cd ansible
$ ansible-playbook zeppelin_docker_lab.yml --extra-vars "aws_access_key=<YOUR ACCESS KEY> aws_access_secret=<YOUR ACCESS SECRET>"
```
The initial setup will take a while, it needs to pull the necessary docker images and build the custom one for this lab,
after it finishes, you can access to the instance through your browser using the public dns of the instance like mentioned above.

## Restart Zeppelin
Suppose for any reason the instance needed to be shutdown, after restart, the docker containers won't start automatically,
we need to manually do it or by using the ansible playbook:
```
$ cd ansible
$ ansible-playbook restart_continers.yml --extra-vars "aws_access_key=<YOUR ACCESS KEY> aws_access_secret=<YOUR ACCESS SECRET>"
```
After this, you will be able to access Zeppelin again.

## Editing Stuff
You are encouraged of exploring the inners of this repository and perform tweaks at will in order to achieve some specific
results.

## Warning
This is just a playground lab and setup, Zeppelin itself is very wide open and highly insecure, do not give full access to this instance
to any public ip address as might compromise the security in the instance or the aws account itself, use this lab at your own risk
and be sure to stop it or destroy it after finish

## Contact
For inquiries please contact me at: <a href="mailto:lferrod@psl.com.co">lferrod@psl.com.co</a> 