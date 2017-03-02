# Erik Zapata, Sean Gamble

.data
#data stuff will go here
base: .asciiz "Please enter the base: "
value: .asciiz "How many values?: "
strq: .asciiz "input string: "
# address for strings
str_input: .space 9

.text
# skip sub routines and skip straight to the start
# of the program
j start

#convert to decimal num, take each char in decimal and multiply by base^places
# 30 - 39 are numbers 0-9
# 61 - some number is a through z
.globl get_num
get_num:
	#get null term by loopin a0 str, a1 base
	li $t2, 0
	li $v0, 0
	addi  $t0, $a0, 0
	
	calc_length:
	lbu $t1, 0($t0)
	# if the current char is either 00(null terminator) or
	# 0a (the newline character)
	beq $t1, $zero, exit_calc_length
	beq $t1, 10, exit_calc_length
	
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	j calc_length
	
	exit_calc_length:
	#after calc_length is compelte, $t0 is pointing at either a null temrinator
	#or a carriage return
	# setting it back a character so it points
	# to the least significant character
	addi $t0, $t0, -1
	addi $t3, $t2, 0
	#t0 has address of last char, t2 has number of chars
	
	#loop sub 48 from numbers(>60), 87 from letters(<60)
	get_next_char_value:
	#loop while theres still chars left
	beq $t2,$zero, l3d
	addi $t2, $t2, -1
	#load current char
	lb $t1, ($t0)
	
	# lower case letters start at 97
	bge $t1, 97, if1
	addi $t1, $t1, -48 
	
	j if2
	#else its letter, -61
	if1:
	addi $t1, $t1, -97 
	#get place by max-cur
	if2:
	sub $t4, $t3, $t2
	#for place, multiply a1 by itself, if 0 result=1
	#t1 has number, t2 has place from left, t3 has total places from left, t4 has difference of t2/t3
	#a1 has base
	#bnez $t4, l3
	#powering base
	li $t5, 1
	
	# what in tarnation
	# a1 is the base
	l4:
	beqz $t4,l4d
	addi $t4, $t4, -1
	mult  $t5, $a1
	mflo $t5
	j l4
	l4d:
	mult $t1, $t5
	mflo $t5
	add $v0, $v0, $t5
	j get_next_char_value
	l3d:
	jr $ra


ask_for_value:
# outputs the string asking for how many values
li $v0, 4
la $a0, value
syscall
#accepts the int input for value, save it
li $v0, 5
syscall
add $t0,$v0, $zero
#print asking for base
li $v0, 4
la $a0, base
syscall
#get int input for base
li $v0, 5
syscall
#put value in return and return
# v1 is the number of values, v0 is the base
add $v1,$t0, $zero
jr $ra


start:
#get value and base
jal ask_for_value
#in v0/v1 or base/value in t7/t6, store
add $t7,$v0, $zero
add $t6,$v1, $zero
#get values strings, while t6=/=0 get, convert, store
l1:
beqz  $t6, l1d
addi $t6, $t6, -1

#ask for string
li $v0, 4
la $a0, strq
syscall

#get string
li $v0, 8
la $a0, str_input
li $a1, 9
syscall

#load base into a1 and call get num
addi $a1, $t7, 0
jal get_num
add $s0, $s0, $v0

# echoing out the number calculated
li $v0, 1
add $a0, $s0, $zero
syscall

j l1
l1d:
add $v0, $s0, $zero	
