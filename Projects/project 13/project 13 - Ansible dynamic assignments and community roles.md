# Ansible Dynamic Assignments (Include) and Community Roles

## Introduction

This project helps us realise the flexibility of Ansible with dynamic assignments (include) and community roles, expanding your
automation capabilities and leveraging pre-built solutions.

> **IMPORTANT NOTICE:** Ansible is an actively developing software project, so you are encouraged to visit Ansible
Documentation for the latest updates on modules and their usage.

Last 2 projects have already equipped you with some knowledge and skills on Ansible, so you can perform configurations
using playbooks, roles and imports. Now you will continue configuring your UAT servers learning and practicing
new Ansible concepts and modules.

In this project we will introduce dynamic assignments by using `include` module.

Now, what is the difference between static and dynamic assignments? <br>
Well, from Project 12, you can already tell that static assignments use import Ansible module. The module that enables
dynamic assignments is called `include`.

Hence,
- import = Static
- include = Dynamic

When the import module is used, all statements are pre-processed at the time playbooks are parsed. Meaning, when you execute `site.yml` playbook, Ansible will process all the playbooks referenced during the time it is parsing the
statements. This also means that, during actual execution, if any statement changes, such statements will not be
considered. Hence, it is static.

On the other hand, when `include` module is used, all statements are processed only during execution of the playbook.
Meaning, after the statements are parsed, any changes to the statements encountered during execution will be used.

> Take note that in most cases it is recommended to use static assignments for playbooks, because it is more reliable. With
dynamic ones, it is hard to debug playbook problems due to its dynamic nature. However, you can use dynamic
assignments for environment specific variables as we will be introducing in this project.

## Introducing dynamic assignmentinto our structure

In your `https://github.com/<your-name>/ansible-config-mgt` GitHub repository start a new branch and call it
`dynamic-assignments`.
Create a new folder, name it -`assigndynamicments`. Then inside this folder, create a new file and name it `env-vars.yml`.

We will instruct `site.yml` to include this playbook later. For now, let us keep building up the structure.
Your GitHub shall have following structure by now.

> **Note:** Depending on what method you used in the previous project you may have or not have roles folder in your
GitHub repository - if you used `ansible-galaxy`, then roles directory was only created on your Jenkins-Ansible
server locally. It is recommended to have all the codes managed and tracked in GitHub, so you might want to recreate this
structure manually in this case - it is up to you.
``` bash
├── dynamic-assignments
│ └── env-vars.yml
├── inventory
│ └── dev
└── stage
└── uat
└── prod
└── playbooks
└── site.yml
└── roles (optional folder)
└──...(optional subfolders & files)
└── static-assignments
└── common.yml
```

Since we will be using the same Ansible to configure multiple environments, and each of these environments will have
certain unique attributes, such as servername, ip-address etc., we will need a way to set values to variables per specific
environment.
For this reason, we will now create a folder to keep each environment's variables file. Therefore, create a new folder `envvars`, then for each environment, create new YAML files which we will use to set variables.
Your layout should now look like this. <br>
``` bash
├── dynamic-assignments
│ └── env-vars.yml
├── env-vars
└── dev.yml
└── stage.yml
└── uat.yml
└── prod.yml
├── inventory
└── dev
└── stage
└── uat
└── prod
├── playbooks
└── site.yml
└── static-assignments
└── common.yml
└── webservers.yml
```

