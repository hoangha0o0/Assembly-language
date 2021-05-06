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
