# GIT: Content overview
> **What is Git?** <br>
> **Why use Git?** <br>
> **initialising a repository and making commits**<br>
> **working with branches**<br>
> **Collaboration and remote repositories** <br>
> **Branch Management and Tagging** <br>

### What is Git? 
Git is a version control (VCS) system for tracking changes to projects. Version control systems are also called revision control systems or source code management (SCM) systems. These projects can be large-scale programs like the Linux kernel, but they can also be smaller scale projects like your own R development, homework assignments, papers, or thesis. There are many other VCSs available (subversion and Mercurial are currently used extensively in opens source projects) but Git is one of the easier ones to set up. It is also well supported by the GitHub and GitLab ecosystems, and UI has recently set up its own GitLab service.

### Why use Git?
Since the development and release of Git, it has gained huge popularity among the developers and being open source have incorporated many features. Today, a staggering number of projects use Git for version control, both commercial and personal. Let's see why Git has become so popular by discussing its main features
- Performance: Git provides the best performance when it comes to version control systems. Committing, branching, merging all are optimized for a better performance than other systems.
- Security: Git handles your security with cryptographic method SHA-1. The algorithm manages your versions, files, and directory securely so that your work is not corrupted.
- Branching Model: Git has a different branching model than the other VCS. Git branching model lets you have multiple local branches which are independent of each other. Having this also enables you to have friction-less context switching (switch back and forth to new commit, code and back), role-based code (a branch that always goes to production, another to testing etc) and disposable experimentation (try something out, if does not work, delete it without any loss of code).
- Staging Area: Git has an intermediate stage called "index" or "staging area" where commits can be formatted and modified before completing the commit.
- Distributed: Git is distributed in nature. Distributed means that the repository or the complete code base is mirrored onto the developer's system so that he can work on it only.
- Open Source: This is a very important feature of any software present today. Being open source invites the developers from all over the world to contribute to the software and make it more and more powerful through features and additional plugins. This has led the Linux kernel to be a software of about 15 million lines of code.

### Initializing a repository and making commits. 
Assuming that we have already installed GIT on our local computer, to initialize a git repo follow these steps:
Open a terminal on your computer, such as git bash,
Change or move into your working directory or folder and While you are inside the folder, run `git init` command
<br>