![1  repo directory structure](https://github.com/user-attachments/assets/0044ca55-3dab-4eac-8447-ff3a667b3e6d)


Now paste the instruction below into the env-vars.yml file.


``` bash 
---
- name: collate variables from env specific file, if it exists
hosts: all
tasks:
- name: looping through list of available files
include_vars: "{{ item }}"
with_first_found:
- files:
- dev.yml
- stage.yml
- prod.yml
- uat.yml
paths:
- "{{ playbook_dir }}/../env-vars"
tags:
- always
```

Notice 3 things to notice here:

1. We used `include_vars` syntax instead of `include`, this is because Ansible developers decided to separate
different features of the module. <br> 
From Ansible version 2.8, the include module is deprecated and variants of
`include_*` must be used. These are: <br>
- `include_role`
- `include_tasks`
- `include_vars`

In the same version, variants of import were also introduces, such as:<br>
- `import_role`
- `import_tasks`

2. We made use of a special variables `{{ playbook_dir }}` and `{{ inventory_file }}` . `{{ playbook_dir }}` will
help Ansible to determine the location of the running playbook, and from there navigate to other path on the
filesystem.<br> `{{ inventory_file }}` on the other hand will dynamically resolve to the name of the inventory file
being used, then append `.yml` so that it picks up the required file within the `env-vars` folder.

3. We are including the variables using a loop. `with_first_found` implies that, looping through the list of files, the
first one found is used. This is good so that we can always set default values in case an environment specific `env` file
does not exist.

## Update site.yml with dynamic assignments

### Update `Site.tml` with dynamic assignments

`Update site.yml` file to make use of the dynamic assignment. (At this point, we cannot test it yet. We are justsetting the
stage for what is yet to come. So hang on to your hats)
`site.yml` should now look like this.

``` bash
---
- hosts: all
- name: Include dynamic variables
tasks:
import_playbook: ../static-assignments/common.yml
include: ../dynamic-assignments/env-vars.yml
tags:
- always
- hosts: webservers
- name: Webserver assignment
import_playbook: ../static-assignments/webservers.yml
```

### Update site.yml with dynamic assignments - Community Roles

Now it is time to create a role for MySQL database - it should install the MySQL package, create a database and configure
users. But why should we re-invent the wheel? <br> There are tons of roles that have already been developed by other open
source engineers out there. These roles are actually production ready, and dynamic to accomodate most of Linux flavours.
With Ansible Galaxy again, we can simply download a ready to use ansible role, and keep going.

### Download Mysql Ansible Role
You can browse available community roles [here](https://galaxy.ansible.com/ui/)

We will be using a [MySQL role](https://galaxy.ansible.com/ui/standalone/roles/geerlingguy/mysql/) developed by geerlingguy. <br>
> **Hint:** To preserve your your GitHub in actual state after you install a new role - make a commit and push to master your
`'ansible-config-mgt'` directory. Of course you must have `git` installed and configured on Jenkins-Ansible server and,
for more convenient work with codes, you can configure Visual Studio Code to work with this directory. In this case, you
will no longer need webhook and Jenkins jobs to update your codes on `Jenkins-Ansible` server, so you can disable it -
we will be using Jenkins later for a better purpose.
On Jenkins-Ansible server make sure that git is installed with `git --version`, then go to `'ansible-config-mgt'` directory and run:

``` bash
git init
git pull https://github.com/<your-name>/ansible-config-mgt.git
git remote add origin https://github.com/<your-name>/ansible-config-mgt.git
git branch roles-feature
git switch roles-feature
```

Inside `roles` directory create your new MySQL role with `ansible-galaxy install geerlingguy.mysql` and rename
the folder to `mysql`

``` bash
mv geerlingguy.mysql/ mysql
```

Read` README.md` file, and edit roles configuration to use correct credentials for MySQL required for the `tooling`
website. <br>

![2  mysql readme file](https://github.com/user-attachments/assets/8a6499d7-f65b-4c44-93bf-e8c14fe98f9d)


Now it is time to upload the changes into your GitHub:

``` bash
git add.
git commit -m "Commit new role files into GitHub"
git push --set-upstream origin roles-feature
```

![3  git push roles-feature successful](https://github.com/user-attachments/assets/9c5829c8-a4ec-47ff-8cb4-983568d2b328)
<br>

Now, if you are satisfied with your codes, you can create a Pull Request and merge it to `main` branch on GitHub.

### Load Balancer roles

We want to be able to choose which Load Balancer to use, Nginx or Apache, so we need to have two roles respectively:

1. Nginx

2. Apache

![4  create nginx and apache roles](https://github.com/user-attachments/assets/c275d086-7d81-42fe-8579-817da1d06db9)


With your experience on Ansible so far you can:
- Decide if you want to develop your own roles, or find available ones from the community.

- Update both static-assignment and site.yml files to refer the roles <br>
![4b  update static assignments with nginx and apache roles](https://github.com/user-attachments/assets/9e53e941-ae6d-46af-8575-ffccfd8ae236)


> **Important Hints:**
> - Since you cannot use both Nginx and Apache load balancer, you need to add a condition to enable either one - this is
where you can make use of variables.
> - Declare a variable in `defaults/main.yml` file inside the Nginx and Apache roles. <br> Name each variables
`enable_nginx_lb` and `enable_apache_lb` respectively.
> - Set both values to false like this `enable_nginx_lb: false` and `enable_apache_lb: false`. <br>
![5c  hint - declare variable in defaults_main yml file inside the nginx and apache roles dir respectively ](https://github.com/user-attachments/assets/380aca0d-3554-4783-87a0-6a23aa8b809a) <br>
<br>
![5d  hint - declare variable in defaults_main yml file inside the nginx and apache roles dir respectively ](https://github.com/user-attachments/assets/d440c929-9a13-43f8-bba4-4513b48f541c)


> - Declare another variable in both roles `load_balancer_is_required` and set its value to false as well
Update both assignment and `site.yml` files respectively.

In `loadbalancers.yml` file

``` bash
- hosts: lb
roles:
- { role: nginx, when: enable_nginx_lb and load_balancer_is_required }
- { role: apache, when: enable_apache_lb and load_balancer_is_required }
```

![5e  create loadbalancers yml file](https://github.com/user-attachments/assets/d38a759c-56a8-44e7-afca-f19020a5f45d)



`site.yml` file
``` bash
- name: Loadbalancers assignment
hosts: lb
- import_playbook: ../static-assignments/loadbalancers.yml
when: load_balancer_is_required
```



Now you can make use of `env-vars\uat.yml` file to define which loadbalancer to use in UAT environment by setting
respective environmental variable to `true`. <br>
You will activate load balancer, and enable nginx by setting these in the respective environment's `env-vars` file.

``` bash
enable_nginx_lb: true
load_balancer_is_required: true
```

![5f  edit uat yml file and enable nginx](https://github.com/user-attachments/assets/e4d771d0-4887-41e2-93f0-af5e88eeb5e0)


The same must work with `apache` LB, so you can switch it by setting respective environmental variable to true and
other to false.

To test this, you can update inventory for each environment and run Ansible against each environment.



##### Congratulations!
You have learned and practiced how to use Ansible configuration management tool to prepare UAT environment for Tooling web solution.
