# **Understanding Client server architecture with MySQL as RDBMS - Overview**
 - Introduction
 - Client-server architecture with MySQL
 - Implement a Client Server Architecture using MySQL
Database Management System (DBMS).

# Introduction

This activity will explore some intricacies of client-server architecture using MySQL as the RDBMS; featuring a
comprehensive understanding of data management, connectivity, and communication between clients and servers
through insightful explanations and practical examples.
<br>

Client-Server refers to an architecture in which two or more computers are connected together over a network to send
and receive requests between one another.
In their communication, each machine has its own role: the machine sending requests is usually referred to as "Client" and
the machine responding (serving) is called "Server".
A simple diagram of Web Client-Server architecture is presented below: <br>
![alt text](<Images/1. client server architecture.png>)


In the depiction above, a machine that is trying to access a Web site using Web browser or a simply `curl` command is a client
and it sends HTTP requests to a Web server (Apache, Nginx, IIS or any other) over the Internet.

# Client-Server architecture with MySQL

If we extend this concept further and add a Database Server to our architecture, we can get this picture: <br>
![alt text](<Images/2. client server with DBS.png>)

In this case, our Web Server has a role of a "Client" that connects and reads/writes to/from a Database (DB) Server
(MySQL, MongoDB, Oracle, SQL Server or any other), and the communication between them happens over a Local
Network (it can also be Internet connection, but it is a common practice to place Web Server and DB Server close to each
other in local network).

The setup on the diagram above is a typical generic Web Stack architecture that we have already implemented in previous
projects (LAMP & LEMP), this architecture can be implemented with many other technologies - various Web
and DB servers, from small Single-page applications SPA to large and complex portals.

Take for example, a commercially deployed LAMP website -
[www.propitixhomes.com](http://www.propitixhomes.com). This LAMP website server(s) can be located anywhere in the world and you can reach it also from any part of the globe over global network - Internet.
Assuming that you go on your browser, and typed in there www.propitixhomes.com. It means that your browser is
considered the "Client". Essentially, it is sending request to the remote server, and in turn, would be expecting some kind of response from the remote server.

Lets take a very quick example and see Client-Server communicatation in action.
Open up your Ubuntu or Windows terminal and run `curl` command:
> `curl -Iv www.propitixhomes.com`
Note: If your Ubuntu does not have 'curl', you can install it by running `sudo apt install curl` <br>
<br> In this example, your terminal will be the client, while [www.propitixhomes.com](http://www.propitixhomes.com) will be the server.
See the response from the remote server in below output. You can also see that the requests from the URL are being
served by a computer with an IP address `104.18.144.154` on port 80 . More on IP addresses and ports when we get to
Networking related projects. <br>
![alt text](<Images/3. curl (webserver).png>) 

Another simple way to get a server's IP address is to use a simple diagnostic tool like 'ping', it will also show round-trip time
- time for packets to go to and back from the server, this tool uses ICMP protocol.

# Implement a Client Server Architecture using MySQL Database Management System (DBMS).

### TASK - Implement a Client Server Architecture using MySQL Database Management System (DBMS).

To demonstrate a basic client-server using MySQL RDBMS, follow the below instructions:
1. Create and configure two Linux-based virtual servers (EC2 instances in AWS).
    >Server A name - `mysql server` <br>
Server B name - `mysql client`

2. On mysql server Linux Server install MySQL Server software. <br>
```
Interesting fact: MySQL is an open-source relational database management system. Its name is a combination of "My",
the name of co-founder Michael Widenius daughter, and "SQL", the abbreviation for Structured Query Language.
```

3. On mysql client Linux Server install `MySQL Client software`.

4. By default, both of your EC2 virtual servers are located in the same local virtual network, so they can communicate
to each other using local IP addresses. <br> 
Use mysql server's local IP address to connect from mysql client.
MySQL server uses TCP port ```3306``` by default, so you will have to open it by creating a new entry in **'Inbound rules'**
in 'mysql server' Security Groups. <br>
For extra security, do not allow all IP addresses to reach your 'mysql server' -
allow access only to the specific local IP address of your 'mysql client'.
<br>
![ ](<Images/4. Security inbound settings.png>) 

5. You might need to configure MySQL server to allow connections from remote hosts. <br>
    > `sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf` <br>
Replace '`127.0.0.1`' to '`0.0.0.0`' like this:
<br>
![ ](<Images/5. MySQL Server conf file.png>)
<br>
6. From mysql client Linux Server connect remotely to mysql server Database Engine without using SSH . You
must use the mysql utility to perform this action.

7. Check that you have successfully connected to a remote by running `mysql -u (username) -p -h (local host/private ip)`, this will access the MySQL server and can perform SQL queries remotely:
`Show databases;`<br>

If you see an output similar to the below image, then you have successfully completed this project - you have deloyed a
fully functional MySQL Client-Server set up. Well Done! 
<br>

![alt text](<Images/6. Remote connection established.png>)