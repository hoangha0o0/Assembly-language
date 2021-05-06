# Lab03, Assignment 6
.data
	A: 	.word -1, 2, 3, -5
	n: 	.word 4		# the number of elements in array
	mess: 	.asciiz "the element with the largest absolute value in a list of integers is "
.text
	la $s1, A		# s1 = address of A 
	la $t0, n 		# t0 = address of n
	lw $s2, ($t0)		# s2 = n

	add $s3, $zero, $zero 	# i = s3 = 0
	addi $s4, $zero, 1	# step = s4 = 1
	
	lw $t1, ($s1)		# t1 = A[0]
abs:	slt $t0, $t1, $zero	# t0 = 1 if t1 < 0 else t0 = 0
	beq $t0, $zero, end_abs	# if t0 == 0 (t1 >= 0), jump to end_abs
	sub $t1, $zero, $t1	# t1 = -t1
end_abs:
	add $s5, $t1, $zero	# s5 = the element with the largest absolute value in a list of integers
				# initialize s5 = A[0]


loop:
	add $s3, $s3, $s4	# i = i+step
	slt $t0, $s3, $s2	# t0 = 1 if (i < n) else t0 = 0
	beq $t0, $zero, end_loop# if t0 == 0 ( i>= n) end loop 
	add $t0, $s3, $s3	# t0 = 2*i
	add $t0, $t0, $t0	# t0 = 4*i
	add $t0, $s1, $t0	# t0 = address of A[i]
	lw  $t1, ($t0)		# t1 = A[i]
absl:	slt $t0, $t1, $zero	# t0 = 1 if t1 < 0 else t0 = 0
	beq $t0, $zero, end_absl# if t0 == 0 (t1 >= 0), jump to and_abs
	sub $t1, $zero, $t1	# t1 = -t1 = |A[i]|
end_absl:
	slt $t0, $s5, $t1	# t0 = 1 if s5 < |A[i]| else t0 = 0
	beq $t0, $zero, loop	# if t0 != 0 (s5 >= A[i]) , jump to loop
	add $s5, $zero, $t1	# s5 = t1 = |A]i]|
	j loop
end_loop:
	
	
	li $v0, 4           	# service 4 is print null-terminated string
	la $a0, mess		# load address of mess to a0
	syscall
	li $v0, 1		# service 1 to print integer
    	add $a0, $s5, $zero  	# load desired value into argument register $a0, using pseudo-op
    	syscall
