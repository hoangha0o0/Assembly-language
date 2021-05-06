# Lab03, HomeAssignment 2
.data
A: 	.word		0:12 
.text
	la $s2, A
	addi $s4, $zero, 1
	addi $s3, $zero, 3
loop:
	add $s1,$s1,$s4 	# i = i + step
	add $t1, $s1, $s1	# t1= 2*i
	add $t1, $t1, $t1	# t1= 4*i
	add $t1, $t1, $s2	# t1= 4*i + address of A
	lw $t0, 0($t1)		# t0= A[i]
	add $s5, $s5, $t0	# sum = sum + A[i]
	bne $s1, $s3, loop	# if i != n, jump to loop 
	