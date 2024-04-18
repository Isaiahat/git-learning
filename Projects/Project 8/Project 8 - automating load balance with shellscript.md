# **Automating Loadbalancer configuration with Shell scripting**
## **Introduction:**

This is an exercise on how to Streamline a load balancer configuration with ease; using shell scripting and simple CI/CD on Jenkins. 
This project demonstrates how to automate the setup and maintenance of your load balancer using a freestyle job, enhancing efficiency and reducing manual effort

In the previous Nginx exercise, We deployed two backend servers, with a load balancer distributing
traffic across the webservers. We did that by typing commands right on our terminal.

In this course however, we will be automating the entire process. We will do that by writing a shell script such that when ran, all that we
did manually will be done automatically. 

As DevOps Engineers automation is at the heart of the work we do.
Automation helps us speed the the deployment of services and reduce the chance of making errors in our day to day
activity. As such, this course will give a great introduction to automation.


## **Deploying and Configuring the Webservers**
All the process we need to deploy our webservers has been codified in the shell script below:
``` bash
#!/bin/bash
###########################################################################################################
##### This automates the installation and configuring of apache webserver to listen on port 8000
##### Usage: Call the script and pass in the Public_IP of your EC2 instance as the first argument as shown
Copy Below Code
1
4/18/24, 5:02 AM Learning Path - Project - Darey.io
https://app.dareyio.com/learning/project 2/8
######## ./install_configure_apache.sh 127.0.0.1
###########################################################################################################
set -x # debug mode
set -e # exit the script if there is an error
set -o pipefail # exit the script when there is a pipe failure
PUBLIC_IP=$1
[ -z "${PUBLIC_IP}" ] && echo "Please pass the public IP of your EC2 instance as an argument to the script"
sudo apt update -y && sudo apt install apache2 -y
sudo systemctl status apache2
if [[ $? -eq 0 ]]; then
sudo chmod 777 /etc/apache2/ports.conf
echo "Listen 8000" >> /etc/apache2/ports.conf
sudo chmod 777 -R /etc/apache2/
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8000>/' /etc/apache2/sites-available/000-default.conf
fi
sudo chmod 777 -R /var/www/
echo "<!DOCTYPE html>
<html>
<head>
<title>My EC2 Instance</title>
</head>
<body>
<h1>Welcome to my EC2 instance</h1>
<p>Public IP: "${PUBLIC_IP}"</p>
</body>
</html>" > /var/www/html/index.html
sudo systemctl restart apache2
```

Follow the steps below to run the script: <br>

