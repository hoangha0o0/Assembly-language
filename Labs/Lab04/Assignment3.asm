# Lab04, Home Assignment 3
.text
	li $s1, 0x01000000
	
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
