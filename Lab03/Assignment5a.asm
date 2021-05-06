# Lab03, Assignment 5a
.data
	i: 	.word -1
	A: 	.word 1, 2, 3, 4, 5
	n: 	.word 3
	step:	.word 1
	sum: 	.word 0
.text
	la $t0, i		# t0 = address of i
	lw $s1, ($t0)		# s1 = i
	la $s2, A		# s2 = address of A 
	la $t0, n		# t0 = address of n
	lw $s3, ($t0)		# s3 = n
	la $t0, step		# t0 = address of step
	lw $s4, ($t0)		# s4 = step
	la $t0, sum		# t0 = address of sum
	lw $s5, ($t0)		# s5 = sum
loop:
	add $s1,$s1,$s4 	# i = i + step
	add $t1, $s1, $s1	# t1= 2*i
	add $t1, $t1, $t1	# t1= 4*i
	add $t1, $t1, $s2	# t1= 4*i + address of A
	lw $t0, 0($t1)		# t0= A[i]
	add $s5, $s5, $t0	# sum = sum + A[i]
	slt $t0, $s1, $s3	# t0 = 1 if i < n else t0 = 0
	bne $t0, $zero, loop	# if t0 != 0, jump to loop 
	
