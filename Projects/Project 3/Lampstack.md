
# Lamp Stack Implemetation

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

#### Step 3 — Installing PHP
PHP is the component of our setup that will process code to display dynamic content. It can run scripts, connect to our MySQL databases to get information, and hand the processed content over to our web server to display.

We can once again leverage the apt system to install our components. We’re going to include some helper packages as well, so that PHP code can run under the Apache server and talk to our MySQL database:

sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
This should install PHP without any problems. We’ll test this in a moment.

In most cases, we’ll want to modify the way that Apache serves files when a directory is requested. Currently, if a user requests a directory from the server, Apache will first look for a file called index.html. We want to tell our web server to prefer PHP files, so we’ll make Apache look for an index.php file first.

To do this, type this command to open the dir.conf file in a text editor with root privileges:

sudo nano /etc/apache2/mods-enabled/dir.conf
It will look like this:

/etc/apache2/mods-enabled/dir.conf
<IfModule mod_dir.c>
    DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
</IfModule>
We want to move the PHP index file highlighted above to the first position after the DirectoryIndex specification, like this:

/etc/apache2/mods-enabled/dir.conf
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
When you are finished, save and close the file by pressing Ctrl-X. You’ll have to confirm the save by typing Y and then hit Enter to confirm the file save location.

After this, we need to restart the Apache web server in order for our changes to be recognized. You can do this by typing this:

sudo systemctl restart apache2
We can also check on the status of the apache2 service using systemctl:

sudo systemctl status apache2
Sample Output
● apache2.service - LSB: Apache2 web server
   Loaded: loaded (/etc/init.d/apache2; bad; vendor preset: enabled)
  Drop-In: /lib/systemd/system/apache2.service.d
           └─apache2-systemd.conf
   Active: active (running) since Wed 2016-04-13 14:28:43 EDT; 45s ago
     Docs: man:systemd-sysv-generator(8)
  Process: 13581 ExecStop=/etc/init.d/apache2 stop (code=exited, status=0/SUCCESS)
  Process: 13605 ExecStart=/etc/init.d/apache2 start (code=exited, status=0/SUCCESS)
    Tasks: 6 (limit: 512)
   CGroup: /system.slice/apache2.service
           ├─13623 /usr/sbin/apache2 -k start
           ├─13626 /usr/sbin/apache2 -k start
           ├─13627 /usr/sbin/apache2 -k start
           ├─13628 /usr/sbin/apache2 -k start
           ├─13629 /usr/sbin/apache2 -k start
           └─13630 /usr/sbin/apache2 -k start

Apr 13 14:28:42 ubuntu-16-lamp systemd[1]: Stopped LSB: Apache2 web server.
Apr 13 14:28:42 ubuntu-16-lamp systemd[1]: Starting LSB: Apache2 web server...
Apr 13 14:28:42 ubuntu-16-lamp apache2[13605]:  * Starting Apache httpd web server apache2
Apr 13 14:28:42 ubuntu-16-lamp apache2[13605]: AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerNam
Apr 13 14:28:43 ubuntu-16-lamp apache2[13605]:  *
Apr 13 14:28:43 ubuntu-16-lamp systemd[1]: Started LSB: Apache2 web server.
Install PHP Modules
To enhance the functionality of PHP, we can optionally install some additional modules.

To see the available options for PHP modules and libraries, you can pipe the results of apt-cache search into less, a pager which lets you scroll through the output of other commands:

apt-cache search php- | less
Use the arrow keys to scroll up and down, and q to quit.

The results are all optional components that you can install. It will give you a short description for each:

libnet-libidn-perl - Perl bindings for GNU Libidn
php-all-dev - package depending on all supported PHP development packages
php-cgi - server-side, HTML-embedded scripting language (CGI binary) (default)
php-cli - command-line interpreter for the PHP scripting language (default)
php-common - Common files for PHP packages
php-curl - CURL module for PHP [default]
php-dev - Files for PHP module development (default)
php-gd - GD module for PHP [default]
php-gmp - GMP module for PHP [default]
…
:
To get more information about what each module does, you can either search the internet, or you can look at the long description of the package by typing:

apt-cache show package_name
There will be a lot of output, with one field called Description-en which will have a longer explanation of the functionality that the module provides.

For example, to find out what the php-cli module does, we could type this:

apt-cache show php-cli
Along with a large amount of other information, you’ll find something that looks like this:

Output
…
Description-en: command-line interpreter for the PHP scripting language (default)
 This package provides the /usr/bin/php command interpreter, useful for
 testing PHP scripts from a shell or performing general shell scripting tasks.
 .
 PHP (recursive acronym for PHP: Hypertext Preprocessor) is a widely-used
 open source general-purpose scripting language that is especially suited
 for web development and can be embedded into HTML.
 .
 This package is a dependency package, which depends on Debian's default
 PHP version (currently 7.0).
…
If, after researching, you decide you would like to install a package, you can do so by using the apt-get install command like we have been doing for our other software.

If we decided that php-cli is something that we need, we could type:

sudo apt-get install php-cli
If you want to install more than one module, you can do that by listing each one, separated by a space, following the apt-get install command, like this:

sudo apt-get install package1 package2 ...
At this point, your LAMP stack is installed and configured. We should still test out our PHP though.
