# **Devops Tooling Website Solution**
>### Project Overview
>- #### Introduction
>- #### Implementing a Business Website Using NFS for the Backend File Storage
>- #### Configure Backend Database as Part of 3-tier Architecture

## Introduction

Embarking on a journey to build a comprehensive DevOps tooling website solution and exploring the integration of
various tools and technologies to create a unified platform that enhances collaboration, automation, and efficiency for
software development and operations teams.

In previous Project, we implemented a WordPress based solution that is ready to be filled with content and can be used
as a full fledged website or blog. Moving further we will add some more value to our solutions that your DevOps team
could utilize. We want to introduce a set of DevOps tools that will help our team in day to day activities in managing,
developing, testing, deploying and monitoring different projects.

The tools we want our team to be able to use are well known and widely used by multiple DevOps teams, so we will
introduce a single DevOps Tooling Solution that will consist of:
1. **Jenkins** - free and open source automation server used to build CI/CD pipelines.
2. **Kubernetes** - an open-source container-orchestration system for automating computer application deployment,
scaling, and management.
3. **Jfrog Artifactory** - Universal Repository Manager supporting all major packaging formats, build tools and CI servers.
Artifactory.
4. **Rancher** - an open source software platform that enables organizations to run and manage Docker and Kubernetes
in production.
5. **Grafana** - a multi-platform open source analytics and interactive visualization web application.
6. **Prometheus** - An open-source monitoring system with a dimensional data model, flexible query language, efficient
time series database and modern alerting approach.
7. **Kibana** - Kibana is a free and open user interface that lets you visualize your Elasticsearch data and navigate the
Elastic Stack.
> Note: Do not feel overwhelmed by all the tools and technologies listed above, we will gradually get ourselves familiar with
them in upcoming projects!


### Side Self Study
Read about Network-attached storage (NAS), Storage Area Network (SAN) and related protocols like NFS, (s)FTP, SMB,
iSCSI. Explore what Block-level storage is and how it is used by Cloud Service providers, know the difference from Object
storage. On the example of AWS services understand the difference between Block Storage, Object Storage and Network
File System.

### Setup and technologies used in this Project
As a member of a DevOps team, you will implement a tooling website solution which makes access to DevOps tools within
the corporate infrastructure easily accessible.
In this project you will implement a solution that consists of following components:
1. **Infrastructure:** AWS
2. **Webserver Linux:** Red Hat Enterprise Linux 8
3. **Database Server:** Ubuntu 20.04 + MySQL
4. **Storage Server:** Red Hat Enterprise Linux 8 + NFS Server
5. **Programming Language:** PHP
6. **Code Repository:** GitHub

