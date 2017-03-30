# Erik Zapata, Sean Gamble

.data
#data stuff will go here
value: .asciiz "What is the value?\n"
good: .asciiz "It is a binary palindrome.\n"
bad: .asciiz "It is not a binary palindrome.\n"
new: .asciiz "\n"
binpat: .asciiz "Binary pattern:"
.text
# skip sub routines and skip straight to the start
# of the program
j start


.globl	binary_palindrome


start:
	#ask and get value
	li $v0, 4
	la $a0, value
	syscall
	#accepts the int input for value, save it
	li $v0, 5
	syscall
	#load
	add $a0, $v0, $zero
	add $a1, $zero, $zero
	#call recursive
	jal binary_palindrome
	#print num
	add $t0, $v0, $zero
	add $t1, $a0, $zero
	la $a0, binpat
	li $v0, 4
	syscall
	add $a0, $t1, $zero
	li $v0, 35
	syscall
	#print newline
	la $a0, new
	li $v0, 4
	syscall
	#print result
	beqz $t0, notit
	li $v0, 4
	la $a0, good
	syscall
	j finish
	notit:
	li $v0, 4
	la $a0, bad
	syscall
	finish:
	#exit
	li $v0, 10
	syscall
	
binary_palindrome:
	#save ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#check i vs 31-i if not equal return 0, if equal call lower increase t0 
	#shift left 31-i for rightmost, shift left i for 2nd
	#if i=16 return 1 up
	addi $t0, $zero, 16
	beq $a1, $t0, done
	#get left in t0
	sllv  $t0, $a0, $a1
	li $t2, 31
	srlv $t0, $t0, $t2
	#get right in t3
	#t1=31-i
	sub $t1, $t2, $a1
	sllv $t3, $a0, $t1
	srlv $t3, $t3, $t2 
	beq $t0, $t3, eql
	
	neql:
	li $v0, 0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	eql:
	addi $a1, $a1, 1
	jal binary_palindrome
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	done:
	li $v0, 1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra