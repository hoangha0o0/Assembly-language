# Lab03, Assignment 1
# To run thí program, you need to comment other programs
.data
	i: .word 1
	j: .word 2
.text
	la $t0, i
	lw $s1, ($t0)
	la $t0, j
	lw $s2, ($t0)
	add $t1, $zero, $zero	# x = t1 = 0
	add $t2, $zero, $zero 	# y = t2 = 0
	add $t3, $zero, $zero	# z = t3 = 0
start: 
	slt $t0, $s2, $s1 	# j = $s2, i = $s1 ==> $t0 = 1 if $s2 < $s1 else $t0 = 0
	bne $t0, $zero, else    # if $t0 != 0 then jump to else
	addi $t1, $t1, 1 	# x = $t1          ==> x = x+1
	add $t3, $zero, 1	# z = $t3	   ==> z = 1
	j endif
else:
	addi $t2, $t2, -1	# y = $t2	   ==> y = y-1
	add $t3, $t3, $t3	# z = $t3	   ==> z = 2*z
endif:

# Lab03, Assignment 2
# To run thí program, you need to comment other programs
.data
	i: 	.word 0
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
	bne $s1, $s3, loop	# if i != n, jump to loop 
	
# Lab03, Assignment 3
# To run thí program, you need to comment other programs
.data 
	test: .word 4
.text
	la $s0, test		# s0 = address of test
	lw $s1, ($s0)  		# s1 = value of test
	beq $s1, 0, case_0	# if s1 == 0, jump to case_0
	beq $s1, 1, case_1	# if s1 == 1, jump to case_1
	beq $s1, 2, case_2	# if s1 == 2, jump to case_2
	j default
case_0:
	addi $s2, $s2, 1	# a = a+1
	j end_switch
case_1:
	addi $s2, $s2, -1	# a = a-1
	j end_switch
case_2:
	add $s3, $s3, $s3	# b = 2*b
	j end_switch
default: 
end_switch:

 # Lab03, Assignment 4a
 # To run thí program, you need to comment other programs
.data
	i: .word 1
	j: .word 1
.text
	la $t0, i
	lw $s1, ($t0)
	la $t0, j
	lw $s2, ($t0)
	add $t1, $zero, $zero	# x = t1 = 0
	add $t2, $zero, $zero 	# y = t2 = 0
	add $t3, $zero, $zero	# z = t3 = 0
startif: 
	slt $t0, $s1, $s2 	# j = $s2, i = $s1 ==> $t0 = 1 if i < j else $t0 = 0
	beq $t0, $zero, else    # if $t0 == 0 then jump to else
	addi $t1, $t1, 1 	# x = $t1          ==> x = x+1
	add $t3, $zero, 1	# z = $t3	   ==> z = 1
	j endif
else:
	addi $t2, $t2, -1	# y = $t2	   ==> y = y-1
	add $t3, $t3, $t3	# z = $t3	   ==> z = 2*z
endif:

# Lab03, Assignment 4b
# To run thí program, you need to comment other programs
.data
	i: .word 1
	j: .word 1
.text
	la $t0, i
	lw $s1, ($t0)
	la $t0, j
	lw $s2, ($t0)
	add $t1, $zero, $zero	# x = t1 = 0
	add $t2, $zero, $zero 	# y = t2 = 0
	add $t3, $zero, $zero	# z = t3 = 0
startif: 
	slt $t0, $s2, $s1 	# $t0 = 1 if j < i else $t0 = 0
	bne $t0, $zero, else    # if $t0 != 0 then jump to else
	addi $t1, $t1, 1 	# x = $t1          ==> x = x+1
	add $t3, $zero, 1	# z = $t3	   ==> z = 1
	j endif
else:
	addi $t2, $t2, -1	# y = $t2	   ==> y = y-1
	add $t3, $t3, $t3	# z = $t3	   ==> z = 2*z
endif:

# Lab03, Assignment 4c
# To run thí program, you need to comment other programs
.data
	i: .word 1
	j: .word 1
.text
	la $t0, i
	lw $s1, ($t0)
	la $t0, j
	lw $s2, ($t0)
	add $t1, $zero, $zero	# x = t1 = 0
	add $t2, $zero, $zero 	# y = t2 = 0
	add $t3, $zero, $zero	# z = t3 = 0
startif: 
	add $s3, $s1, $s2	# s3 = i+j
	slt $t0, $zero, $s3 	# $t0 = 1 if 0 < i+j else $t0 = 0
	bne $t0, $zero, else    # if $t0 != 0 then jump to else
	addi $t1, $t1, 1 	# x = $t1          ==> x = x+1
	add $t3, $zero, 1	# z = $t3	   ==> z = 1
	j endif
else:
	addi $t2, $t2, -1	# y = $t2	   ==> y = y-1
	add $t3, $t3, $t3	# z = $t3	   ==> z = 2*z
endif:

# Lab03, Assignment 4d
# To run thí program, you need to comment other programs
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

# Lab03, Assignment 5a
# To run thí program, you need to comment other programs
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
	
# Lab03, Assignment 5b
# To run thí program, you need to comment other programs
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
	slt $t0, $s3, $s1	# t0 = 1 if n < i else t0 = 0
	beq $t0, $zero, loop	# if t0 == 0, jump to loop 
	
# Lab03, Assignment 5c
# To run thí program, you need to comment other programs
.data
	i: 	.word -1
	A: 	.word 1, 2, 3, 4, 5 -6 -100
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
	slt $t0, $s5, $zero	# t0 = 1 if sum < 0 else t0 = 0
	beq $t0, $zero, loop	# if t0 == 0, jump to loop 
	
# Lab03, Assignment 5d
# To run thí program, you need to comment other programs
.data
	i: 	.word -1
	A: 	.word 0, 0, 1, 2, 3, 4, 5
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
	beq $t0, $zero, loop	# if t0 == 0, jump to loop 
	
# Lab03, Assignment 6
# To run thí program, you need to comment other programs
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
