# Ansible Refactoring & Static Assignments (Imports and Roles)
---------------------------------------------
## Introduction:

In this project we continue working with ansible-config-mgt repository and make some improvements of our
code. Now we need to refactor our Ansible code, create assignments, and learn how to use the imports functionality.

Imports allow to effectively re-use previously created playbooks in a new playbook - it allows us to organize tasks and reuse them when needed. <br>

#### Code Refactoring

Refactoring is a general term in computer programming. It means making changes to the source code without changing
expected behaviour of the software. The main idea of refactoring is to enhance code readability, increase maintainability
and extensibility, reduce complexity, add proper comments without affecting the logic.

In this case, we will move things around a little bit in the code, but the overall state of the infrastructure remains the same.

Let us see how we might improve our Ansible code!

## Refactor ansible code by importing other playbooks into site.yml

### Step 1 - Jenkins job enhancement

Before we begin, let us make some changes to our Jenkins job - now every new change in the codes creates a separate
directory which is not very convenient when we want to run some commands from one place. Besides, it consumes space
on Jenkins servers with each subsequent change. Let us enhance it by introducing a new Jenkins `project/job` - we will
require `Copy Artifact` plugin.

1. Go to your Jenkins-Ansible server and create a new directory called ansible-config-artifact - we will store
therein; all artifacts after each build.
``` bash
sudo mkdir /home/ubuntu/ansible-config-artifact
```

2. Change permissions to this directory, so Jenkins could save files there - 
``` bash
chmod -R 0777 /home/ubuntu/ansible-config-artifact
```

3. Go to Jenkins web console -> Manage Jenkins -> Manage Plugins -> on Available tab search for `Copy Artifact`
and install this plugin without restarting Jenkins

4. Create a new Freestyle project (you have done it in Project 9) and name it `save_artifacts.`

5. This project will be triggered by completion of your existing ansible project. Configure it accordingly:

**Note:** You can configure number of builds to keep in order to save space on the server, for example, you might want to keep
only last 2 or 5 build results. You can also make this change to your ansible job.

6. The main idea of `save_artifacts` project is to save artifacts into `/home/ubuntu/ansible-config-artifact`
directory. To achieve this, create a Build step and choose `Copy artifacts` from other project, specify
ansible as a source project and `/home/ubuntu/ansible-config-artifact` as a target directory.

