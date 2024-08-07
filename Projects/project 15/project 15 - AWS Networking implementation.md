
# AWS Networking implementation (VPC, Subnets, IG, NAT, Routing)
--- 
## Overview: 

Master the art of AWS networking implementation, including VPC, subnets, internet gateways, NAT, and routing, in this
project, enabling you to design and deploy scalable and secure cloud architectures

### Content:
- #### VPC Creation and Subnet Configuration
- #### Internet Gateway and Routing Table
- #### NAT Gateway and Private Subnets
- #### Security Groups and Network ACLs


## VPC Creation and Subnet Configuration

### AWS VPC Creation and Subnet Configuration

Welcome to AWS networking! This field uses Virtual Private Clouds (VPCs) and subnets to create the backbone of your
cloud-based projects. In this article, we'll simplify the complex aspects of AWS networking, highlighting the useful and
adaptable nature of VPCs and subnets. Whether you're a long-time AWS user or just starting out, this guide will help you understand VPCs and subnets better. So, get ready as we're going to take an interesting trip to discover how to fully use
AWS networking and make the most out of your cloud-based projects.

### What is an Amazon VPC?

An Amazon Virtual Private Cloud (VPC) is like your own private section of the Amazon cloud, where you can place and
manage your resources (like servers or databases). You control who and what can go in and out, just like a gated
community.

The essential steps to creating a VPC and configuring core network services. The topics to be covered are:
- The Default VPC
- Creating a new VPC
- Creating and configuring subnets

#### The Default VPC

The Default VPC is like a starter pack provided by Amazon for your cloud resources. It's a pre-configured space in the
Amazon cloud where you can immediately start deploying your applications or services. It has built-in security and
network settings to help you get up and running quickly, but you can adjust these as you see fit.

