
# Implementing Wordpress website with LVM Storage management
## Overview
- ## Introduction: Understanding 3-Tier Architevture
- ## Implememting LVM on Linux Servers (Web and Database servers)
- ## Installing and Configuring WordPress to use MySQL Database

## Understanding 3 Tier Architecture
### Web Solution with WordPress

 As a DevOps engineer you will
most probably encounter PHP-based solutions since, even in 2021, it is the dominant web programming language used by
more websites than any other programming language.
In this project we are tasked to prepare a storage infrastructure on two Linux servers and implement a basic web
solution using WordPress. 

WordPress is a free and open-source content management system written in PHP and paired
with MySQL or MariaDB as its backend Relational Database Management System (RDBMS).

This project consists of two parts:
> **1. Configure storage subsystem for Web and Database servers based on Linux OS.** 

The focus of this part is to give you
practical experience of working with disks, partitions and volumes in Linux.
> **2. Install WordPress and connect it to a remote MySQL database server.** 

This part of the project will solidify our skills
of deploying Web and DB tiers of Web solution.

As a DevOps engineer, your deep understanding of core components of web solutions and ability to troubleshoot them will
play essential role in further progress and development.

### Three-tier Architecture
Generally, web, or mobile solutions are implemented based on what is called the Three-tier Architecture. 

<br> **Three-tier Architecture** is a client-server software architecture pattern that comprise of 3 separate layers. <br>

