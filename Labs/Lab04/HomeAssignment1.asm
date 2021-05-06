# Lab04, Home Assignment 1
.text
# Check whether $s2 + $s1 is overflow or not
start:
	li $s2, 0x70000000
	li $s1, 0x70000000
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
