# Shell Scripting - Project overview

- Introduction to Shell Scripting and User Input
 	- Shell Scripting syntax elements
	- Shell Script
- Directory Manipulation and Navigation
- File Operations and Sorting
- Working with Numbers and Calculations
- File Backup and Timestamping


## Introduction to Shell Scripting and User Input.

In our git course, we have been writing commands on the terminal and getting corresponding output. The commands
are instructions to the computer to carryout certain task. <br>

For instance, when we want to clone a git repo, we type the command `git clone` and pass in the link to the
repository. In less than no time we see the repo downloaded into our local machine. <br>

Lets say you are given a task to clone 1000 repositories. Yes you can type the `git clone` command 1000 times. That
gets the job done. Someone with not so great patience maybe unable to complete the task.
This is where shell scripting commes in. Shell scripting helps you automate repetitive task. We can simply write a script
that does the job of cloning the 1000 repositories. We call it once and the job is done. We have the advantage of using
it again whenever we are signed same task.
Bash scripts are essentially a series of commands and instructions that are executed sequentially in a shell. You can
create a shell script by saving a collection of commands in a text file with a `.sh` extension. These scripts can be executed
directly from the command line or called from other scripts.


### Shell Scripting Syntax Elements

1. Variables: Bash allows you to define and work with variables. Variables can store data of various types such as
numbers, strings, and arrays. You can assign values to variables using the = operator, and access their values
using the variable name preceded by a $ sign. <br>
Example: Assigning value to a variable: <br>
`name="John"` <br>
Example: Retrieving value from a variable: <br>
`echo $name` <br>

![Alt text](<../Project 5/Image/1. variable.png>)


2. Control Flow: Bash provides control flow statements like if-else, for loops, while loops, and case statements to
control the flow of execution in your scripts. These statements allow you to make decisions, iterate over lists,
and execute different commands based on conditions.<br>
Example: Using if-else to execute script based on a conditions: <br>

>#!/bin/bash
>
>
> .# Example script to check if a number is positive, negative, or zero
>
>
>read -p "Enter a number: " num <br>
> if [ $num -gt 0 ]; then <br>
	>echo "The number is positive." <br>
>elif [ $num -lt 0 ]; then <br>
	>echo "The number is negative." <br>
>else <br>
	>echo "The number is zero." <br>
>fi
<br>

![Alt text](<../Project 5/Image/2. control flow - if-else.png>) <br>

<br>
The piece of code prompts you to type a number and prints a statement stating the number is positive or negative.
Example: Iterating through a list using a for loop <br>

> #!/bin/bash <br>
>
>
> .# Example script to print numbers from 1 to 5 using a for loop <br>
>
>
> for (( i=1; i<=5; i++ )) <br>
> do <br>
	> echo $i <br>
> done
<br>

![Alt text](<../Project 5/Image/3. control flow - for loop.png>)


3. Command Substitution: Command substitution allows you to capture the output of a command and use it as a
value within your script. You can use the backtick or the `()` syntax for command substitution. <br>

Example: Using backtick for command substitution <br>
> $`current_date=date` $<br>

Example: Using $()$ syntax for command substitution <br>
> `current_date=$(date)` <br>
![Alt text](<../Project 5/Image/4. Command substitution.png>)
<br>
<br>

![Alt text](<../Project 5/Image/5. Command substitution.png>)


4. Input and Output: Bash provides various ways to handle input and output. You can use the read command to
accept user input, and output text to the console using the echo command. Additionally, you can redirect input
and output using operators like > (output to a file), < (input from a file), and | (pipe the output of one command as
input to another).<br>

>Example: Accept user input: <br>
>echo "Enter your name:"
>read name


>Example: Output text to the terminal <br>
>echo "Hello World"


>Example: Out the result of a command into a file <br>
>echo "hello world" > index.txt


>Example: Pass the content of a file as input to a command <br>
grep "pattern" < input.txt


>Example: pass the result of a command as input to another command <br>
echo "hello world" | grep "pattern"



5. Functions: Bash allows you to define and use functions to group related commands together. Functions provide
a way to modularize your code and make it more reusable. You can define functions using the function keyword
or simply by declaring the function name followed by parentheses. <br>
>#!/bin/bash
>
>
> $ # Define a function to greet the user <br>
>greet() { <br>
>echo "Hello, $1! Nice to meet you." <br>
>}
>
>
>$# Call the greet function and pass the name as an argument
greet "John"

<br>

