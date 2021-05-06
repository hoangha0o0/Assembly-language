# Lab03, Assignment 4d
.data
	i: .word 1
	j: .word 1
	n: .word 2
	m: .word 3
.text
	la $t0, i
	lw $s1, ($t0)
	la $t0, j
	lw $s2, ($t0)
	la $t0, n		# t0 = address of n
	lw $s3, ($t0)		# s3 = n
	la $t0, m		# t0 = address of m
	lw $s4, ($t0)		# s4 = m
	add $t1, $zero, $zero	# x = t1 = 0
	add $t2, $zero, $zero 	# y = t2 = 0
	add $t3, $zero, $zero	# z = t3 = 0
startif: 
	add $s5, $s1, $s2	# s5 = i+j
	add $s6, $s3, $s4	# s6 = n+m
	slt $t0, $s6, $s5 	# $t0 = 1 if n+m < i+j else $t0 = 0
	beq $t0, $zero, else    # if $t0 == 0 then jump to else
	addi $t1, $t1, 1 	# x = $t1          ==> x = x+1
	add $t3, $zero, 1	# z = $t3	   ==> z = 1
	j endif
else:
	addi $t2, $t2, -1	# y = $t2	   ==> y = y-1
	add $t3, $t3, $t3	# z = $t3	   ==> z = 2*z
endif:
