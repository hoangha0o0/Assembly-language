# Lab03, Assignment 3

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