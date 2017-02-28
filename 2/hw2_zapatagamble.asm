# Erik Zapata, Sean Gamble

.data
#data stuff will go here
base: .asciiz "Please enter the base: "
value: .asciiz "Please enter a value: "
# input string plus the new line and null terminator
str_input: .space 8

.text
# skip sub routines and skip straight to the start
# of the program
j start

.globl get_num
get_num:
#does something here
li $v0, 1
syscall
jr $ra

ask_for_value:
# outputs the string asking for a number
li $v0, 4
la $a0, value
syscall

#accepts the input, which is a string
li $v0, 8
# max number of characters
# 8 max characters + 1 for the '\n'
la $a0, str_input
li $a1, 10
syscall

jr $ra

newline:
#prints a newline
li $a0, 10
li $v0, 11
syscall
jr $ra

print_input:
li $v0, 4
la $a0, str_input
syscall
jr $ra

start:
jal ask_for_value
jal print_input