![Alt text](<../Project 5/Image/7. input-output - functions.png>)

### Lets write our First Shell Script

step 1: On your terminal, open a folder called shell-scripting using the command `mkdir shell-scripting`. <br> This will
hold all the script we will write in this lesson.<br>
step 2: create a file called user-input.sh using the command `touch user-input.sh` <br>
step 3: Inside the file copy and paste the block of code below: <br>
>#!/bin/bash
>
>
>$# Prompt the user for their name <br>
>echo "Enter your name:" <br>
>read name <br>
><br>
>
>$# Display a greeting with the entered name <br>
>echo "Hello, $name! Nice to meet you." <br>

A liitle bit about the code block. The script prompts for your name. When you type your name, it displays the text: <br>
> "hello (name)!" <br>
>Nice to meet you. 

Also #!/bin/bash helps you specify the type of bash interpreter to be used to execute the script.
step 4: save your file
step 5: Run the command `sudo chmod +x user-input.sh` this makes the file executable


step 6: Run the script using the command `./user-input.sh`
<br>

![Alt text](<../Project 5/Image/8. Test shellscript.png>)
<br>

## Directory Manipulation and Navigation

On the back of your lessons on Directory Manipulation and Navigation of Linux file system, We will be writing a simple
shell script as a way of practicing what we learnt.
This script will display the current directory, create a new directory called "my_directory," change to that directory,
create two files inside it, list the files, move back one level up, remove the "my_directory" and its contents, and finally
list the files in the current directory again.
Proceed by following the steps bellow:
step 1: open a file named navigating-linux.sh <br>
step 2: paste the code block below into your file.
>#!/bin/bash<br>
>
><br>
>$# Display current directory <br>
>echo "Current directory: $PWD" <br>
>
><br>
>$# Create a new directory <br>
>echo "Creating a new directory..." <br>
>mkdir my_directory <br>
>echo "New directory created." <br>
>
><br>
>#$ Change to the new directory <br>
>echo "Changing to the new directory..." <br>
>cd my_directory <br>
>echo "Current directory: $PWD" <br>
>
><br>
>$# Create some files <br>
>echo "Creating files..." <br>
>touch file1.txt <br>
>touch file2.txt <br>
>echo "Files created." <br>
>
><br>
>$# List the files in the current directory <br>
>echo "Files in the current directory:" <br>
>ls <br>
>
><br>
>$# Move one level up <br>
>echo "Moving one level up..." <br>
>cd .. <br>
> echo "Current directory: $PWD" <br>
>
><br>
>$# Remove the new directory and its contents <br>
>echo "Removing the new directory..." <br>
>rm -rf my_directory <br>
>echo "Directory removed." <br>
>
> <br>
>$# List the files in the current directory again <br>
>echo "Files in the current directory:" <br>
>ls <br>

step 3: Run the command sudo chmod +x navigating-linux-filesystem.sh to set execute permission on the file <br>

step 4: Run your script using this command `./navigating-linux-filesystem.sh`
<br>

![Alt text](<../Project 5/Image/9. navigating-linux.png>)
<br>


## File Operations and Sorting

In this lesson, we will be writing a simple shell script that focuses on File Operations and Sorting.
<br>
This script creates three files (file1.txt, file2.txt, and file3.txt), displays the files in their current order, sorts them
alphabetically, saves the sorted files in sorted_files.txt, displays the sorted files, removes the original files, renames the
sorted file to sorted_files_sorted_alphabetically.txt, and finally displays the contents of the final sorted file.
<br>

Lets proceed using the steps below: <br>
step 1: Open your terminal and create a file called sorting.sh using the command `touch sorting.sh` <br>

step 2: Copy and paste the code block below into the file: <br>
>#!/bin/bash <br>
>
> <br>
>$# Create three files <br>
>echo "Creating files..." <br>
>echo "This is file3." > file3.txt <br>
>echo "This is file1." > file1.txt <br>
>echo "This is file2." > file2.txt <br>
>echo "Files created." <br>
> 
><br>
>$# Display the files in their current order <br>
>echo "Files in their current order:" <br>
>ls <br>
>
> <br>
>$# Sort the files alphabetically <br>
>echo "Sorting files alphabetically..." <br>
>ls | sort > sorted_files.txt <br>
>echo "Files sorted." <br>
>
> <br>
>$# Display the sorted files <br>
>echo "Sorted files:" <br>
>cat sorted_files.txt <br>
>
> <br>
>$# Remove the original files <br>
>echo "Removing original files..." <br>
>rm file1.txt file2.txt file3.txt <br>
>echo "Original files removed." <br>
>
> <br>
>$# Rename the sorted file to a more descriptive name <br>
>echo "Renaming sorted file..." <br>
>mv sorted_files.txt sorted_files_sorted_alphabetically.txt <br>
>echo "File renamed." <br>
>
> <br>
>$# Display the final sorted file <br>
>echo "Final sorted file:" <br>
>cat sorted_files_sorted_alphabetically.txt <br>

