# Ansible Configuration Management - Automate Project
## Overview:
> - #### Introduction
> - #### Install and configure ansible on ec2 instance
> - #### Develop Ansible
> - #### Create a playbook
> - #### Run ansible test
> ---------------------------------------------------------

## Introduction

In preceding projects, we had to perform a lot of manual operations to set up virtual servers, install and configure required software and deploy your web application.

This Project will help us appreciate DevOps tools even more by making most of the routine tasks automated with
Ansible Configuration Management, at the same time it helps us become confident with writing code using declarative
languages such as YAML.


### Ansible Client as a Jump Server (Bastion Host)
A Jump Server (sometimes also referred as Bastion Host) is an intermediary server through which access to internal
network can be provided. If you think about the current architecture you are working on, ideally, the webservers would be inside a secured network which cannot be reached directly from the Internet. That means, even DevOps engineers cannot
SSH into the Web servers directly and can only access it through a Jump Server - it provides better security and reduces
attack surface.

On the diagram below the Virtual Private Network (VPC) is divided into two subnets - Public subnet has public IP
addresses and Private subnet is only reachable by private IP addresses.

-----------------
-----------------

Later on, we will explore further on Bastion host in proper action. But for now, we will develop **Ansible** scripts to simulate the use of a `Jump box/Bastion
host` to access our Web Servers.
#### Tasks
> 1. Install and configure Ansible client to act as a Jump Server/Bastion Host
> 2. Create a simple Ansible playbook to automate servers configuration

## Install and configure ansible on ec2 instance
### Step 1 - Install and Configure Ansible on EC2 Instance
1. Update the Name tag on your Jenkins EC2 Instance to Jenkins-Ansible . We will use this server to run
playbooks.
2. In your GitHub account create a new repository and name it ansible-config-mgt.
3. Install Ansible (see: install Ansible with pip)
``` bash 
sudo apt update
sudo apt install ansible
``` 

Check your Ansible version by running:
``` bash
 ansible --version

```

4. Configure Jenkins build job to archive your repository content every time you change it - this will solidify your
Jenkins configuration skills.
> - Create a new Freestyle project ansible in Jenkins and point it to your 'ansible-config-mgt' repository.
> - Configure a webhook in GitHub and set the webhook to trigger ansible build.
> - Configure a Post-build job to save all ( ** ) files.

5. Test your setup by making some change in README.md file in master branch and make sure that builds starts
automatically and Jenkins saves the files (build artifacts) in following folder
``` bash
ls /var/lib/jenkins/jobs/ansible/builds/<build_number>/archive/
```
> Note: Trigger Jenkins project execution only for main (or master) branch.

Now your setup will look like this:
---------------------
---------


> **Tip:** Every time you stop/start your Jenkins-Ansible server - you have to reconfigure GitHub webhook to a new IP
address, in order to avoid it, it makes sense to allocate an Elastic IP to your Jenkins-Ansible server (you have done it
before to your LB server in Project 10). Note that Elastic IP is free only when it is being allocated to an EC2 Instance, so do
not forget to release Elastic IP once you terminate your EC2 Instance.

### Step 2 - Prepare your development environment using Visual Studio Code

1. First part of 'DevOps' is 'Dev', which means you will require to write some codes and you shall have proper tools
that will make your coding and debugging comfortable - you need an Integrated development environment (IDE) or
Source-code Editor. 
There is a plethora of different IDEs and source-code Editors for different languages with their
own advantages and drawbacks, you can choose whichever you are comfortable with, but we recommend one free
and universal editor that will fully satisfy your needs - Visual Studio Code (VSC).

2. After you have successfully installed VSC, configure it to connect to your newly created GitHub repository.

3. Clone down your ansible-config-mgt repo to your Jenkins-Ansible instance
`git clone <ansible-config-mgt repo link>` <br>

## Develop ansible

### Step 3 - Begin Ansible Development

1. In your ansible-config-mgt GitHub repository, create a new branch that will be used for development of a new
feature.
> **Tip:** Give your branches descriptive and comprehensive names, for example, if you use Jira or Trello as a project
management tool - include ticket number (e.g. PRJ-145 ) in the name of your branch and add a topic and a brief
description what this branch is about - `a bugfix`, `hotfix`, `feature`, `release` (e.g. `feature/prj-145-lvm`).

2. Checkout the newly created feature branch to your local machine and start building your code and directory
structure

3. Create a directory and name it `playbooks` - it will be used to store all your playbook files.

4. Create a directory and name it `inventory` - it will be used to keep your hosts organised.

5. Within the playbooksfolder, create your first playbook, and name it common.yml

6. Within the inventory folder, create an inventory file () for each environment (Development, Staging Testing and
Production) dev , staging , uat , and prod respectively. These inventory files use .ini languages style to
configure Ansible hosts.

