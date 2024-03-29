# **Description**

This is an exercise on the Linux operating system and it what follows, I shall briefly discuss what Linux is, how it operates, some basic commands and functionalities in Linux


## **Overview:**
  ### **What is Linux?**
  ### **what is a command line?**
  ### **Basic commands in Linux**
<br>

  
### **What is Linux?** 
 Linux® is an open source operating system (OS). An operating system is the software that directly manages a system’s hardware and resources, like CPU, memory, and storage. The OS sits between applications and hardware and makes the connections between all of your software and the physical resources that do the work.
<br>


### **What is a command line?**
 The command line is a text interface to one's computer. It is often referred to as the shell, terminal, console, prompt or various other names. 
The command line is where you ask software to perform hardware actions that point-and-click graphical user interfaces (GUIs) simply can't ask. 
Command lines are available on many operating systems—proprietary or open source. But it’s usually associated with Linux, because both command lines and open source software, together, give users unrestricted access to their computer.


### **Basic commands in Linux**

In this exercise, I will be discussing two categories of Linux commands- in line with their respective functions. These two categories are:
> 1. File Manipulation
> 2. File Permissions and Ownership
<br>

   ### **File Manipulation**
1. #### **sudo**
Command syntax: `sudo <option> apt upgrade`

Short for superuser do, sudo is one of the most popular basic Linux commands that lets you perform tasks that require
administrative or root permissions.
When using sudo, the system will prompt users to authenticate themselves with a password. Then, the Linux system will
log a timestamp as a tracker. By default, every root user can run sudo commands for 15 minutes/session.
If you try to run sudo in the command line without authenticating yourself, the system will log the activity as a security
event.<br>