<br>

step 3: Set execute permission on sorting.sh using this command `sudo chmod +x sorting.sh`
<br>

step 4: Run your script using the command `./sorting.sh`
<br>
<br>

![Alt text](<../Project 5/Image/10. sorting files.png>)
<br>

## Working with Numbers and Calculations

This script defines two variables num1 and num2 with numeric values, performs basic arithmetic operations (addition,
subtraction, multiplication, division, and modulus), and displays the results. It also performs more complex calculations
such as raising num1 to the power of 2 and calculating the square root of num2, and displays those results as well.
Lets proceed by following the steps below:

step 1: On your terminal create a file called calculations.sh using the command `touch calculations.sh`
step 2: Copy and paste the code block below: <br>
>#!/bin/bash <br>
>
> <br>
>$# Define two variables with numeric values <br>
>num1=10 <br>
>num2=5 <br>
>
> <br>
>$# Perform basic arithmetic operations <br>
>sum=$((num1 + num2)) <br>
>difference=$((num1 - num2)) <br>
>product=$((num1 * num2)) <br>
>quotient=$((num1 / num2)) <br>
>remainder=$((num1 % num2)) <br>
>
> <br>
>$# Display the results <br>
>echo "Number 1: $num1" <br>
>echo "Number 2: $num2" <br>
>echo "Sum: $sum" <br>
>echo "Difference: $difference" <br>
>echo "Product: $product" <br>
>echo "Quotient: $quotient" <br>
>echo "Remainder: $remainder" <br>
>
> <br>
>$# Perform some more complex calculations <br>
>power_of_2=$((num1 ** 2)) <br>
>square_root=$(echo "sqrt($num2)" | bc) <br>
>
> <br>
>$# Display the results <br>
>echo "Number 1 raised to the power of 2: $power_of_2" <br>
>echo "Square root of number 2: $square_root" <br>
>
><br>

<br>

step 3: Set execute permission on calculations.sh using the command: `sudo chmod +x calculations.sh`
<br>

step 4: Run your script using this command: `./calculations.sh`
<br>

![Alt text](<../Project 5/Image/11. calculations.png>)

<br>

# File Backup and Timestamping

This shell scripting example is focused on file backup and timestamp. As a DevOps Engineer backing up databases and
other storage devices is one of the most common task you get to carryout. <br>

This script defines the source directory and backup directory paths. It then creates a timestamp using the current date
and time, and creates a backup directory with the timestamp appended to its name. The script then copies all files from
the source directory to the backup directory using the cp command with the -r option for recursive copying. Finally, it
displays a message indicating the completion of the backup process and shows the path of the backup directory with
the timestamp.


Lets proceed using the steps bellow:<br>

step 1: On your terminal open a file backup.sh using the command `touch backup.sh` <br>

step 2: Copy and paste the code block below into the file:<br>

>#!/bin/bash <br>
>
> <br>
>$# Define the source directory and backup directory <br>
>source_dir="/path/to/source_directory" <br>
>backup_dir="/path/to/backup_directory" <br>
>
> <br>
>$# Create a timestamp with the current date and time <br>
>timestamp=$(date +"%Y%m%d%H%M%S") <br>
>
> <br>
>$# Create a backup directory with the timestamp <br>
>backup_dir_with_timestamp="$backup_dir/backup_$timestamp" <br>
>
> <br>
>$# Create the backup directory <br>
>mkdir -p "$backup_dir_with_timestamp" <br>
>
> <br>
>$# Copy all files from the source directory to the backup directory <br>
>cp -r "$source_dir"/* "$backup_dir_with_timestamp" <br>
>
> <br>
>$# Display a message indicating the backup process is complete <br>
>echo "Backup completed. Files copied to: $backup_dir_with_timestamp" <br>
<br>

step 3: Set execute permission on backup.sh using this command `sudo chmod +x backup.sh`
<br>
step 4: Run your script using the command: `./backup.sh`
<br>

![Alt text](<../Project 5/Image/12. file backup.png>)