Example:(_Initialising Git_) <br> ![1  git init - initialising local git repository](https://github.com/Isaiahat/git-learning/assets/148476503/f1cdc102-f3c6-4ac8-8660-c20691a1ad32)
<br>
After initialising git, we must then add files for staging. To do this, we use the syntax: `git add (file)`
The next step is to commit our changes.
Before making our first commit lets try to understand what a commit is in git. Commit is more or less saving the changes
you made to your files. Changes can be adding, modifying or deleteing files or text.
When your make a commit, git takes a snapshot of the current state of your repository and saves a copy in the .git folder
inside your working directory.
Now lets make our first commit by following these steps:
Inside your working directory create a file and/or modify it. Afterwards, save your changes.
Add your changes to git staging area using this command git add .
To commit your changes to git, run the command `git commit -m "first files"`. The `-m` flag instructs git to register the comment in quote to your changes.
<br>

Example:(_Staging & Committing_) <br> ![2  git add - staging files](https://github.com/Isaiahat/git-learning/assets/148476503/09cc2d97-bdf5-4a70-93cd-772ad00cfbef)
 ![Git commit - saving changes](https://github.com/Isaiahat/git-learning/assets/148476503/c9503f59-1549-4051-a581-b5c43793d12c)

<br> 

### working with branches.
Git branch helps you create a different copy(page) of your source code. In your new branch you can make changes as you
please. Your change is independent of what is available in the main copy.
Git branch is commonly used to develop new feature of your application. You will agree with me that the initial code is
untested and as such can not be added to the code base of your live application.
Git branch is also an important tool for collaboration within remote teams(developers working from different location).
They can make separate branches while working on same feature. And at the end of the day, converge their code to one
branch.
To make a new branch run this command: `git checkout -b (branch name)`
The -b flag helps your create and change into the new branch
With that said lets make our first branch following these steps:
Having made your first commit in the previous section
Make a new branch by running this command `git checkout -b temp`
<br>

Example:(_creating branch_) <br> 
![git checkout - making a new branch](https://github.com/Isaiahat/git-learning/assets/148476503/3e45bef5-b433-439b-b110-e6c23cfb4c44)

Listing git branches. Command syntax: `git branch`
<br>

Example:(_list branches_) <br> 
![git branch - listing branches](https://github.com/Isaiahat/git-learning/assets/148476503/a5996579-0260-4db7-8d12-16035049b155)

To switch into an old branch or any different branch. Command syntax: `git checkout (branch name)`
<br>

Example:(_switch branch_) <br> 
![git branch - switching branch](https://github.com/Isaiahat/git-learning/assets/148476503/ee668faa-34f5-48ef-bf9d-7df10b7fb418)


To merge different branches. Lets say we have two branches A and B. And we want to add the content of branch B into A.
First we change into branch A and run the git command below: `git merge b`
<br>

Example:(_merge branch_) <br> 
![Git merge - merging branches](https://github.com/Isaiahat/git-learning/assets/148476503/8059aec1-2e41-4cfd-9f5d-762c0ecdc24f)


To delete a git branch. Command syntax: `git branch -d (branch name)`
<br>

Example:(_delete branch_) <br> 
![delete branch](https://github.com/Isaiahat/git-learning/assets/148476503/0f4cfc6e-4e28-4919-83f4-1f53a461c6f1)
<br> <br>
### Collaboration and remote repositories.
As we know that git is used for collaboration among remote teams(developers residing in different
location). But come to think of it how can developers working remotely collaborate(making changes, adding, updating etc)
on the same code base since we currently have our code in our local computer.
This where github comes in. Github is a web based platform where git repositores are hosted. By hosting our local git
repository on github, it becomes available in the public internet(it is possible to create private repository as well). Hence, anyone
can now access it.
Remote teams can easily view, update, and make changes to the same repository.
<br>
One way to do this is by creating a remote repository (on Github). Each user then connects and push changes from their local repositories to Github.

##### Pushing your Local git Repository to your Remote github Repository.
To push changes from our local machine to github.
Having created a github account and a github repository, Lets send a copy of our files to our repository in
github.
We will achieve this by following the steps bellow:
- Add a remote repository to the local repository using this command: `git remote add origin (http_link or SSH_link)`
<br>

Example:(_add github repository_) <br> ![4 - git http link](https://github.com/Isaiahat/git-learning/assets/148476503/70b16800-03f0-437e-95fd-088eda759297)
 ![4 - add github](https://github.com/Isaiahat/git-learning/assets/148476503/6ee6f2c8-d4be-4b3f-b615-1d7f1f952327)
 <br>

- After commiting your changes in your local repo. You push the content to the remote repo using the command
below:
Example:(_push to github repository_) <br> ![4 - git push](https://github.com/Isaiahat/git-learning/assets/148476503/bed044e0-1dd2-453c-99a3-105dabd16a1b)
 <br>

##### Cloning a remote git repository.
In the last section, We successfully added a remote git repository and pushed our story in the local repository. 
Additionally, we can also import a repository from Github to our local computer, create a branch and work on them. 
We do this by using the `Git clone` command.
The git clone command helps us make a copy of remote repository in our local machine. See it as a git tool for downloading
remote repository into our local machine. The command is as follows: `git clone (repo http or ssh)`
<br>

Example:(_git clone_) <br> ![4 - git http link](https://github.com/Isaiahat/git-learning/assets/148476503/e8bde68d-d6fb-46cc-bacf-9a8b17042bf8) 
![Git clone](https://github.com/Isaiahat/git-learning/assets/148476503/e62bfeb2-aeea-4fe7-8014-c522b6ea8c10)

 <br>