![2  build steps for copy-artifact job](https://github.com/Isaiahat/git-learning/assets/148476503/5e9e3f93-cf08-497c-a169-566e3df03fcb)

<br>

![2b  configure save_artifacts](https://github.com/Isaiahat/git-learning/assets/148476503/c1a0bde1-5138-4ac8-ba71-e9c81ea58de2)

<br>

![2c  configure save_artifacts](https://github.com/Isaiahat/git-learning/assets/148476503/823bea48-bab3-44b1-bc35-60b8e112b5d5)

<br>

![2d  build steps for save_artifacts](https://github.com/Isaiahat/git-learning/assets/148476503/816cce60-d9bf-4522-bf9a-825185f8e327)


8. Test your set up by making some change in `README.MD` file inside your `ansible-config-mgt` repository (right
inside master branch).

If both Jenkins jobs have completed one after another - you shall see your files inside `/home/ubuntu/ansible-configartifact` directory and it will be updated with every commit to your master branch.

![2e  save_artifact job successful](https://github.com/Isaiahat/git-learning/assets/148476503/bd934c78-ddbf-492f-8a99-fae76ddc4279)


Now your Jenkins pipeline is more neat and clean.

### Step 2 - Refactor Ansible code by importing other playbooks into site.yml

Before starting to refactor the codes, ensure that you have pulled down the latest code from master (main) branch, and
create a new branch, name it refactor.

DevOps philosophy implies constant iterative improvement for better efficiency - refactoring is one of the techniques that
can be used, but you always have an answer to question "why?" <br>
Why do we need to change something if it works well?

In Project 11 we wrote all tasks in a single playbook common.yml, now it is a pretty simple set of instructions for only 2
types of OS, but imagine we have many more tasks and we need to apply this playbook to other servers with different
requirements. In this case, we will have to read through the whole playbook to check if all tasks written there are
applicable and is there anything that we need to add for certain server/OS families. Very fast it will become a tedious
exercise and our playbook will become messy with many commented parts. DevOps colleagues will not appreciate
such organization of our codes and it will be difficult for them to use our playbook.

Most Ansible users learn the one-file approach first. However, breaking tasks up into different files is an excellent way to
organize complex sets of tasks and reuse them.

Let see code re-use in action by importing other playbooks:

1. Within `playbooks` folder, create a new file and name it `site.yml` - This file will now be considered as an entry point
into the entire infrastructure configuration. Other playbooks will be included here as a reference. In other words,
`site.yml` will become a parent to all other playbooks that will be developed; Including `common.yml` that you
created previously. 

2. Create a new folder in root of the repository and name it `static-assignments`. The static-assignments folder is
where all other children playbooks will be stored. This is merely for easy organization of our work. It is not an
Ansible specific concept, therefore we can choose how we want to organize our work. You will see why the folder
name has a prefix of static very soon. For now, just follow along.
3. Move `common.yml` file into the newly created static-assignments folder.
4. Inside `site.yml` file, import `common.yml` playbook.
``` bash
---
- hosts: all
- import_playbook: ../static-assignments/common.yml
The code above uses built in import_playbook Ansible module.
Your folder structure should look like this;
├── static-assignments
│ └── common.yml
├── inventory
└── dev
└── stage
└── uat
└── prod
└── playbooks
└── site.yml
```

5. Run `ansible-playbook` command against the `/dev` environment

Since you need to apply some tasks to your `dev` servers and wireshark is already installed - you can go ahead and
create another playbook under `static-assignments` and name it `common-del.yml`. In this playbook, configure deletion
of `wireshark` utility.
``` bash
---
- name: update web, nfs and db servers
hosts: webservers, nfs, db
remote_user: ec2-user
become: yes
become_user: root
tasks:
- name: delete wireshark
yum:
name: wireshark
state: removed
- name: update LB server
hosts: lb
remote_user: ubuntu
become: yes
become_user: root
tasks:
- name: delete wireshark
apt:
name: wireshark-qt
state: absent
autoremove: yes
purge: yes
autoclean: yes
```

update `site.yml` with `- import_playbook: ../static-assignments/common-del.yml` instead of `common.yml` and
run it against `dev` servers:
``` bash
cd /home/ubuntu/ansible-config-mgt/

ansible-playbook -i inventory/dev.yml playbooks/site.yaml
``` 

Make sure that `wireshark` is deleted on all the servers by running `wireshark --version`

![3a  wireshark pre-installed](https://github.com/Isaiahat/git-learning/assets/148476503/2584b43e-cc33-4301-ad68-36ea24876da7)

<br>

![3b  common-del yml successful](https://github.com/Isaiahat/git-learning/assets/148476503/564a9fed-2c09-44f6-bf2b-d235aa974444)

<br>

![3c  confirmation from webserver](https://github.com/Isaiahat/git-learning/assets/148476503/28f29522-69e2-4ff4-99f0-9e9b4af469fc)


Now we have learned how to use `import_playbooks` module and we have a ready solution to install/delete packages on
multiple servers with just one command.

## Configure uat webservers with a role webserver

### Step 3 - Configure UAT Webservers with a role 'Webserver'

We have our nice and clean dev environment, so let us put it aside and configure 2 new Web Servers as `uat`. We could
write tasks to configure Web Servers in the same playbook, but it would be too messy, instead, we will use a dedicated role
to make our configuration reusable.

1. Launch 2 fresh EC2 instances using RHEL 8 image, we will use them as our uat servers, so give them names
accordingly - `Web1-UAT` and `Web2-UAT`. <br>
> **Tip:** Do not forget to stop EC2 instances that you are not using at the moment to avoid paying extra. For now, you only
need 2 new RHEL 8 servers as Web Servers and 1 existing Jenkins-Ansible server up and running.

2. To create a role, you must create a directory called `roles/`, relative to the playbook file or in `/etc/ansible/`
directory.
There are two ways to create this folder structure: <br>
- Use an Ansible utility called `ansible-galaxy` inside `ansible-config-mgt/roles` directory (you need to create
roles directory upfront)
``` bash
mkdir roles
cd roles
ansible-galaxy init webserver
```

![4  Create roles successfully](https://github.com/Isaiahat/git-learning/assets/148476503/052bf4af-77f6-4f13-b3ec-b891b00f4c73)


- Create the directory/files structure manually. <br>
> **Note:** You can choose either way, but since you store all your codes in GitHub, it is recommended to create folders and files there rather than locally on Jenkins-Ansible server.
The entire folder structure should look like below, but if you create it manually - you can skip creating `tests`, `files`,
and `vars` or remove them if you used `ansible-galaxy`
``` bash
└── webserver
├── README.md
├── defaults
│ └── main.yml
├── files
├── handlers
│ └── main.yml
├── meta
│ └── main.yml
├── tasks
│ └── main.yml
├── templates
├── tests
│ ├── inventory
│ └── test.yml
└── vars
└── main.yml
```

After removing unnecessary directories and files, the `roles` structure should look like this
``` bash
└── webserver
├── README.md
├── defaults
│ └── main.yml
├── handlers
│ └── main.yml
├── meta
│ └── main.yml
├── tasks
│ └── main.yml
└── templates
``` 

![4b  roles_webserver dir tree configured ](https://github.com/Isaiahat/git-learning/assets/148476503/3bdf7404-ea4e-4e0b-960c-f4534089f69b)


3. Update your inventory `ansible-config-mgt/inventory/uat.yml` file with IP addresses of your 2 UAT Web
servers
> **NOTE:** Ensure you are using `ssh-agent` to ssh into the Jenkins-Ansible instance just as you have done in project 11;
``` bash
[uat-webservers]
<Web1-UAT-Server-Private-IP-Address> ansible_ssh_user='ec2-user'
<Web2-UAT-Server-Private-IP-Address> ansible_ssh_user='ec2-user'
```

4. In `/etc/ansible/ansible.cfg` file, uncomment `roles_path` string and provide a full path to your roles directory
`roles_path = /home/ubuntu/ansible-config-mgt/roles`, so Ansible could know where to find configured roles.

![4c  specify roes_path in ansible cfg](https://github.com/Isaiahat/git-learning/assets/148476503/b63be015-f2e2-42f8-a5c2-424f8d6ffd71)


6. It is time to start adding some logic to the webserver role.
<br> Go into tasks directory, and within the `main.yml` file,
start writing configuration tasks to do the following:

- Install and configure Apache ( httpd service)
- Clone Tooling website from GitHub `https://github.com/<your-name>/tooling.git`.
- Ensure the tooling website code is deployed to /var/www/html on each of 2 UAT Web servers.
- Make sure `httpd` service is started

Your main.yml may consist of following tasks:
``` bash
---
- name: install apache
become: true
ansible.builtin.yum:
name: "httpd"
state: present
- name: install git
become: true
ansible.builtin.yum:
name: "git"
state: present
- name: clone a repo
become: true
ansible.builtin.git:
repo: https://github.com/<your-name>/tooling.git
dest: /var/www/html
force: yes
- name: copy html content to one level up
become: true
command: cp -r /var/www/html/html/ /var/www/
- name: Start service httpd, if not started
become: true
ansible.builtin.service:
name: httpd
state: started
- name: recursively remove /var/www/html/html/ directory
become: true
ansible.builtin.file:
path: /var/www/html/html
state: absent
``` 

## Reference webserver role

### Step 4 - Reference 'Webserver' role

Within the `static-assignments` folder, create a new assignment for **uat-webservers** `uat-webservers.yml` . This is
where you will reference the role.
``` bash
---
- hosts: uat-webservers
roles:
- webserver
```

Remember that the entry point to our ansible configuration is the `site.yml` file. Therefore, you need to refer your `uatwebservers.yml` role inside `site.yml`.
So, we should have this in site.yml
``` bash 
---
- hosts: all
- import_playbook: ../static-assignments/common.yml
- hosts: uat-webservers
- import_playbook: ../static-assignments/uat-webservers.yml
```

### Step 5 - Commit & Test

Commit your changes, create a Pull Request and merge them to `master` branch, make sure webhook triggered two
consequent Jenkins jobs, they ran successfully and copied all the files to your `Jenkins-Ansible` server into
`/home/ubuntu/ansible-config-mgt/` directory.

![5b  Jenkins triggered](https://github.com/Isaiahat/git-learning/assets/148476503/17285254-1833-4a90-97de-23f56bfb7ffb)

![5c  save_artifact triggered](https://github.com/Isaiahat/git-learning/assets/148476503/01560915-f2f8-49e4-937d-699679fa8558)


Now run the playbook against your uat inventory and see what happens: <br>
> **NOTE:** Before running your playbook, ensure you have tunneled into your `Jenkins-Ansible server` via `ssh-agent` 
``` bash
cd /home/ubuntu/ansible-config-mgt

ansible-playbook -i /inventory/uat.yml playbooks/site.yaml
```

![5a  ansible executed roles on uat servers](https://github.com/Isaiahat/git-learning/assets/148476503/9eadd409-106c-4834-8b40-94f04c545601)


You should be able to see both of your UAT Web servers configured and you can try to reach them from your browser:
``` bash
http://<Web1-UAT-Server-Public-IP-or-Public-DNS-Name>/index.php
```

or

```bash
http://<Web1-UAT-Server-Public-IP-or-Public-DNS-Name>/index.php
```

![5d  uat server 1](https://github.com/Isaiahat/git-learning/assets/148476503/99684038-93f9-4745-85a3-6baee388ff40)


![5e  uat server 2](https://github.com/Isaiahat/git-learning/assets/148476503/c2130e33-ca12-4bf2-81f0-b0c00368f0b4)


Your Ansible architecture now looks like this:

![6  Architecture depiction](https://github.com/Isaiahat/git-learning/assets/148476503/fb89aa8d-7f81-4cc5-ae03-5f9516f943ed)

-------------------------------------
In Project 13, we will see the difference between Static and Dynamic assignments.
Congratulations!
You have learned how to deploy and configure UAT Web Servers using Ansible imports and roles!