### Step 4 - Set up an Ansible Inventory

An Ansible inventory file defines the hosts and groups of hosts upon which commands, modules, and tasks in a playbook
operate. Since our intention is to execute Linux commands on remote hosts, and ensure that it is the intended
configuration on a particular server that occurs. It is important to have a way to organize our hosts in such an Inventory.

Save the below inventory structure in the `inventory/dev` file to start configuring your development servers. Ensure to
replace the IP addresses according to your own setup.

> **Note:** Ansible uses TCP port 22 by default, which means it needs to ssh into target servers from Jenkins-Ansible host - for this you can implement the concept of ssh-agent. Now you need to import your key into ssh-agent:
``` bash
eval `ssh-agent -s`
ssh-add <path-to-private-key>
```
Confirm the key has been added with the command below, you should see the name of your key

``` bash
ssh-add -l
```

Now, ssh into your `Jenkins-Ansible` server using ssh-agent
``` bash
ssh -A ubuntu@public-ip
``` 
<br>
Update your `inventory/dev.yml` file with this snippet of code:
``` bash
[nfs]
<NFS-Server-Private-IP-Address> ansible_ssh_user=ec2-user
[webservers]
<Web-Server1-Private-IP-Address> ansible_ssh_user=ec2-user
<Web-Server2-Private-IP-Address> ansible_ssh_user=ec2-user
[db]
<Database-Private-IP-Address> ansible_ssh_user=ec2-user
[lb]
<Load-Balancer-Private-IP-Address> ansible_ssh_user=ubuntu
``` 

## Create a playbook

### Step 5 - Create a Common Playbook

It is time to start giving Ansible the instructions on what you need to be performed on all servers listed in
inventory/dev.

Create a playbook and name it `common.yml`. In common.yml playbook you will write configuration for repeatable, re-usable, and multi-machine tasks that is common
to systems within the infrastructure.

Update your playbooks/common.yml file with following code:
``` bash
---
- name: update web, nfs and db servers
hosts: webservers, nfs, db
become: yes
tasks:
- name: ensure wireshark is at the latest version
yum:
name: wireshark
state: latest
- name: update LB server
hosts: lb
become: yes
tasks:
- name: Update apt repo
apt:
update_cache: yes
- name: ensure wireshark is at the latest version
apt:
name: wireshark
state: latest
```

Examine the code above and try to make sense out of it. This playbook is divided into two parts, each of them is intended to
perform the same task: install wireshark utility (or make sure it is updated to the latest version) on your RHEL 8 and
Ubuntu servers. It uses root user to perform this task and respective package manager: yum for RHEL 8 and apt for
Ubuntu.

Feel free to update this playbook with following tasks:

- Create a directory and a file inside it
- Change timezone on all servers
- Run some shell script

### Step 6 - Update GIT with the latest code

Now all of your directories and files live on your machine and you need to push changes made locally to GitHub.
In the real world, we will be working within a team of other DevOps engineers and developers and it is important to learn how
to collaborate with help of GIT. 

In some organisations there is usually a rule that one shouldn't deploy any code unless it has been reviewed by an extra pair of eyes - it is also called **"Four eyes principle".**

Now you have a separate branch, you will need to know how to raise a Pull Request (PR), get your branch peer reviewed
and merged to the master branch.

Commit your code into GitHub:
1. Use git commands to add, commit and push your branch to GitHub. <br>
`git status` <br>
`git add <selected files>` <br>
`git commit -m "commit message"`

2. Create a Pull request (PR)

3. Wear the hat of another developer for a second, and act as a reviewer.

4. If the reviewer is happy with your new feature development, merge the code to the master branch.

5. Head back on your terminal, checkout from the feature branch into the master, and pull down the latest changes.
Once your code changes appear in master branch - Jenkins will do its job and save all the files (build artifacts) to
`/var/lib/jenkins/jobs/ansible/builds/<build_number>/archive/`
directory on Jenkins-Ansible server.

## Run ansible test

### Step 7 - Run first Ansible test

Now, it is time to execute ansible-playbook command and verify if your playbook actually works:
1. Setup your VSCode to connect to your instance as demonstrated by the video above. Now run your playbook using
the command: 
``` bash
cd ansible-config-mgt
```

``` bash
ansible-playbook -i inventory/dev.yml playbooks/common.yml
```

> **Note:** Make sure you're in your ansible-config-mgt directory before you run the above command.
You can go to each of the servers and check if wireshark has been installed by running `which wireshark` or `wireshark
--version`
Your updated with Ansible architecture now looks like this:
----------------
----------------

Update your ansible playbook with some new Ansible tasks and go through the full `checkout -> change codes ->
commit -> PR -> merge -> build -> ansible-playbook` cycle again to see how easily you can manage a servers fleet of
any size with just one command!

#### Conclusion
A routine task has just being automated by implementing Ansible. 