> Step 1: Provision an EC2 instance running ubuntu 20.04. You can refer to the course **Implementing load balancer with
Nginx** for a refresher <br> ![1  ec2 instance ubuntu 20 04](https://github.com/Isaiahat/git-learning/assets/148476503/4b249ad1-8a94-48c5-899a-be8c71e3c921)


> Step 2: Open port 8000 to allow traffic from anyhere using the security group. Again refer to the course mentioned above
in step one for a refresher. <br> ![2  port 8000 provisioning](https://github.com/Isaiahat/git-learning/assets/148476503/e5233f34-0d5f-47a0-bc64-acb0fc38e773)


> Step 3: Connect to the webserver via the terminal using SSH cleint. <br> ![3  connect to ec2 via ssh client](https://github.com/Isaiahat/git-learning/assets/148476503/9c0ec771-0601-4f75-b0ff-e498646ba36e)


> Step 4: Open a file, paste the script above and close the file using the command below: <br>
`sudo vi install.sh` <br>
To close the file type the **esc** key then **Shift** + :wqa! <br> ![4  creating install script](https://github.com/Isaiahat/git-learning/assets/148476503/8f3810fc-5e1d-4864-833a-7148f6da8520)


> Step 5: Change the permissions on the file to make an executable using the command below: <br>
`sudo chmod +x install.sh`

> Step 6: Run the shell script using the command below. Make sure you read the instructions in the shell script to learn how to use it.
`./install.sh PUBLIC_IP` <br> ![5  chmod +x and run](https://github.com/Isaiahat/git-learning/assets/148476503/01c12849-8ec8-4859-8eb5-53602cc8823e) <br>
> 
> ![6  install sh run complete](https://github.com/Isaiahat/git-learning/assets/148476503/3ed7b814-4f79-47ca-a06c-542ace90f3eb) 


## **Deployment and configuration of Nginx as a Load Balancer using Shell script**
### Automate the Deployment of Nginx as a Load Balancer using Shell script
Having successfully deployed and configured two webservers, We will move on to the laod balancer. As a prerequisite, we
need to provision an EC2 instance running ubuntu 22.04, open port 80 to anywhere using the security group and connect
to the load balancer via the terminal. <br>
![7  ec2 instance ubuntu 22 04](https://github.com/Isaiahat/git-learning/assets/148476503/aab5da9a-19ca-44f6-965b-20a408c84862) <br>

![8  port 80 provisioning](https://github.com/Isaiahat/git-learning/assets/148476503/9e0d8191-c707-4238-b54b-004ed942d4c5)


### Deploying and Configuring Nginx Load Balancer
All the steps followed in the Implementing Load Balancer with Nginx course has been codified in the script below:
Read the instrictions carefully in the script to learn how to use the script.

```bash
#!/bin/bash
########################################################################################################
##### This automates the configuration of Nginx to act as a load balancer
##### Usage: The script is called with 3 command line arguments. The public IP of the EC2 instance where
##### the webserver urls for which the load balancer distributes traffic. An example of how to call the
##### ./configure_nginx_loadbalancer.sh PUBLIC_IP Webserver-1 Webserver-2
##### ./configure_nginx_loadbalancer.sh 127.0.0.1 192.2.4.6:8000 192.32.5.8:8000
########################################################################################################
PUBLIC_IP=$1
firstWebserver=$2
secondWebserver=$3
[ -z "${PUBLIC_IP}" ] && echo "Please pass the Public IP of your EC2 instance as the argument to the scr
[ -z "${firstWebserver}" ] && echo "Please pass the Public IP together with its port number in this form
[ -z "${secondWebserver}" ] && echo "Please pass the Public IP together with its port number in this for
set -x # debug mode
set -e # exit the script if there is an error
set -o pipefail # exit the script when there is a pipe failure
sudo apt update -y && sudo apt install nginx -y
sudo systemctl status nginx
if [[ $? -eq 0 ]]; then
sudo touch /etc/nginx/conf.d/loadbalancer.conf
sudo chmod 777 /etc/nginx/conf.d/loadbalancer.conf
sudo chmod 777 -R /etc/nginx/
echo " upstream backend_servers {
# your are to replace the public IP and Port to that of your webservers
server "${firstWebserver}"; # public IP and port for webserser 1
server "${secondWebserver}"; # public IP and port for webserver 2
}
server {
listen 80;
server_name "${PUBLIC_IP}";
location / {
proxy_pass http://backend_servers;
}
} " > /etc/nginx/conf.d/loadbalancer.conf
fi
sudo nginx -t
sudo systemctl restart nginx
```


### Steps to Run the Shell Script.

> Step 1: On your terminal, open a file nginx.sh using the command below: <br>
`sudo vi nginx.sh` 


> Step 2: Copy and Paste the script inside the file. <br>
![9 creating loadbalancer script](https://github.com/Isaiahat/git-learning/assets/148476503/ac328436-b8b4-439f-92a6-871d2fff1289)

> Step 3: Close the file using the command below: <br>
type **esc** then **shift** + **:wqa!**

> Step 4: Change the file permission to make it an executable file `using the command below:
`sudo chmod +x nginx.sh`

> Step 5: Run the script with the command below: <br>
`./nginx.sh PUBLIC_IP Webserver-1 Webserver-2`
> <br>
![10  chmod +x and run](https://github.com/Isaiahat/git-learning/assets/148476503/6b007199-c001-4061-93c9-c5c3aa475a0a) <br>

![11  nginx script run complete](https://github.com/Isaiahat/git-learning/assets/148476503/2ba732bc-7805-4a70-a26f-dd5e15a8b31a)




### Verifying the setup

1. #### Screenshot for webserver 1
  ![14  webserver 1](https://github.com/Isaiahat/git-learning/assets/148476503/45d2900e-8d85-4206-841f-21dca76c7eec) 


2. #### Screenshot for webserver 2
![15  webserver 2](https://github.com/Isaiahat/git-learning/assets/148476503/eb01e3ca-fcf7-4946-95af-7e60b6f357c2)


3. #### Screenshot of load balancer web results
![13  web result 2](https://github.com/Isaiahat/git-learning/assets/148476503/18665e95-12f4-4d08-b864-816dd7ebf898) <br>


![12  web result 1](https://github.com/Isaiahat/git-learning/assets/148476503/58669776-7771-4b6b-8efa-86c9cab83fa2)


#### Automation achieved!
