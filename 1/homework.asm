# Sean Gamble sgamble2 G00892005
# Erik Zapata ezapatar G00988337

# algorithmn
# loop through each number from 1 to n where
# n is the number input by the user
# check each number for divisablilty with n
# if its odd, increment the odd counter
# if its even, increment the even counter

.data
input: .asciiz "Please enter a positive int: "
output: .asciiz "User input: "
print_odd: .asciiz "Number of odd Factors: "
print_even: .asciiz "Number of even Factors: "

.text
# loading print syscall and calling it
# with "input" as the parameter
li $v0, 4
la $a0, input
syscall

# Loading integer input
li $v0, 5
# calling integer input
syscall
# moving from common input/output register to less used
# a1
add $a1, $v0, $zero

li $v0, 4
la $a0, output
syscall
li $v0, 1
add $a0, $a1, $zero
syscall

#new line
li $a0, 10
li $v0, 11
syscall

# getting the counter ready
li $a2, 0
li $s0, 0
li $s1, 0

# brute force just test all numbers from 1 to n for
# divisablity with n
loop:
add $a2, $a2 , 1
#dividing and then setting a3 to the remainder
divu $a1, $a2
mfhi $a3
# if it was not a factor skip to the loop check
bnez $a3, again

# if its even, increment the even register
# or else jump to odd and increment the odd register
and $a3, $a2, 1
bnez $a3, odd
add $s0, $s0, 1
j again
odd:
add $s1, $s1, 1

# keep going until a1 == a2
again:
bne $a1, $a2, loop

# printing the odd factors
la $a0, print_odd
li $v0, 4
syscall
li $v0, 1
add $a0, $s1, $zero
syscall

#new line
li $a0, 10
li $v0, 11
syscall

#printing even factors
la $a0, print_even
li $v0, 4
syscall
li $v0, 1
add $a0, $s0, $zero
syscall
