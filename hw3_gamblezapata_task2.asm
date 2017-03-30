# Erik Zapata, Sean Gamble

.data
multiplier: .asciiz "Multiplier? "
multiplicand: .asciiz "Multiplicand? "
	
.text
	#ask for 2 numbers here
	la $a0, multiplier
	jal ask_for_integer
	add $s0, $v0, $zero
	la $a0, multiplicand
	jal ask_for_integer
	add $s1, $v0, $zero
	
	#pass the two numbers into the opt_multiply
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	jal opt_multiply
	
	# print v0
	
	li $v0, 10
	syscall


# helper function. just prints the string that's
# loaded in a0
# does not print a newline character
print:
	li $v0, 4
	syscall
	jr $ra

#prints a new line
new_line:
	li $a0, 10
	li $v0, 11
	syscall
	jr $ra

# prints a0 and asks for an integer	
# returns integer in v0
ask_for_integer:
	# pushing the return address to the stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# we print a0
	jal print
		
	# get inpiut
	li $v0, 5
	syscall
	
	# popping off the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
# needs a0, and a1
# a0 is the multicand
# a1 is the multiplier
.globl opt_multiply
opt_multiply:
	#pushing stuff to the stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	#put stuff here

	#printing the first argument
	li $v0, 1
	syscall

	jal new_line
	
	# printing the second argument
	add $a0, $zero, $s1
	li $v0, 1
	syscall

	#popping the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