For Rhel 8 server use this ami:
``` bash 
RHEL-8.6.0_HVM-20220503-x86_64-2-Hourly2-
GP2 (ami-035c5dc086849b5de) 
```
![1 Rhel_8 ec2 instance](https://github.com/Isaiahat/git-learning/assets/148476503/b7a36367-043f-42b8-bef2-3cf2f3cdc217)

On the diagram below you can see a common pattern where several stateless Web Servers share a common database and
also access the same files using Network File Sytem (NFS) as a shared file storage. Even though the NFS server might be
located on a completely separate hardware - for Web Servers it look like a local file system from where they can serve the
same files.

![2  Image depiction of 3tier web app architecture](https://github.com/Isaiahat/git-learning/assets/148476503/d088ca4e-ab5a-44af-97af-25b833f0449c)

It is important to know what storage solution is suitable for what use cases, for this - you need to answer following
questions: what data will be stored, in what format, how this data will be accessed, by whom, from where, how frequently,
etc. Base on this you will be able to choose the right storage system for your solution.
Instructions On How To Submit Your Work For Review And Feedback

## Implementing a business website using NFS for the backend file storage
### Step 1 - Prepare NFS Server
1. Spin up a new EC2 instance with RHEL Linux 8 Operating System. <br>

![1 Rhel_8 ec2 instance](https://github.com/Isaiahat/git-learning/assets/148476503/9b2d482f-cba6-47de-ac21-5cd9442d74b4)

2. Based on your LVM experience from the previous project, Configure LVM on the Server.
- Instead of formating the disks as `ext4` you will have to format them as `xfs` <br>

![3a  Install LVM2](https://github.com/Isaiahat/git-learning/assets/148476503/291d67bc-bce8-4298-941e-7b58e89758a5)

![3b  pvcreate to create 3 pvs](https://github.com/Isaiahat/git-learning/assets/148476503/5634950b-c999-4684-9097-13391242d710)

![3c  add all pv to one vg](https://github.com/Isaiahat/git-learning/assets/148476503/55fe2930-2edf-49c7-9209-82d07a343aa3)

![3d  VGs created](https://github.com/Isaiahat/git-learning/assets/148476503/1987401c-839a-4a01-83bd-515d8b8f0851)

- Ensure there are 3 Logical Volumes. `lv-opt`, `lv-apps`, and `lv-logs`. <br>

![3e  three LVs created](https://github.com/Isaiahat/git-learning/assets/148476503/f1a2d31d-5f50-4d53-b30e-60d0e0555dbf)

![3f  view setup](https://github.com/Isaiahat/git-learning/assets/148476503/6bf8d283-0d54-4b47-8c34-fc873dcb394a)

![3g  format as xfs](https://github.com/Isaiahat/git-learning/assets/148476503/4f76d01e-0912-4d88-8e7b-3b9328fcd3bb)

- Create mount points on `/mnt` directory for the logical volumes as follow: Mount `lv-apps` on `/mnt/apps` - To be
used by webservers, Mount `lv-logs` on `/mnt/logs` - To be used by webserver logs, Mount `lv-opt` on
`/mnt/opt` - To be used by Jenkins server later.

![3h  creating folders](https://github.com/Isaiahat/git-learning/assets/148476503/5aeb4e9a-382f-4746-88ff-04254abf30ba)

![3i  mount folders to lvs](https://github.com/Isaiahat/git-learning/assets/148476503/de60f743-2911-40ed-90b6-dd938ff6eac6)

![3i  mount folders to lvs cont](https://github.com/Isaiahat/git-learning/assets/148476503/9bb17523-b444-45aa-a3b5-b0a0a7be8187)

3. Install NFS server, configure it to start on reboot and make sure it is up and running
``` bash
sudo yum -y update
sudo yum install nfs-utils -y
sudo systemctl start nfs-server.service
sudo systemctl enable nfs-server.service
sudo systemctl status nfs-server.service
```
![4a  update webserver](https://github.com/Isaiahat/git-learning/assets/148476503/885e66f5-9d62-4cdb-b0fe-cc08e3ad0576)

![4b  install nfs server](https://github.com/Isaiahat/git-learning/assets/148476503/fb181270-92d7-4e53-ad5a-f71d703fd12f)

4. Export the mounts for webservers' `subnet cidr` to connect as clients. For simplicity, you will install your all three
Web Servers inside the same subnet, but in production set up you would probably want to separate each tier inside
its own subnet for higher level of security. To check your `subnet cidr` - open your EC2 details in AWS web console
and locate 'Networking' tab and open a Subnet link:

![5  subnet id](https://github.com/Isaiahat/git-learning/assets/148476503/efac0372-3ad1-4224-ac54-8362df2069d7)

Make sure we set up permission that will allow our Web servers to read, write and execute files on NFS:
``` bash
sudo chown -R nobody: /mnt/apps
sudo chown -R nobody: /mnt/logs
sudo chown -R nobody: /mnt/opt
sudo chmod -R 777 /mnt/apps
sudo chmod -R 777 /mnt/logs
sudo chmod -R 777 /mnt/opt
``` 
![6  Grant webservers permission on nfs](https://github.com/Isaiahat/git-learning/assets/148476503/5bd1452a-edbd-40bd-9275-6a315600c3d1)

5. Configure access to NFS for clients within the same subnet (example of Subnet CIDR - `172.31.32.0/20`): <br>
`sudo vi /etc/exports`
``` bash 
/mnt/apps <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
/mnt/logs <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
/mnt/opt <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)

Esc + :wq!

sudo exportfs -arv
```
![7  vi _etc_exports - allow clients within thesame subnets to access NFS](https://github.com/Isaiahat/git-learning/assets/148476503/90f24113-ceb4-4623-b828-acc47040d6ff)

![7b  export subnet cidr to each 3 folder](https://github.com/Isaiahat/git-learning/assets/148476503/8f8b5963-60d3-48f7-b445-888052c23cfb)

6. Check which port is used by NFS and open it using Security Groups (add new Inbound Rule)  <br>
`rpcinfo -p | grep nfs`

![8  Check nfs ports](https://github.com/Isaiahat/git-learning/assets/148476503/51dec1d9-1ac2-4849-89f6-046041c6f668)

> Important note: In order for NFS server to be accessible from your client, you must also open following ports: TCP 111,
UDP 111, UDP 2049

![9  Open TCP   UDP ports](https://github.com/Isaiahat/git-learning/assets/148476503/fed58962-0dc0-47f1-9d1a-69b9177f408d)

## Configure Backend Database as part of 3-Tier Architecture
### Step 2 — Configure the database server
By now we know how to install and configure a MySQL DBMS to work with remote Web Server:
1. Install MySQL server
2. Create a database and name it `tooling`
3. Create a database user and name it `webaccess`
4. Grant permission to webaccess user on tooling database to do anything only from the webservers `subnet
cidr`

![10  Install and configure mysql on DB server](https://github.com/Isaiahat/git-learning/assets/148476503/ce26d86d-0544-421f-acf6-fd06fa621e04)

### Step 3 — Prepare the Web Servers
We need to make sure that our Web Servers can serve the same content from shared storage solutions, in our case - NFS
Server and MySQL database. 

We already know that one DB can be accessed for reads and writes by multiple clients.

For storing shared files that our Web Servers will use - we will utilize NFS and mount previously created Logical Volume
`lv-apps` to the folder where Apache stores files to be served to the users `/var/www`.

This approach will make our Web Servers stateless, which means we will be able to add new ones or remove them
whenever we need, and the integrity of the data (in the database and on NFS) will be preserved.

During the next steps we will do following:
- Configure NFS client (this step must be done on all three servers)
- Deploy a Tooling application to our Web Servers into a shared NFS folder
- Configure the Web Servers to work with a single MySQL database
1. Launch a new EC2 instance with RHEL 8 Operating System

2. Install NFS client <br>
`sudo yum install nfs-utils nfs4-acl-tools -y`
3. Mount `/var/www/` and target the NFS server's export for apps
``` bash
sudo mkdir /var/www
sudo mount -t nfs -o rw,nosuid <NFS-Server-Private-IP-Address>:/mnt/apps /var/www
```
![11  Install NFS on 2nd webserver](https://github.com/Isaiahat/git-learning/assets/148476503/eec9e623-b2fa-4773-9efc-272baf5f1c3b)

![12  mount nfs server's ip on _mnt_apps](https://github.com/Isaiahat/git-learning/assets/148476503/15cba2aa-5f95-41ad-8ba0-47963d09a2d2)

4. Verify that NFS was mounted successfully by running `df -h`. <br> 
Make sure that the changes will persist on Web
Server after reboot: <br>
`sudo vi /etc/fstab` <br>
add following line
``` bash
<NFS-Server-Private-IP-Address>:/mnt/apps /var/www nfs defaults 0 0
```
![13  edit etc_fstab to mk sure changes persist after restart](https://github.com/Isaiahat/git-learning/assets/148476503/b7c37dd5-f203-4b31-a36c-71005a5438a9)

5. Install Remi's repository, Apache and PHP
``` bash
sudo yum install httpd -y

sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm

sudo dnf module reset php

sudo dnf module enable php:remi-7.4

sudo dnf install php php-opcache php-gd php-curl php-mysqlnd

sudo systemctl start php-fpm

sudo systemctl enable php-fpm

setsebool -P httpd_execmem 1
```
![14  Install remi, apache, and php](https://github.com/Isaiahat/git-learning/assets/148476503/de0c63b9-3a28-4517-9089-c4ce8c5f6777)

> Repeat steps 1-5 for another 2 Web Servers.

6. Verify that Apache files and directories are available on the Web Server in `/var/www` and also on the NFS server in
`/mnt/apps`. <br>
If you see the same files - it means NFS is mounted correctly. You can try to create a new file `touch
test.txt` from one server and check if the same file is accessible from other Web Servers.

![15a  create test txt in web01](https://github.com/Isaiahat/git-learning/assets/148476503/5846fbf6-bfce-4088-91bd-c01793d591ad)

![15b  result in web02](https://github.com/Isaiahat/git-learning/assets/148476503/b5bef985-602b-40a2-a910-8e899a179fd6)

![15c  result in web03](https://github.com/Isaiahat/git-learning/assets/148476503/720bc099-122c-4f1d-8b4f-c8bcf0755220)


7. Locate the log folder for Apache on the Web Server and mount it to NFS server's export for logs. Repeat step No.4 to
make sure the mount point will persist after reboot.

![16a  mounting 3x webservers apache log files to NFS's export for logs (_mnt_logs)](https://github.com/Isaiahat/git-learning/assets/148476503/bf12ec46-0232-4232-92e6-82446454e58b)

![16b  edit etc_fstab to make changes permanent](https://github.com/Isaiahat/git-learning/assets/148476503/f8fdc2e1-665e-49f2-a365-23cd82e9dee9)

8. Fork the tooling source code from Darey.io Github Account to your Github account. 

![17  Forked tooling repo](https://github.com/Isaiahat/git-learning/assets/148476503/20399495-cb76-4877-b0b4-65a8790da9d2)

9. Deploy the tooling website's code to the Webserver. Ensure that the html folder from the repository is deployed to
`/var/www/html` <br>
![18  deployed folder from github ](https://github.com/Isaiahat/git-learning/assets/148476503/9fc1b11d-1e61-4f0c-831a-36e850961e7f)

> Note 1: Do not forget to open TCP port 80 on the Web Server.

> Note 2: If you encounter 403 Error - check permissions to your `/var/www/html` folder and also disable SELinux `sudo
setenforce 0` <br>
To make this change permanent - open following config file 
``` bash 
sudo vi /etc/sysconfig/selinux 
```
> and set
SELINUX=disabled then restart httpd.

![19  Disable selinux and restart apache](https://github.com/Isaiahat/git-learning/assets/148476503/8112082c-fcf6-4df0-bf5b-0601ee7bab2a)

![19b  Disable selinux and restart apache](https://github.com/Isaiahat/git-learning/assets/148476503/dc8fea36-9a4c-45e9-a775-c9cf13c27a27)

10. Update the website's configuration to connect to the database (in `/var/www/html/functions.php file`). <br> 
Apply `tooling-db.sql` script to your database using this command
`mysql -h <databse-private-ip> -u <dbusername> -p <db-database-name> < tooling-db.sql`

![20a  tooling file conf copy](https://github.com/Isaiahat/git-learning/assets/148476503/b07eb059-c94c-447d-8934-e82dac9977b4)

![21a  edit functions php - configuring webserver to connect to database](https://github.com/Isaiahat/git-learning/assets/148476503/16fbf544-3585-47fa-84b0-3c45d0185775)


11. Create in MySQL a new admin user with username: and password: <br>
``` bash
INSERT INTO 'users' (`id`, `username`, `password`, `email`, `user_type`, `status`) VALUES -> (1, 'myuser', '5f4dcc3b5aa765d61d8327deb882cf99', 'user@mail.com', 'admin', '1');
```
![create username and psd in database](https://github.com/Isaiahat/git-learning/assets/148476503/852059a4-9aae-43f8-a2dc-935e3142f201)

12. Open the website in your browser http://`<Web-Server-Public-IP-Address-or-Public-DNS-Name>`/index.php
and make sure you can login into the website with myuser user.

![23  web result](https://github.com/Isaiahat/git-learning/assets/148476503/ec85682f-1539-4bef-8707-401cee55e888)

![25 web open](https://github.com/Isaiahat/git-learning/assets/148476503/79e36dae-a30f-4ea3-8bad-83e25b0a79e3)

--------------------------------------------------------------
### Successfully implemented a web solution for a DevOps team using LAMP stack with remote Database and NFS servers.
--------------------------------------------------------------