![1  Depicted image](https://github.com/Isaiahat/git-learning/assets/148476503/3aa8de04-bb0f-46b2-9810-26050e111562)

- **1. Presentation Layer (PL):** This is the user interface such as the client server or browser on your laptop.
- **2. Business Layer (BL):** This is the backend program that implements business logic. Application or Webserver
- **3. Data Access or Management Layer (DAL):** This is the layer for computer data storage and data access. Database
Server or File System Server such as FTP server, or NFS Server
In this project, you will have the hands-on experience that showcases Three-tier Architecture while also ensuring that the
disks used to store files on the Linux servers are adequately partitioned and managed through programs such as gdisk
and LVM respectively.<br>

Your 3-Tier Setup
1. A Laptop or PC to serve as a client
2. An EC2 Linux Server as a web server (For Wordpress)
3. An EC2 Linux server as a database (DB) server

We shall use RedHat OS for this project

Let us get started! <db> 

## Implementing LVM on Linux servers (Web and Database servers)
### Step 1 — Prepare a Web Server
1. Launch an EC2 instance that will serve as "Web Server". <br>
Create 3 volumes in the same Availability Zone as your Web Server EC2,
each of 10 GiB. <br>

![1  Wordpress redhat instance](https://github.com/Isaiahat/git-learning/assets/148476503/8caf4713-deba-4d03-98ba-c5aa6597a2ee)

![2a  Create volume](https://github.com/Isaiahat/git-learning/assets/148476503/d30a0301-639c-4b55-940c-086266a6eb81)

![2b  Create volume](https://github.com/Isaiahat/git-learning/assets/148476503/b61b7440-d914-4165-8ba4-2a4f0ac995e0)


2. Attach all three volumes one by one to your Web Server EC2 instance and Open up the Linux terminal to begin configuration
<br>

![3  attach volume](https://github.com/Isaiahat/git-learning/assets/148476503/98e952d2-5c70-44e2-b6e0-a10a3401a244)


3. Use `lsblk` command to inspect what block devices are attached to the server. Notice names of your newly
created devices. <br> All devices in Linux reside in `/dev/` directory. <br> Inspect it with `ls /dev/` and make sure you see all 3
newly created block devices there - their names will likely be nvme1n1, nvme2n1, nvme3n1.

![4  See available vols - lsblk](https://github.com/Isaiahat/git-learning/assets/148476503/07c6d8e8-9eda-4952-bfa4-8f2ec054623c)

4. Use `df -h` command to see all mounts and free space on your server

![4a  df -h see disk space](https://github.com/Isaiahat/git-learning/assets/148476503/74215f6a-32cf-4cf8-a6f0-799d3e49f927)

5. Install lvm2 package using `sudo yum install lvm2`. <br>
Run `sudo lvmdiskscan` command to check for available
partitions.
Note: Previously, in Ubuntu we used `apt` command to install packages, in RedHat/CentOS a different package manager
is used, so we shall use `yum` command instead.

![5  Install Lvm2](https://github.com/Isaiahat/git-learning/assets/148476503/73f68c99-278b-4d2d-8a8d-eb7787e29a04)


6. Use `pvcreate` utility to mark each of 3 disks as physical volumes (PVs) to be used by LVM
```bash
sudo pvcreate /dev/nvme1n1
sudo pvcreate /dev/nvme2n1
sudo pvcreate /dev/nvme3n1
```

![6  Mark physical volumes pvs](https://github.com/Isaiahat/git-learning/assets/148476503/0f0b20ac-7c1c-4c96-a0e2-801fbbc207d1)

7. Verify that your Physical volume has been created successfully by running `sudo pvs`
8. Use `vgcreate` utility to add all 3 PVs to a volume group (VG). Name the VG "webdata-vg" by running: <br>
`sudo vgcreate webdata-vg /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1`

![7  Add Pvs to volume group vg](https://github.com/Isaiahat/git-learning/assets/148476503/7b07af8c-3d36-4465-bc55-df52b791087e)


9. Verify that your VG has been created successfully by running `sudo vgs`

10. Use `lvcreate` utility to create 2 logical volumes. "apps-lv" (Use half of the PV size), and "logs-lv" Use the remaining space of the PV size. NOTE: apps-lv will be used to store data for the Website while, logs-lv will be used to store data for logs.
``` bash
sudo lvcreate -n apps-lv -L 14G webdata-vg
sudo lvcreate -n logs-lv -L 14G webdata-vg
```
11. Verify that your Logical Volume has been created successfully by running `sudo lvs`

12. Verify the entire setup <br>
``` bash
sudo vgdisplay -v #view complete setup - VG, PV, and LV
sudo lsblk
```
![9a  View setup](https://github.com/Isaiahat/git-learning/assets/148476503/efc0e766-7aae-413c-969a-3e3439ad9502)

![9b  View setup](https://github.com/Isaiahat/git-learning/assets/148476503/ec2bfa51-e4c4-468f-927a-a6297c974a93)

13. Use `mkfs.ext4` to format the logical volumes with ext4 filesystem
``` bash
sudo mkfs -t ext4 /dev/webdata-vg/apps-lv
sudo mkfs -t ext4 /dev/webdata-vg/logs-lv
```
![14  Format Logical volume with ext4 filesystem](https://github.com/Isaiahat/git-learning/assets/148476503/b49590c3-9464-4ebd-8858-44073086145b)

14. Create /var/www/html directory to store website files: <br>
`sudo mkdir -p /var/www/html`
15. Create /home/recovery/logs to store backup of log data: <br>
`sudo mkdir -p /home/recovery/logs`
16. Mount /var/www/html on apps-lv logical volume: <br>
`sudo mount /dev/webdata-vg/apps-lv /var/www/html/`

![15-18  create html   log folders and mount them on respective logical volumes](https://github.com/Isaiahat/git-learning/assets/148476503/87784897-940e-45f4-b5d0-4d03fba83b03)

17. Use `rsync` utility to backup all the files in the log directory /var/log into /home/recovery/logs (Thisisrequired
before mounting the file system): <br>
`sudo rsync -av /var/log/. /home/recovery/logs/`
18. Mount /var/log on logs-lv logical volume. (Note that all the existing data on /var/log will be deleted. That is why step 14
above is very important): <br>
`sudo mount /dev/webdata-vg/logs-lv /var/log`
19. Restore log files back into /var/log directory:<br>
`sudo rsync -av /home/recovery/logs/ /var/log`

![20  restore log files back into _var_log dir](https://github.com/Isaiahat/git-learning/assets/148476503/ff354119-16b2-4912-af98-8e66070b6c9a)

20. Update `/etc/fstab` file so that the mount configuration will persist after restart of the server. <br>
The UUID of the device will be used to update the /etc/fstab file;<br>
`sudo blkid` <br> `sudo vi /etc/fstab` <br>
Update /etc/fstab in this format using your own UUID and rememeber to remove the leading and ending quotes.

![21  Obtain device UUID - to update the etc_fstab](https://github.com/Isaiahat/git-learning/assets/148476503/1cfb5fb4-a95d-4b07-acf6-0bfad9911c4a)

![21b  edit _etc_fstab](https://github.com/Isaiahat/git-learning/assets/148476503/22b280dd-4fd3-4b5f-a127-34634b806e18)

21. Test the configuration and reload the daemon
``` bash
sudo mount -a
sudo systemctl daemon-reload
```
22. Verify your setup by running `df -h`, output must look like this:

![23  verify setup](https://github.com/Isaiahat/git-learning/assets/148476503/1ff44dbb-0dcb-4a36-8c75-ae0c22761dbd)

## Installing wordpress and configuring to use MySQL Database
### Step 2 — Prepare the Database Server

1. Launch a second RedHat EC2 instance that will have a role - 'DB Server'.

![24  2nd redhat ec2 instance for database server](https://github.com/Isaiahat/git-learning/assets/148476503/37eb2259-bfc7-4edf-9829-e33dd2310bdd)

2. Repeat the same steps as for the Web Server, but instead of **apps-lv**, create **db-lv** and mount it to `/var/db` directory instead of `/var/www/html/`.

![25a  Obtain device UUID - to update the etc_fstab](https://github.com/Isaiahat/git-learning/assets/148476503/1a60c89e-35a4-4c9a-86ff-e79bd44a22a9)

![25b  etc_fstab edit for database](https://github.com/Isaiahat/git-learning/assets/148476503/3ae74264-a0dd-4f72-887f-56bc457993eb)

![26  verify setup for db server](https://github.com/Isaiahat/git-learning/assets/148476503/07cf0ecc-e6aa-47c9-9c70-841b4e5183f8)

### Step 3 — Install Wordpress on your Web Server EC2

1. Update the repository <br>
`sudo yum -y update`
2. Install wget, Apache and it's dependencies <br>
`sudo yum -y install wget httpd php php-mysqlnd php-fpm php-json`

![27  Install apache, php and other dependencies on WP server](https://github.com/Isaiahat/git-learning/assets/148476503/6e150f79-7bd7-4d64-9055-df3d59b7a079)

3. Start Apache <br>
``` bash
sudo systemctl enable httpd
sudo systemctl start httpd
```
4. Install PHP and it's depemdencies
``` bash
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install yum-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo yum module list php
sudo yum module reset php
sudo yum module enable php:remi-7.4
sudo yum install php php-opcache php-gd php-curl php-mysqlnd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
setsebool -P httpd_execmem 1
```

5. Restart Apache <br>
`sudo systemctl restart httpd`
6. Download wordpress and copy wordpress to var/www/html
``` bash
mkdir wordpress
cd wordpress
sudo wget http://wordpress.org/latest.tar.gz
sudo tar xzvf latest.tar.gz
sudo rm -rf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php
cp -R wordpress /var/www/html/
```
![28a  step 6](https://github.com/Isaiahat/git-learning/assets/148476503/da96d59a-595b-47d8-9763-0477dc42032f)

![28b  step 6](https://github.com/Isaiahat/git-learning/assets/148476503/041d9d06-643f-44a7-bc92-139de3d4b6dc)

7. Configure SELinux Policies <br>
``` bash 
sudo chown -R apache:apache /var/www/html/wordpress
sudo chcon -t httpd_sys_rw_content_t /var/www/html/wordpress -R
sudo setsebool -P httpd_can_network_connect=1
```
![29  configure SELinux policies](https://github.com/Isaiahat/git-learning/assets/148476503/b726b3c1-98ae-43ac-8801-1fac82354ce9)

### Step 4 — Install MySQL on your DB Server EC2

1. Update the machine and install Mysql <br> 
``` bash 
sudo yum update
sudo yum install mysql-server
```

2. Verify that the service is up and running by using `sudo systemctl status mysqld`, if it is not running, restart the service
and enable it so it will be running even after reboot:
``` bash 
sudo systemctl restart mysqld
sudo systemctl enable mysqld
```

### Step 5 — Configure DB to work with WordPress
1. login into MySQL `sudo mysql`
2. Input the following MySQL commands:
``` bash
CREATE DATABASE wordpress;
CREATE USER `myuser`@`<Web-Server-Private-IP-Address>` IDENTIFIED BY 'mypass';
GRANT ALL ON wordpress.* TO 'myuser'@'<Web-Server-Private-IP-Address>';
FLUSH PRIVILEGES;
SHOW DATABASES;
exit
```
![30  configuring MySQL on DBserver](https://github.com/Isaiahat/git-learning/assets/148476503/bdf9627f-d5b7-4c2d-8df5-59d6a53c1db2)

### Step 6 — Configure WordPress to connect to remote database.

> Note: Do not forget to open MySQL port 3306 on DB Server EC2. For extra security, you shall allow access to the DB
server ONLY from your Web Server's IP address, so in the Inbound Rule configuration specify source as `ip.address/32`

![31  Inbound rules for port 3306](https://github.com/Isaiahat/git-learning/assets/148476503/1bffc3ec-e823-47fd-a9a5-9c064783c4c1)

1. Install MySQL client and test that you can connect from your Web Server to your DB server by using mysqlclient <db>
``` bash 
sudo yum install mysql
sudo mysql -u user -p -h <DB.Server.Private.IP-address>
```
![32  Install mysql for wordpress server](https://github.com/Isaiahat/git-learning/assets/148476503/2777584c-5ff1-4908-b355-d9b68b110700)

2. Verify if you can successfully execute `SHOW DATABASES;` command and see a list of existing databases.

![33  connect to remote database](https://github.com/Isaiahat/git-learning/assets/148476503/c304ebf7-096e-421e-8bf3-5c64c6114167)

3. Change permissions and configuration so Apache could use WordPress: <br>`sudo vi /var/www/html/wordpress/wp-config.php` <br>
![34a  edit php file inisde wordpress folder](https://github.com/Isaiahat/git-learning/assets/148476503/c4ecb1a6-c3b5-4d91-9818-d12a13148448)

![34b  edit php file inisde wordpress folder](https://github.com/Isaiahat/git-learning/assets/148476503/8e57a406-5a1a-4eb7-96aa-ed8e5b166285)

4. Enable TCP port 80 in Inbound Rules configuration for your Web Server EC2 (enable from everywhere 0.0.0.0/0 or
from your workstation's IP)
5. Try to access from your browser the link to your WordPress http://<Web.Server.Public.IPAddress>/wordpress/

![40  wordpress 1](https://github.com/Isaiahat/git-learning/assets/148476503/99c53466-a30d-4215-bd31-b197eb399dd7)

6. Fill out your DB credentials:

![40  wordpress 2](https://github.com/Isaiahat/git-learning/assets/148476503/02a7328a-2058-42c8-aa1c-0cc8c89efe0d)

If you see this message - it means your WordPress has successfully connected to your remote MySQL database

![40  wordpress 3](https://github.com/Isaiahat/git-learning/assets/148476503/dd85d4ea-0a35-43c6-9bcd-a794f0be21bc)

You have learned how to configure Linux storage susbystem and have also deployed a full-scale Web Solution using
WordPress CMS and MySQL RDBMS!
