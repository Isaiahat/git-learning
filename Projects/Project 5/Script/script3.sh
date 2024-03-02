#!/bin/bash

# Input and output name
echo "Enter your name:"
read name
echo "#####################"

# output text to terminal
echo "Hello world"


# output the result of a command into a file
echo "Hello world" > index.txt
echo "txt file created and comment inserted"
echo "#####################"

# pass the result of a file as input to a command
grep "world" < index.txt

# Functions

# Define a function to greet the user
greet() {
    echo "Hello, $1! Nice to meet you."
}

# Call the greet function and pass the name as an argument
greet "John"
