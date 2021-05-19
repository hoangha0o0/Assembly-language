
.data 
	MAXN:		.word 20
	MAXL_NAME:	.word 20
	MAXL_MARK:	.word 4
	MAX_MARK:	.float 10
	MIN_MARK: 	.float 0
	
	menu: 		.asciiz "\n------------Menu---------------\n1. Enter number of students\n2. Enter list of students\n3. Set threshold value\n4. List all students who pass the exam\n5. Exit.\nChoose option:\n"
	mess: 		.asciiz "Enter:\n"
	number_of_students: .asciiz "Number of students: "
	name: 		.asciiz "name(MAXL_NAME - 2 = 18 characters): "
	mark: 		.asciiz "mark: "
	not_mark:	.asciiz "WARNING: mark not in range [0, 10].\nEnterAgain.\n"
	threshold_to_pass: .asciiz "Threshold to pass exam: "
	list_of_students_pass: .asciiz "\n\nList of students who pass the exam: \n"
	enter: 		.asciiz "\n"
	dot: 		.asciiz "."
	continue:  	.asciiz "\n-----Press enter to continue------\n"
	
	dummy: 		.asciiz " "
	
	n: 		.word 0
	threshold:	.float 5.0
	names: 		.space 400
	marks: 		.space 80

.text
main:

	# print menu
print_menu:
	li $v0, 4
	la $a0, menu
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, read_n
	beq $v0, 2, read_names_marks
	beq $v0, 3, set_threshold
	beq $v0, 4, print_pass
	beq $v0, 5, end_of_print_menu
end_of_print_menu:
	j end_of_main
	
	# read the number of students and store it in n
read_n:
	la $a0, n
	jal read_number_of_students
	nop
	move $s0, $v0
	
	li $v0, 4
	la $a0, number_of_students
	syscall
	nop
	li $v0, 1
	addi $a0, $s0, 0
	syscall
	nop
	li $v0, 4
	la $a0, enter
	syscall
	nop
end_of_read_n:
	j loop_back_menu
		
	# read information of n students and store them in names and marks
read_names_marks:
	la $s0, names
	la $s1, marks
	lw $s2, n
	li $s3, 0
	for:	
		beq $s3, $s2, end_of_for
		addi $s3, $s3, 1
		
		move $a0, $s0
		move $a1, $s1
		jal read_information_of_1_student 
		nop
		move $a0, $s0 
		move $a1, $s1
		move $s0, $v0
		move $s1, $v1
		jal print_information_of_1_student
		nop
		
		j for
	end_of_for:
end_of_read_names_marks:
	j loop_back_menu

	# read  of mark to pass the exam and store it in threshold
set_threshold:
	la $a0, threshold
	jal read_threshold
	nop
	
	li $v0, 4
	la $a0, threshold_to_pass
	syscall
	nop
	
	li $v0, 2
	#mov.d $f12, $f0
	lwc1 $f12, threshold
	syscall
	nop
end_of_set_threshold:
	j loop_back_menu
	
	# list all students who pass the exam
print_pass:
	la $s0, names
	la $s1, marks
	lw $s2, n
	li $s3, 0
	lw $s4, MAXL_NAME
	lw $s5, MAXL_MARK
	lwc1 $f0, threshold
	
	li $v0, 4
	la $a0, list_of_students_pass
	syscall
	nop
	
	for_1:	
		beq $s3, $s2, end_of_for_1
		
		lwc1 $f1, 0($s1)
		c.le.s $f1, $f0
		bc1t next
			li $v0, 4
			move $a0, $s0
			syscall
		next:	
		addi $s3, $s3, 1	
		add $s0, $s0, $s4 
		add $s1, $s1, $s5
		j for_1
	end_of_for_1:
end_of_print_pass:
	j loop_back_menu

loop_back_menu:
	li $v0, 4
	la $a0, continue
	syscall
	
	li $v0, 8
	la $a0, dummy
	syscall
	
	j print_menu
	
end_of_main:
	# tell the system that the program is done
	li $v0, 10
	syscall

#----------------------------------------------------------------------
#Procedure read_number_of_students: read the number of students and store it n
#param[in] $a0 address of n
#return	   $v0 the value of n
#----------------------------------------------------------------------
read_number_of_students:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------
	move $t0, $a0
	#---
	la $a0, number_of_students
	li $v0, 51
	syscall
	
	addi $v0, $a0, 0
	sw $a0, 0($t0)
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra

#----------------------------------------------------------------------
#Procedure read_threshold: read the threshold of mark (float) to pass the exam and store it in threshold
#param[in] $a0 address of threshold
#return	   $f0 the value of threshold
#----------------------------------------------------------------------
read_threshold:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------
	move $t0, $a0
	#---
	la $a0, threshold_to_pass
	li $v0, 52
	syscall
	
	swc1 $f0, 0($t0)
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
	
#----------------------------------------------------------------------
#Procedure read_information_of_1_student: read name (at most MAXL_NAME-2 characters) and  mark (float) of student
#param[in] $a0 address to store name
#param[in] $a1 address to store mark
#return    $v0 next address to store name
#return    $v1 next address to store mark
#----------------------------------------------------------------------
read_information_of_1_student:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------
	move $t0, $a0
	move $t1, $a1
	#---
	la $a0, name
	addi $a1, $t0, 0
	lw $a2, MAXL_NAME
	li $v0, 54
	syscall
	
	lb $t2, enter
	sub $t3, $a2, 2
	add $t3, $t0, $t3
	sb $t2, 0($t3)
	#---
read_mark_:
	la $a0, mark
	li $v0, 52
	syscall
	
	lwc1 $f1, MIN_MARK
	c.lt.s $f0, $f1
	bc1t not_mark_
	
	lwc1 $f1, MAX_MARK
	c.lt.s $f1, $f0
	bc1t not_mark_
	
	swc1 $f0, 0($t1)
	j end_of_not_mark_
	not_mark_:
		la $a0, not_mark
		li $v0, 4
		syscall
		nop
		
		j read_mark_
	end_of_not_mark_:
end_of_read_mark_:
	#---
	add $v0, $t0, $a2
	lw $t2, MAXL_MARK
	add $v1, $t1, $t2 
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra

#----------------------------------------------------------------------
#Procedure print_information_of_1_student: print name (string) and  mark (float) of a student
#param[in] $a0 address to store name of this student
#param[in] $a1 address to store mark of this student
#----------------------------------------------------------------------
print_information_of_1_student:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	move $t0, $a0
	move $t1, $a1
	#---
	li $v0, 4
	la $a0, name
	syscall
	
	li $v0, 4
	addi $a0, $t0, 0
	syscall
	#---
	li $v0, 4
	la $a0, mark
	syscall
	
	li $v0, 2
	lwc1 $f12, 0($t1)
	syscall
	#---
	li $v0, 4
	la $a0, enter
	syscall
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra

