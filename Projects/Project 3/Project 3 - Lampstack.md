# LAMP stack Implementation - Project Overview:
> - **Introduction**
> - **What is a Technology Stack?**
> - **Preparing prerequisites for this project**
> - **Step 1 - Installing Apache and updating firewall**
> - **step 2 - Installing MySql**
> - **Step 3 - Installing PHP**
> - **Step 4 - Testing PHP processes on web server**
> - **Conclusion**


## Introduction

The Project (LAMP Stack) is a comprehensive program designed for individuals seeking to build and deploy web
applications using the LAMP stack. This course project offers a guide through the process of creating dynamic websites by combining Linux, Apache, MySQL, and PHP. 

Throughout the project implementation, participants will gain a solid understanding of the LAMP stack components and their roles in web
application development. Starting with an introduction to the LAMP stack architecture, learners will explore the benefits
and advantages of using this powerful combination of technologies.
The course/project covers essential topics such as configuring the Apache web server, managing MySQL databases, and writing PHP code for server-side functionality. 

Moreover, we will showcase how to install and configure the necessary software components, ensuring a smooth and optimized development environment; gaining proficiency in building
dynamic web applications - including how to handle user requests, interact with databases, process forms, and
implement security measures. 


## What is a Technology Stack?

A DevOps engineer's commonly works around software, websites, applications etc. And, there are different stack of technologies that make different solutions
possible. These stack of technologies are regarded as WEB STACKS. Examples of Web Stacks include LAMP, LEMP,
MEAN, and MERN stacks. 

What then is a Technology stack?

A technology stack is a set of frameworks and tools used to develop a software product. This set of frameworks and tools
are very specifically chosen to work together in creating a well-functioning software. They are acronymns for individual
technologies used together for a specific technology product. some examples are:

* LAMP (Linux, Apache, MySQL, PHP or Python, or Perl) 
* LEMP (Linux, Nginx, MySQL, PHP or Python, or Perl)
* MERN (MongoDB, ExpressJS, ReactJS, NodeJS)
* MEAN (MongoDB, ExpressJS, AngularJS, NodeJS





## Preparing prerequisites for this project.
Preparing prerequisites.

> In order to complete this project we  need an AWS account and a virtual server with Ubuntu Server OS.
AWS is the biggest Cloud Service Provider and it offers a free tier account that we must leverage for our projects.

Thankfully, we have a pre-configured ubuntu linux machine setup already.

## Step 1 - Installing Apache and Updating the Firewall
The Apache web server is among the most popular web servers in the world. It’s well-documented, and has been in wide use for much of the history of the web, which makes it a great default choice for hosting a website.

We can install Apache easily using Ubuntu’s package manager, apt. A package manager allows us to install most software pain-free from a repository maintained by Ubuntu.
We can get started by typing these commands:<br>
`sudo apt-get update`<BR>
`sudo apt-get install apache2`<br>
Since we are using a sudo command, these operations get executed with root privileges. It will ask you for your regular user’s password to verify your intentions.

Once you’ve entered your password, apt will tell you which packages it plans to install and how much extra disk space they’ll take up. Press y and hit ENTER to continue, and the installation will proceed.
> ![Alt text](<Images/step 1a - sudo aptget upgrade.png>) <br>
> ![Alt text](<Images/step 1b - sudo aptget install apache2.png>)

#### Setting Global ServerName to Suppress Syntax Warnings <br>
Next, we will add a single line to the /etc/apache2/apache2.conf file to suppress a warning message. While harmless, if you do not set ServerName globally, you will receive the following warning when checking your Apache configuration for syntax errors:<br>
`sudo apache2ctl configtest`
>**Output**<br>
>AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK

Open up the main configuration file with your text edit:
<br>`sudo nano /etc/apache2/apache2.conf`<br>
Inside, at the bottom of the file, add a ServerName directive, pointing to your primary domain name or public address.

Save and close the file when you are finished.
Next, check for syntax errors by typing:<br>`sudo apache2ctl configtest`<br>
Since we added the global ServerName directive, all we should see is:<br> ![Alt text](<Images/step 1D - firewall.png>)

Restart Apache to implement your changes:<br>
`sudo systemctl restart apache2`
You can now begin adjusting the firewall.

#### Adjusting the Firewall to Allow Web Traffic
Next we run the following and check that it allows port 80 and 443 <br>
`sudo ufw app info "Apache Full"` <br>
>**Output**
Profile: Apache Full<br>
Title: Web Server (HTTP,HTTPS)<br>
Description: Apache v2 is the next generation of the omnipresent Apache web
server.<br>
Ports:
  80,443/tcp<br>
Allow incoming traffic for this profile:

Then run:<br>
`sudo ufw allow in "Apache Full"`<br>
You can do a spot check right away to verify that everything went as planned by visiting your server’s public IP address in your web browser 

http://your_server_IP_address
You will see the default Ubuntu 16.04 Apache web page, which is there for informational and testing purposes. It should look something like the below: <br>
![Alt text](<Images/step 1e.png>)

This page indicates that the web server is now correctly installed and accessible through our firewall.



## Step 2 — Installing MySQL
Now that you have a web server up and running, you need to install a Database Management System (DBMS) to be able to
store and manage data for your site in a relational database. MySQL is a popular relational database management system
used within PHP environments, so we will use it in this project. 
Again, we use 'apt' to acquire and install this software:
`sudo apt install mysql-server` 
When prompted, confirm installation by typing Y , and then ENTER.
When the installation is finished, log in to the MySQL console by typing:<br>
`sudo mysql` <br>
> ![](<Images/Step 2a - install my sql.png>) <br>

During the installation, your server will ask you to select and confirm a password for the MySQL “root” user. This is an administrative account in MySQL that has increased privileges. Think of it as being similar to the root account for the server itself (the one you are configuring now is a MySQL-specific account, however). 

when the installation is complete, we want to run a simple security script that will remove some dangerous defaults and lock down access to our database system a little bit. Start the interactive script by running: <br>
`mysql_secure_installation` <br>
You will be asked to enter the password you set for the MySQL root account. Next, you will be asked if you want to configure the VALIDATE PASSWORD PLUGIN. - input y or yes and follow the rest of the prompts. <br>

At this point, your database system is now set up and we can move on.

## Step 3 — Installing PHP
PHP is the component of our setup that will process code to display dynamic content. It can run scripts, connect to our MySQL databases to get information, and hand the processed content over to our web server to display.

We can once again leverage the apt system to install our components. We’re going to include some helper packages as well, so that PHP code can run under the Apache server and talk to our MySQL database: <br>
`sudo apt-get install php libapache2-mod-php php-mysql`
This should install PHP without any problems as shown below: <br> ![Alt text](<Images/Step 3a - installing php.png>) <br>

In most cases, we’ll want to modify the way that Apache serves files when a directory is requested. Currently, if a user requests a directory from the server, Apache will first look for a file called index.html. We want to tell our web server to prefer PHP files, so we’ll make Apache look for an index.php file first.

To do this, type this command to open the dir.conf file in a text editor with root privileges:<br>
`sudo nano /etc/apache2/mods-enabled/dir.conf`
It will look like this: <br>
> ![Alt text](<Images/step 3b - dir.conf.png>)

We want to move the "PHP index" file to the first position after the "DirectoryIndex" specification, like the below: <br>
> ![Alt text](<Images/step 3b - dir.conf change.png>)


After this, we must save and close the file and then restart the Apache web server in order for our changes to be recognized. You can do this by typing this: <br>
`sudo systemctl restart apache2` <br>
We can also check on the status of the apache2 service using systemctl:<br>
`sudo systemctl status apache2` <br>
Sample Output: <br>
![Alt text](<Images/step 3b - check php status.png>)

At this point, your LAMP stack is installed and configured. We should still test out our PHP though.

## Step 4 — Testing PHP Processing on your Web Server
In order to test that our system is configured properly for PHP, we can create a very basic PHP script.

We will call this script "info.php". In order for Apache to find the file and serve it correctly, it must be saved to a very specific directory, which is called the web root.

In Ubuntu 16.04, this directory is located at /var/www/html/. We can create the file at that location by typing: <br>
`sudo nano /var/www/html/info.php`<br>
This will open a blank file. We want to put the following text, which is valid PHP code, inside the file:<br>
![Alt text](<Images/Step 3c - testing_2.png>)

When you are finished, save and close the file.

Now we can test whether our web server can correctly display content generated by a PHP script. To try this out, we just have to visit this page in our web browser. You’ll need your server’s public IP address again.

The address you want to visit will be:
>http://`your_server_IP_address`/info.php <br>

The page that you come to should look something like this: <br>
![Alt text](<Images/Step 3c - testing_3.png>)


This page basically gives you information about your server from the perspective of PHP. It is useful for debugging and to ensure that your settings are being applied correctly.

This indicates that PHP is working as expected.

Best practice is to remove this file after this test because it could actually give information about your server to unauthorized users. To do this, you can type:<br>
`sudo rm /var/www/html/info.php` <br>
You can always recreate this page if you need to access the information again later.

## Conclusion
Now that you have a LAMP stack installed, you have many choices for what to do next. Basically, you’ve installed a platform that will allow you to install most kinds of websites and web software on your server.

Best practice dictates that as an immediate next step, you should ensure that connections to your web server are secured, by serving them via HTTPS.