![Default vpc](https://github.com/user-attachments/assets/99d99da8-de17-426f-9835-556b1cccdf9e)

A Default VPC, which Amazon provides for you in each region (think of a region as a separate city), is like a pre-built house in that city. This house comes with some default settings to help you move in and start living (or start deploying your
applications) immediately. But just like a real house, you can change these settings according to your needs.

#### Creating a new VPC

As we want to learn step by step and observe the components, choose the `"VPC only` option, we'll use the "VPC and
more" option later. Enter "first-vpc" as the name tag and `"10.0.0.0/16"` as the IPv4 CIDR. The `"10.0.0.0/16"` will be the
primary IPv4 block and you can add a secondary IPv4 block e.g.,`"100.64.0.0/16"`. <br> The use case of secondary CIDR block
could be because you're running out of IPs and need to add additional block, or there's a VPC with overlapping CIDR which
you need to peer or connect. <br>
See this blog post on how a secondary CIDR block is being used in an overlapping IP scenario:
https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-solve-private-ip-exhaustion-with-private-natsolution/ <br>
![1a  Create vpc](https://github.com/user-attachments/assets/f2505585-b5a0-4d6e-8d8c-984b1843e8c2) 
<br>

![1b  Create vpc](https://github.com/user-attachments/assets/af9f0082-6e48-4e06-8239-d289fe0538e0)

Leave the tags as default, you can add more tags if you want and click `CREATE VPC`

As soon as the VPC is created, it's assigned with a vpc-id and there's a route table created that serves as the main route
table - `rtb-034f3b111e7c692bc` in below example.

![1c  vpc created](https://github.com/user-attachments/assets/fc3e14b3-dc3b-40c3-a1e6-733ac14b6a9a)

Now you have a VPC and a route table, but you won't be able to put anything inside. If you try to create an EC2 instance for
example, you can't proceed as it requires subnets.

#### Creating and configuring subnets
**What are Subnets?** <br>
Subnets are like smaller segments within a VPC that help you organize and manage your resources. Subnets are like
dividing an office building into smaller sections, where each section represents a department. In this analogy, subnets are
created to organize and manage the network effectively.

![2a  subnet depiction](https://github.com/user-attachments/assets/0f4a1276-91d9-4697-ab96-0f15d0f3ce14)

**Subnet name AZ CIDR block** <br>
subnet-public1a eu-north-1a 10.0.11.0/24 <br>
subnet-public2b eu-north-1b10.0.12.0/24 <br>
subnet-private1a eu-north-1a 10.0.1.0/24 <br>
subnet-private2b eu-north-1b10.0.2.0/24 <br>

Go to VPC > Subnets > Create Subnets and select the VPC that you've created previously - the test-vpc or anything you
tagged your VPC, click on `CREATE SUBNET`

Enter the subnet settings detail. Don't click the "Create subnet" button just yet, click the `Add new subnet` button to add the remaining subnets then after completing all the required subnets, click "Create subnet" 
> **Note:** if you don't choose a
zone, it will be randomly picked by AWS.

![2b  create subnet](https://github.com/user-attachments/assets/a3914e8d-dbbf-49e2-9c09-b61b508661b9)

Once done, you should see all the subnets you just created on the console. If you missed any, just create a subnet and
select your desired VPC. As of now, you can deploy EC2 instances into the VPC by selecting one of the subnets, but the
public subnet doesn't have any Internet access at this stage. When you select a public subnet > route, you'll see it uses the
main route table and only has the local route, no default route for Internet access.

![2c  subnets created](https://github.com/user-attachments/assets/a5f19d8e-5d40-485b-8077-f651be8f1de4)


#### **Understanding Public and Private Subnets in AWS VPC**

In the world of AWS VPC, think of subnets as individual plots in your land (VPC). Some of these plots (subnets) have direct
road access (internet access) - these are public subnets. Others are more private, tucked away without direct road access - these are private subnets.

#### Creating a Public Subnet

Creating a public subnet is like creating a plot of land with direct road (internet) access. Here's how you do it:

Go to the AWS VPC page. <br>
- Find 'Subnets', click on it, then click 'Create subnet'. <br>
- Give this new plot a name, select the big plot (VPC) you want to divide, and leave the IP settings as they are. <br>
- Attach an Internet Gateway to this subnet to provide the road (internet) access.
- Update the route table associated with this subnet to allow traffic to flow to and from the internet.

#### Creating a Private Subnet

Creating a private subnet is like creating a secluded plot without direct road (internet) access. Here's how you do it: 

Go to the AWS VPC page.
- Find 'Subnets', click on it, then click 'Create subnet'. 
- Give this new plot a name, select the big plot (VPC) you want
to divide, and leave the IP settings as they are.
- Don't attach an Internet Gateway to this subnet, keeping it secluded.
- The route table for this subnet doesn't allow direct traffic to and from the internet.

#### Working with Public and Private Subnets

Public subnets are great for resources that need to connect to the internet, like web servers. Private subnets are great for
resources that you don't want to expose to the internet, like databases.

Understanding public and private subnets helps you to organize and protect your AWS resources better. Always
remember, use public subnets for resources that need internet access and private subnets for resources that you want to
keep private.

## Internet Gateway and Routing Table

### Introduction to Internet Gateway and Routing Table
Just like in a real city, in your virtual city (VPC), you need roads (Internet Gateway) for people (data) to come and go. And
you also need a map or GPS (Routing Table) to tell people (data) which way to go to reach their destination.

#### **What is an Internet Gateway?**
An Internet Gateway in AWS is like a road that connects your city (VPC) to the outside world (the internet). Without this
road, people (data) can't come in or go out of your city (VPC).

To give your public subnet access to the main road (internet), you need an Internet Gateway. This acts like the entrance and
exit to your property. We'll show you how to create and attach an Internet Gateway to your VPC.

#### Public Subnets

Technically, the subnets are still private. You'll need these to make it work as public subnets:
- An Internet Gateway (IGW) attached to the VPC
- Route table with default route towards the IGW
- Public IP assigned to the AWS resources (e.g., EC2 instances)

Go to VPC > Internet gateways > and click "Create internet gateway"

Put a name tag and click create internet gateway

![3a  Create Internet gateway](https://github.com/user-attachments/assets/398d93c4-b9d9-44e3-864a-0f8ead08f71e)

Attach the IGW to the test-vpc

select the VPC

![3b  attach internet gateway to vpc](https://github.com/user-attachments/assets/b301f444-bc09-4977-9dd0-0c212dced125)
<br>
![3c  igw attached](https://github.com/user-attachments/assets/dd853a98-a8f6-4396-8807-0e85c6760f81)


We want the private subnets to be private, we don't want the private subnets to have a default route to the Internet. For
that, we'll need to create a separate route table for the public subnets.

#### What is a Routing Table?

A Routing Table is like a map or GPS. It tells the people (data) in your city (VPC) which way to go to reach their destination.
For example, if the data wants to go to the internet, the Routing Table will tell it to take the road (Internet Gateway) that
you built.
#### Creating and Configuring Routing Tables

Now that we have our entrance and exit (Internet Gateway), we need to give directions to our resources. This is done
through a Routing Table. It's like a map, guiding your resources on how to get in and out of your VPC.

Let's go to the route table menu and create a route table for the public subnets.

Put a name for the route table e.g., test-vpc-public-rtb and select the desired vpc -"test-vpc"

![4a  route table created](https://github.com/user-attachments/assets/eb3cf867-756e-4ff5-b446-5e064a242fbd)

Once created, edit the route table, add a default route to the Internet Gateway (IGW) <br>

after select Internet Gateway:

![4b  default route added to igw](https://github.com/user-attachments/assets/784dac63-1bab-4e82-b375-1c8193919709)
<br>
![4c  default route added to igw](https://github.com/user-attachments/assets/aaec309c-8cce-49f2-9c31-c1278f69d829)

Next, go to the "Subnet associations" tab and click "Edit subnet associations"

Select the public subnets and click "Save associations":

![4d  edit subnet associations](https://github.com/user-attachments/assets/cd52c28d-3b2f-4759-9757-89052f5efe01)

![4e  subnet association edited](https://github.com/user-attachments/assets/6612994b-de25-4d8a-9741-29fcfae1bcb0) 
<br>

That's it! Now that the VPC is ready, you can run an EC2 instance in public subnets if they need Internet access or in
private subnets if they don't.
> **Note:** 
**test-vpc-public-rtb:** A route table with a target to Internet gateway is a public route table.
> 
> **test-vpc-private-rtb:** A route table with a target to NAT gateway is a private route table.
- I will also create the route table for for private but subnets and routes are not yet been attached to it just only
created. <br>
![4f  private route table created](https://github.com/user-attachments/assets/2fd1fe26-a050-41fc-88e0-88336666d6c7)


## NAT Gateway and Private Subnets

### Introduction to Private Subnets and NAT Gateway

In your AWS Virtual Private Cloud (VPC), private subnets are secluded areas where you can place resources that should
not be directly exposed to the internet. But what if these resources need to access the internet for updates or downloads?
This is where the NAT Gateway comes in.

A private subnet in AWS is like a secure room inside your house (VPC) with no windows or doors to the street (internet).
Anything you place in this room (like a database) is not directly accessible from the outside world.

#### Understanding NAT Gateway

A Network Address Translation (NAT) Gateway acts like a secure door that only opens one way. It allows your resources
inside the private subnet to access the internet for things like updates and downloads, but it doesn't allow anything from
the internet to enter your private subnet.

A Network Address Translation (NAT) allows instances in your private subnet to connect to outside services like
Databases but restricts external services to connecting to these instances.

#### Creating a NAT Gateway and Linking It to a Private Subnet

We'll guide you step-by-step on how to create a NAT Gateway and how to link it to your private subnet. We'll also cover
how to configure a route in your routing table to direct outbound internet traffic from your private subnet to the NAT
Gateway.

Go to VPC > NAT Gateways and click "Create NAT Gateway"

Create the NAT Gateway named "test-nat" under one of the private subnets which I choose the subnet-private1a as the
subnet.

You need to allocate Elastic IP because is required for the creation of NAT gateway

![5b  create nat gateway](https://github.com/user-attachments/assets/6d4a4b0b-3ef2-4e85-a2cf-26231d3e544f)

![5a  allocate elastic ip - required](https://github.com/user-attachments/assets/87854768-c910-4da9-b196-fd2b516b963a)


Let's go to the route table menu and create a route table for the private subnets.
we can create a route table now,

Let edit the route table, add a default route to the Network Address Translation (NAT) Gateway

Choose route table RTB-Private, select Routes tab, and select Add Route. Under the Target, select the NAT gateway
named "test-nat"

![5c  edit route table for private subnet](https://github.com/user-attachments/assets/9e2f4f57-6983-4991-a76d-cc978e6cf1c9)

![5d  edited](https://github.com/user-attachments/assets/14165430-8ef5-4b0d-9523-3285139d7138) <br>


Next, go to the "Subnet associations" tab and click "Edit subnet associations"

![5e  edit subnet associations](https://github.com/user-attachments/assets/9d0a8fb9-7456-4730-b547-a5b706118f85)


#### Summary and Best Practices

To conclude, we'll revisit the importance of NAT Gateways in the context of private subnets and summarize the key points
of the course. We'll also share some best practices when working with private subnets and NAT Gateways in AWS.

By the end of this course, you'll have a clear understanding of how private subnets and NAT Gateways work in AWS and
how you can use them to maintain security while allowing necessary internet access for your resources.

## Security Group and Network ACLs

### Understanding the Differences between Security Groups and Network Access Control Lists

Security groups and network access control lists (ACLs) are both important tools for securing your network on the AWS
cloud, but they serve different purposes and have different use cases.

#### Security Groups

![6a  Security group depiction](https://github.com/user-attachments/assets/49643ae5-c84a-430f-9097-c9bc12ad2db6)

Security groups can be compared to a bouncer at a club who controls the flow of traffic to and from your resources in a
cloud computing environment. Imagine you have a club, and you want to ensure that only authorized individuals can enter
and exit. In this analogy, the club represents your cloud resources (such as virtual machines or instances), and the bouncer represents the security group.

Just like a bouncer checks the IDs and credentials of people at the club's entrance, a security group examines the IP
addresses and ports of incoming and outgoing network traffic. 
It acts as a virtual firewall that filters traffic based on
predefined rules. These rules specify which types of traffic are allowed or denied.

For example, a security group can be configured to allow incoming HTTP traffic (on port 80) to a web server, but block all other types of incoming traffic. Similarly, it can permit outgoing traffic from the web server to external databases on a
specific port, while restricting all other outbound connections.

By enforcing these rules, security groups act as a line of defense, helping to protect your resources from unauthorized
access and malicious attacks. They ensure that only the traffic that meets the defined criteria is allowed to reach your
resources, while blocking or rejecting any unauthorized or potentially harmful traffic.

It's important to note that security groups operate at the instance level, meaning they are associated with specific
instances and can control traffic at a granular level. They can be customized and updated as needed to adapt to changing
security requirements.

Overall, security groups provide an essential layer of security for your cloud resources by allowing you to define and
manage access control policies, much like a bouncer regulates who can enter and exit a club.

#### Network Access Control Lists {NACLs}

![6b  Network access Control List depiction](https://github.com/user-attachments/assets/8aa20208-2c17-4463-95b4-e99feb951c13)

Network ACLs (Access Control Lists) can be likened to a security guard for a building, responsible for controlling inbound
and outbound traffic at the subnet level in a cloud computing environment. Imagine you have a building with multiple
rooms and entry points, and you want to ensure that only authorized individuals can enter and exit. In this analogy, the
building represents your subnet, and the security guard represents the network ACL.

Similar to a security guard who verifies IDs and credentials before allowing entry into the building, a network ACL
examines the IP addresses and ports of incoming and outgoing network traffic. It serves as a virtual barrier or perimeter
security, defining rules that dictate which types of traffic are permitted or denied.

For instance, a network ACL can be configured to allow incoming SSH (Secure Shell) traffic (on port 22) to a specific subnet,
while blocking all other types of incoming traffic. It can also permit outgoing traffic from the subnet to a specific range of IP addresses on a certain port, while disallowing any other outbound connections.

By implementing these rules, network ACLs act as a crucial line of defense, safeguarding your entire subnet from
unauthorized access and malicious attacks. They ensure that only traffic meeting the specified criteria is allowed to enter
or exit the subnet, while blocking or rejecting any unauthorized or potentially harmful traffic.

It's important to note that network ACLs operate at the subnet level, meaning they control traffic for all instances within a
subnet. They provide a broader scope of security compared to security groups, which operate at the instance level.
Network ACLs are typically stateless, meaning that inbound and outbound traffic is evaluated separately, and specific rules
must be defined for both directions.

In summary, network ACLs function as a virtual security guard for your subnet, regulating inbound and outbound traffic at
a broader level. They operate similarly to a security guard who controls access to a building by examining IDs, ensuring
that only traffic meeting the defined rules is allowed to pass, and thereby providing protection against unauthorized
access and malicious activities for your entire subnet.

#### In conclusion

![6c  VPC component structure summary depiction](https://github.com/user-attachments/assets/a7140b7c-7777-428b-a403-db33246810cb)

In short, security groups and network ACLs are both important tools for securing your network on the AWS cloud, but
they serve different purposes and have different use cases. Security groups are like a bouncer at a club, controlling
inbound and outbound traffic to and from your resources at the individual resource level. Network ACLs, on the other
hand, are like a security guard for a building, controlling inbound and outbound traffic at the subnet level.

## VPC Peering and VPN Connection

### Introduction to VPC Peering

![7a  VPC peering depiction](https://github.com/user-attachments/assets/1c8f2217-354e-42bd-b337-c5c0cef88d29)

VPC Peering is a networking feature that allows you to connect two Virtual Private Clouds (VPCs) within the same cloud
provider's network or across different regions. VPC Peering enables direct communication between VPCs, allowing
resources in each VPC to interact with each other as if they were on the same network. It provides a secure and private
connection without the need for internet access. VPC Peering is commonly used to establish connectivity between VPCs
in scenarios such as multi-tier applications, resource sharing, or data replication.

#### Benefits of VPC Peering

- **Simplified Network Architecture:** VPC Peering simplifies network design by enabling direct communication
between VPCs, eliminating the need for complex networking configurations.
- **Enhanced Resource Sharing:** With VPC Peering, resources in different VPCs can communicate seamlessly, allowing
for efficient sharing of data, services, and applications.
- **Increased Security:** Communication between peered VPCs remains within the cloud provider's network, ensuring a
secure and private connection.
- **Low Latency and High Bandwidth:** VPC Peering enables high-performance networking with low latency and high
bandwidth, improving application performance.
- **Cost Efficiency:** Utilizing VPC Peering eliminates the need for additional networking components, reducing costs
associated with data transfer and network infrastructure.

#### Introduction to VPN Connections

VPN (Virtual Private Network) connections establish a secure and encrypted communication channel between your onpremises network and a cloud provider's network, such as a VPC. VPN connections enable secure access to resources in
the cloud from remote locations or connect on-premises networks with cloud resources.

There are two primary types of VPN connections:

1. **Site-to-Site VPN:** Site-to-Site VPN establishes a secure connection between your on-premises network and the
cloud provider's network. It allows communication between your on-premises resources and resources in the VPC
securely and privately. This type of VPN connection is commonly used in hybrid cloud architectures.

![7b  site to site VPN depiction](https://github.com/user-attachments/assets/8663e509-0880-4bd2-8afd-d226d487f504)

3. **AWS Client VPN:** AWS Client VPN provides secure remote access to the cloud network for individual users or
devices. It enables secure connectivity for remote employees, partners, or contractors to access resources in the
VPC securely.

![7c  AWS client VPN depiction](https://github.com/user-attachments/assets/82f80eac-23c2-4265-87f6-91aa52bd1b2d)


#### Benefits of VPN Connections

- **Secure Remote Access:** VPN connections enable secure access to resources in the cloud network for remote users
or devices, ensuring data privacy and protection.
- **Data Encryption:** VPN connections encrypt the data transmitted between your on-premises network and the cloud
network, providing a secure channel for data transfer.
- **Flexibility and Mobility:** VPN connections allow authorized users to securely access cloud resources from any
location, promoting flexibility and mobility in accessing critical applications and data.
- **Hybrid Cloud Connectivity:** VPN connections play a vital role in establishing secure and reliable connectivity
between your on-premises network and cloud resources, facilitating hybrid cloud architectures and seamless
integration.

**Summary** 

In summary, VPC Peering enables direct communication between VPCs, simplifying network architecture and enhancing
resource sharing within the cloud network. VPN connections establish secure tunnels between on-premises networks and
the cloud, enabling secure remote access and facilitating hybrid cloud connectivity. Both VPC Peering and VPN
connections contribute to building secure, scalable, and efficient network infrastructures in cloud environments.
