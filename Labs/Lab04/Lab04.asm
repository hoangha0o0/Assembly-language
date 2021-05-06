# Lab 04

# Lab04, Assignment 1
# This work only when you comment other exercise
.text
# Check whether $s2 + $s1 is overflow or not
start:
	# li $s2, 0x70000000
	# li $s1, 0x70000000
	li $s2, 0xffffffff
	li $s1, 0xffffffff
	li $t0, 0
	addu $s3, $s2, $s1
	
	xor $t1, $s2, $s1 
	bltz $t1, exit

	slt $t2, $s3, $s1
	bltz $s2, negative
positive:	
	beq $t2, $zero, exit
	# if $s3 < $s1 the result is overflow 
	j overflow
negative:
	bne $t2, $zero, exit
	# if $3 >= $s1 the result is overflow 
	# j overflow
overflow:
	li $t0, 1
exit:

# Lab04, Home Assignment 2
# This work only when you comment other exercise
.text
	li $s0, 0x12345678
	# Extract $t0 =  MSB of $s0 = 12
	andi $t0, $s0, 0xff000000
	srl  $t0, $t0, 24
	# Clear LSB of $s0
	addi $t1, $zero , 0xff
	nor $t1, $t1, $zero
	and $s0, $s0, $t1
	# Set LSB of $s0 (bits from 7 to 0 to 1)
	li $t2, 0xff
	or $s0, $s0, $t2
	# Clear $s0 ($s0 = 0)
	and $s0, $s0, $zero

# Lab04, Home Assignment 3
# This work only when you comment other exercise
.text
	li $s1, 0xff000000
	
	# a. abs $s0, $s1
	sra $t0, $s1, 0x1f 
	xor $s0, $t0, $s1
	subu $s0, $s0, $t0
	
	# b. move $s0, $s1
	add $s0, $s1, $zero
	
	# c. not $s0, $s1
	nor $s0, $s1, $zero
	
	# d. ble $s1, $s2, L
	slt $t0, $s2, $s1
	beq $t0, $zero, L
	j exit
L:
	li $t0, 1
exit:
	li $t0, 2

# Lab04, Home Assignment 4
.text
# Check whether $s2 + $s1 is overflow or not
start:
	li $s2, 0x70000000
	li $s1, 0x70000000
	# li $s2, 0xffffffff
	# li $s1, 0xffffffff
	
	li $t0, 0
	addu $s3, $s2, $s1
	
	xor $t1, $s2, $s1
	bltz $t1, exit
	
	xor $t1, $s3, $s1
	bltz $t1, overflow
	j exit
overflow:
	li $t0, 1
exit:


# Lab04, Home Assignment 5
# This work only when you comment other exercise
.text
# Check whether $s2 + $s1 is overflow or not
start:
	li $s0, 1
	li $s1, 16
	# $s0 = $s0 * 2^$s1
	sllv $s0, $s0, $s1