Example: (_image_)  
![Sudo - Run as administrator](https://github.com/Isaiahat/git-learning/assets/148476503/02306cd9-34cf-44b7-b961-80dd8264d5a5)
<br>
<br>

2. #### **pwd**
command syntax: `pwd <option>`

Use the pwd command to find the path of your current/present working directory. Simply entering pwd will return the full
current path – a path of all the directories that starts with a forward slash (/). 
It has two acceptable options:
-L or –logical prints environment variable content, including symbolic links.
-P or –physical prints the actual path of the current directory.<br>

Example: (_image_) 
![pwd command - show working directory](https://github.com/Isaiahat/git-learning/assets/148476503/9dd8a78b-59d7-4d1c-82b8-2ac6fc284f80)

<br>
<br>

3. #### **cd**
Command syntax: `cd <option>`

To navigate through the Linux files and directories, use the cd command. Depending on your current working directory, it
requires either the full path or the directory name.
Running this command without an option will take you to the home folder. Keep in mind that only users with sudo
privileges can execute it.
Let’s say you’re in /home/ubuntu and want to go to a new subdirectory of ubuntu. To do so, enter the following command:
`cd CommandsLinux`
If you want to switch to a completely new directory, for example, /home/ubuntu/CommandsLinux, you have to enter cd
followed by the directory’s absolute path:
`cd /home/ubuntu/CommandsLinux`
or
cd CommandsLinux

Example: (_image_) 
![cd - change directory](https://github.com/Isaiahat/git-learning/assets/148476503/6a77b36a-99d9-4d8b-a76d-7b4d14e5eb65)
<br>
<br>

4. #### **ls command**
command syntax: `ls <option>`

The ls command lists files and directories within a system. Running it without a flag or parameter will show the current
working directory’s content.
To see other directories’ content, type ls followed by the desired path. For example, to view files in the Documents folder,
enter:
ls /home/ubuntu/Documents
Here are some options you can use with the ls command:
ls -R
lists all the files in the subdirectories
ls -a
shows hidden files in addition to the visible ones.
ls -lh
shows the file sizes in easily readable formats, such as KB, MB, GB, and TB.<br>

Example: (_image_) 
![ls - list contents in a directory](https://github.com/Isaiahat/git-learning/assets/148476503/961b6572-be15-486a-a42e-c7e930c996a4)
<br>
<br>

5. #### **cat**
Command syntax: `cat filename1.txt`
Concatenate, or cat, is one of the most frequently used Linux commands. It lists, combines, and writes file content to the
standard output.<br>

Example: (_image_) 
![cat command - read file content](https://github.com/Isaiahat/git-learning/assets/148476503/8b682082-4676-40d2-a5d3-c41e085b8a67)

<br>
<br>

6. #### **cp** 
Command syntax: `cp <option> file1 file2 ~/desktop/folder/`

Use the cp command to copy files or directories and their content. Take a look at the following use cases.
To copy one file from the current directory to another, enter cp followed by the file name and the destination directory- as above.

To copy the content of a file to a new file in the same directory, enter cp followed by the source file and the destination file
as show below:
cp filename1.txt filename2.txt
To copy an entire directory, pass the -R flag before typing the source directory, followed by the destination directory:
cp -R /home/username/Documents /home/username/Documents_backup <br>

Example: (_image_) 
![cp - copy files](https://github.com/Isaiahat/git-learning/assets/148476503/81a6517b-4423-4c38-96e6-a3f71de71f65)
![cp - keeping file copy](https://github.com/Isaiahat/git-learning/assets/148476503/facbc9b3-e74a-46b8-b549-b2cdb6e74fb2)
![cp - copy files recursively](https://github.com/Isaiahat/git-learning/assets/148476503/6eb565f2-581e-4448-89d1-c3d4a2b00463)

<br>
<br>

7. #### **mv**
Command syntax: `mv <option> file1 file2 ~/desktop/folder/`

The primary use of the mv command is to move and rename files and directories. Additionally, it doesn’t produce an output
upon execution.
Simply type mv followed by the filename and the destination directory. As below: <br>

Example: (_image_) 
![mv - move files, folders and rename](https://github.com/Isaiahat/git-learning/assets/148476503/6f926d72-bbbb-4477-a50e-5323d548e225)

<br>
<br>

8. #### **mkdir**
Command syntax: `mkdir <option> folder`

Use the mkdir command to create one or multiple directories at once and set permissions for each of them. The user
executing this command must have the privilege to make a new folder in the parent directory, or they may receive a
permission denied error.

Example: (_image_) 




9. #### **rmdir** 
Command syntax: `rmdir <option> folder`

To permanently delete an empty directory, use the rmdir command. Remember that the user running this command should
have sudo privileges in the parent directory.
For example, you want to remove an empty subdirectory named Songs and its main folder Music:
rmdir -p Music/Songs

Example: (_image_) 




10. #### **rm**

Command syntax: `rm <option> file`

The rm command is used to delete files within a directory. Make sure that the user performing this command has write
permissions.
Remember the directory’s location as this will remove the file(s) and you can’t undo it.
To remove multiple files, enter the following command:
rm filename1 filename2 filename3
Here are some acceptable options you can add:
-i prompts system confirmation before deleting a file. -f allows the system to remove without a confirmation. -r deletes
files and directories recursively.

Example: (_image_) 






11. #### **touch**

Command Syntax:

The touch command allows you to create an empty file or generate and modify a timestamp in the Linux command line.

Example: (_image_) 






12. #### **locate**

The locate command can find a file in the database system.
Moreover, adding the -i argument will turn off case sensitivity, so you can search for a file even if you don’t remember its
exact name.
To look for content that contains two or more words, use an asterisk (*). For example:
locate -i school*note
The command will search for files that contain the words school and note, whether they use uppercase or lowercase
letters.



13. #### **find**

Use the find command to search for files within a specific directory and perform subsequent operations. Here’s the general
syntax:
find [option] [path] [expression]
You can edit to suit your case
For example, you want to look for a file called sql_commands.sh within the home directory and its subfolders:
find /home -name sql_commands.sh
Here are other variations when using find:
find -name filename.txt to find files in the current directory. find ./ -type d -name directoryname to look for directories



14. #### **grep**

Another basic Linux command on the list is grep or global regular expression print. It lets you find a word by searching
through all the texts in a specific file.
Once the grep command finds a match, it prints all lines that contain the specific pattern. This command helps filter
through large log files.
For example, you want to search for the word blue in the notepad.txt file:
grep values sql_commands.sh
The command’s output will display lines that contain blue.

Example: (_image_)

15. #### **df**
command syntax: `df [options] [file]`

Use the df command to report the system’s disk space usage, shown in percentage and kilobyte (KB).

For example, enter the following command if you want to see the current directory’s system disk space usage in a humanreadable format:
df -h
Copy Below Code
Copy Below Code
Copy Below Code
1/17/24, 2:50 AM Learning Path - Project - Darey.io
https://app.dareyio.com/learning/project 11/25
These are some acceptable options to use:
df -m displays information on the file system usage in MBs. df -k displays file system usage in KBs. df -T shows the file
system type in a new column.

Example: (_image_)


16. #### **du**
command syntax: `du /home/ubuntu/CommandsLinux`

If you want to check how much space a file or a directory takes up, use the du command. You can run this command to
identify which part of the system uses the storage excessively.
Remember, you must specify the directory path when using the du command. For example, to check
/home/ubuntu/CommandLinux enter:
du /home/ubuntu/CommandsLinux
Adding a flag to the du command will modify the operation, such as:
-s offers the total size of a specified folder. -m provides folder and file information in MB k displays information in KB. -h
informs the last modification date of the displayed folders and files.

Example: (_image_)


17. #### **head**
command syntax: `head <option> file`

The head command allows you to view the first ten lines of a text. Adding an option lets you change the number of lines
shown. The head command is also used to output piped data to the CLI.

For instance, you want to view the first ten lines of deploy1.yml, located in the current directory:
head deploy1.yml
-n or –lines prints the first customized number of lines. For example, enter head -n 5 filename.txt to show the first five lines
of filename.txt. -c or –bytes prints the first customized number of bytes of each file. -q or –quiet will not print headers
specifying the file name.

Example: (_image_)




18. #### **tail** 
Command Syntax:

The tail command displays the last ten lines of a file. It allows users to check whether a file has new data or to read error
messages.

Example: (_image_)




19. #### **diff**
Command Syntax:

Short for difference, the diff command compares two contents of a file line by line. After analyzing them, it will display the
parts that do not match.
Programmers often use the diff command to alter a program instead of rewriting the entire source code.

For example, you want to compare two files – deploy1.yml and deploy2.yml
diff deploy1.yml deploy2.yml
Here are some acceptable options to add:
-c displays the difference between two files in a context form. -u displays the output without redundant information. -i
makes the diff command case insensitive.

Example: (_image_)




20. #### **tar**
Command Syntax: `tar -cvf <filename.tar> <directory>`

The tar command archives multiple files into a TAR file – a common Linux format similar to ZIP, with optional compression.

For instance, you want to create a new TAR archive named newarchive.tar in the /home/ubuntu directory:
you can edit the code below to suit your purpose.
tar -cvf newarchive.tar /home/ubuntu
The tar command accepts many options, such as: -x extracts a file.
-t lists the content of a file.
-u archives and adds to an existing archive file.



### **File Permissions and Ownership**
&nbsp; 

21. #### **chmod**
Command Syntax: `chmod [option] [permission] [file_name]`

chmod is a common command that modifies a file or directory’s read, write, and execute permissions. In Linux, each file is
associated with three user classes – owner, group member, and others.

For example, the owner is currently the only one with full permissions to change note.txt. To allow group members and
others to read, write, and execute the file, change it to the -rwxrwxrwx permission type, whose numeric value is 777:
chmod 777 deploy1.yml

This command supports many options, including:
-c or –changes displays information when a change is made. -f or –silent suppresses the error messages. -v or –verbose
displays a diagnostic for each processed file.

Example: (_image_)




22. #### **chown**
Command Syntax: `chown user1 file`

The chown command lets you change the ownership of a file, directory, or symbolic link to a specified username.
Here’s the basic format:
chown [option] owner[:group] file(s)
For example, you want to make Bob the owner of file.txt:

Example: (_image_)



23. #### **jobs**
Command syntax: ``
A job is a process that the shell starts. The jobs command will display all the running processes along with their statuses.
Remember that this command is only available in csh, bash, tcsh, and ksh shells.
This is the basic syntax:
jobs [options] jobID
To check the status of jobs in the current shell, simply enter jobs to the CLI.
Here are some options you can use:
-l lists process IDs along with their information. -n lists jobs whose statuses have changed since the last notification. -p lists
process IDs only.

Example: (_image_)



24. #### **kill**
Use the kill command to terminate an unresponsive program manually. It will signal misbehaving applications and instruct
them to close their processes.
To kill a program, you must know its process identification number (PID). If you don’t know the PID, run the following
command:
ps ux
After knowing what signal to use and the program’s PID, enter the following syntax:
kill [signal_option] pid
There are 64 signals that you can use, but these two are among the most commonly used:
SIGTERM requests a program to stop running and gives it some time to save all of its progress. The system will use this by
default if you don’t specify the signal when entering the kill command. SIGKILL forces programs to stop, and you will lose
unsaved progress. For example, the program’s PID is 63773, and you want to force it to stop:
kill SIGKILL 63773



25. #### **ping**
Command syntax: 


The ping command is one of the most used basic Linux commands for checking whether a network or a server is reachable.
In addition, it is used to troubleshoot various connectivity issues.
Here’s the general format:
ping [option] [hostname_or_IP_address]
For example, you want to know whether you can connect to Google and measure its response time:
ping google.com

Example: (_image_)



26. #### **wget**
Command syntax: 

Example: (_image_)

The Linux command line lets you download files from the internet using the wget command. It works in the background
without hindering other running processes.
The wget command retrieves files using HTTP, HTTPS, and FTP protocols. It can perform recursive downloads, which
transfer website parts by following directory structures and links, creating local versions of the web pages.




27. #### **uname**
command syntax: `uname <option>`

The uname or unix name command will print detailed information about your Linux system and hardware. This includes
the machine name, operating system, and kernel. To run this command, simply enter uname into your CLI.

These are the acceptable options to use:
-a prints all the system information. -s prints the kernel name. -n prints the system’s node hostname.

Example: (_image_)


28.#### **top**
command syntax:

The top command in Linux Terminal will display all the running processes and a dynamic real-time view of the current
system. It sums up the resource utilization, from CPU to memory usage.
The top command can also help you identify and terminate a process that may use too many system resources.
To run the command, simply enter top into the CLI.

Example: (_image_)



29. #### **history** 
command syntax: `history <option>`

With history, the system will list up to 500 previously executed commands, allowing you to reuse them without reentering. Keep in mind that only users with sudo privileges can execute this command. How this utility runs also depends
on which Linux shell you use.
To run it, enter the command below:
history [option]
This command supports many options, such as:
-c clears the complete history list. -d offset deletes the history entry at the OFFSET position. -a appends history lines.

Example: (_image_)


30. #### **man**
command syntax: `man <option> command`

The man command provides a user manual of any commands or utilities you can run in Terminal, including the name,
description, and options.
It consists of nine sections:
Executable programs or shell commands System calls Library calls Games Special files File formats and conventions
System administration commands Kernel routines Miscellaneous 

Example: (_image_)



31. #### **echo**
command syntax: `echo <option> <string>`

The echo command is a built-in utility that displays a line of text or string using the standard output. 
This command supports many options, such as:
-n displays the output without the trailing newline. -e enables the interpretation of the following backslash escapes: \a
plays sound alert. \b removes spaces in between a text. \c produces no further output. -E displays the default option and
disables the interpretation of backslash escapes.

Example: (_image_)


32. #### **zip, unzip**
command syntax: 
> `zip <option> <file.zip>`
> `unzip <option> <file.zip>`

Use the zip command to compress your files into a ZIP file, a universal format commonly used on Linux. It can
automatically choose the best compression ratio.
The zip command is also useful for archiving files and directories and reducing disk usage.
To use it, enter the following syntax:
zip [options] zipfile file1 file2….
For example, you have a file named note.txt that you want to compress into archive.zip in the current directory:
zip archive.zip note.txt

Example: (_image_)



33. #### **hostname**
command syntax: `hostname <option>`

Run the hostname command to know the system’s hostname. You can execute it with or without an option. 

There are many optional flags to use, including:
-a or –alias displays the hostname’s alias. -A or –all-fqdns displays the machine’s Fully Qualified Domain Name (FQDN). -i
or –ip-address displays the machine’s IP address. For example, enter the following command to know your computer’s IP
address:
hostname -i

Example: (_image_)



34. #### **useradd, userdel**
command syntax: 
> `useradd <option> <usernane>`
> to set password `paaswd <pass combination>`
> `userdel <username>`

Linux is a multi-user system, meaning more than one person can use it simultaneously. useradd is used to create a new
account, while the passwd command allows you to add a password. Only those with root privileges or sudo can run the
useradd command.
When you use the useradd command, it performs some major changes:
Edits the /etc/passwd, /etc/shadow, /etc/group, and /etc/gshadow files for the newly created accounts. Creates and
populates a home directory for the user. Sets file permissions and ownerships to the home directory.

 Example: (_image_)



35. #### **apt-get**
command syntax: `apt-get <option> <command or package>`
apt-get is a command line tool for handling Advanced Package Tool (APT) libraries in Linux. It lets you retrieve information
and bundles from authenticated sources to manage, update, remove, and install software and its dependencies.
Running the apt-get command requires you to use sudo or root privileges.

These are the most common commands you can add to apt-get:
update synchronizes the package files from their sources. upgrade installs the latest version of all installed packages.
check updates the package cache and checks broken dependencies.

Example: (_image_)



36. #### **nano, vi, jed**
command syntax:
> `nano <file.txt>`
> `vi <file.txt>`

Linux allows users to edit and manage files via a text editor, such as nano, vi, or jed. nano and vi come with the operating
system, while jed has to be installed.
The nano command denotes keywords and can work with most languages. To use it, enter the following command:
nano [filename]
vi uses two operating modes to work – insert and command. insert is used to edit and create a text file. On the other hand,
the command performs operations, such as saving, opening, copying, and pasting a file.
To use vi on a file, enter:
vi [filename]


jed has a drop-down menu interface that allows users to perform actions without entering keyboard combinations or
commands. Like vi, it has modes to load modules or plugins to write specific texts.
To open the program, simply enter jed to the command line.

Example: (_image_)



37. #### **alias, unalias**
command syntax:
> `alias <alias name>`
> `unalias <alias name>`

alias allows you to create a shortcut with the same functionality as a command, file name, or text. When executed, it
instructs the shell to replace one string with another.
To use the alias command, enter this syntax:
alias Name=String
For example, you want to make k the alias for the kill command:
alias k=’kill’
On the other hand, the unalias command deletes an existing alias.

Example: (_image_)



38. #### **su**
command syntax: 

The switch user or su command allows you to run a program as a different user. It changes the administrative account in
the current log-in session. This command is especially beneficial for accessing the system through SSH or using the GUI
display manager when the root user is unavailable.
Here’s the general syntax of the command:
su [options] [username [argument]]
When executed without any option or argument, the su command runs through root privileges. It will prompt you to
authenticate and use the sudo privileges temporarily.
Here are some acceptable options to use:
Copy Below Code
Copy Below Code
Copy Below Code
Copy Below Code
1/17/24, 2:50 AM Learning Path - Project - Darey.io
https://app.dareyio.com/learning/project 25/25
-p or –preserve-environment keeps the same shell environment, consisting HOME, SHELL, USER, and LOGNAME. -s or –
shell lets you specify a different shell environment to run. -l or –login runs a login script to switch to a different username.
Executing it requires you to enter the user’s password.





39. #### **htop** 
 
The htop command is an interactive program that monitors system resources and server processes in real time. It is
available on most Linux distributions, and you can install it using the default package manager.
Compared to the top command, htop has many improvements and additional features, such as mouse operation and visual
indicators.
To use it, run the following command:
htop [options]
You can also add options, such as:
-d or –delay shows the delay between updates in tenths of seconds. -C or –no-color enables the monochrome mode. -h or –
help displays the help message and exit.




40. #### **ps** 

The process status or ps command produces a snapshot of all running processes in your system. The static results are
taken from the virtual files in the /proc file system.
Executing the ps command without an option or argument will list the running processes in the shell along with:
The unique process ID (PID) The type of the terminal (TTY) The running time (TIME) The command that launches the
process (CMD)
Here are some acceptable options you can use:
-T displays all processes associated with the current shell session. -u username lists processes associated with a specific
user. -A or -e shows all the running processes.
