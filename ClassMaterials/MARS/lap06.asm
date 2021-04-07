
#-----------------------------------------------------------------------------------------------------------------------------
# Lab 05, Assigment 1
.data 
	A: .space 100 	# array
	input_n: .asciiz "enter n = "
	input_A: .asciiz "enter array A:\n"
	space: .asciiz " "
	end_line: .asciiz "\n"
	result: .asciiz "result = "
.text
main:
	j read_array
after_read_array:
	j mspfx
after_mspfx:
	li $v0, 4
	la $a0, result
	syscall

	addi $v0, $zero, 1
	add $a0, $zero, $v1
	syscall
exit:
	li $v0, 10 # exit
	syscall
end_of_main:


#-----------------------------------------------------------------
#Procedure read_array
# @brief read a list of integers list(A) 
# @param[out] s0 the first address of list(A)
# @param[out] s1 the length of list(A)
#-----------------------------------------------------------------
#Procedure read_array
#function: read a list of integers list(A)
#the base address of this list(A) in $s0 and the number of
#elements is stored in $s1
read_array:
	li $v0, 4
	la $a0, input_n
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0
	
	li $v0, 4
	la $a0, input_A
	syscall
	
	la $s0, A
	li $t0, 0 	# index i
loop_in_read_array:
	beq $t0, $s1, end_of_loop_in_read_array

	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t1, $t1, $s0
	
	li $v0, 5
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	j loop_in_read_array
end_of_loop_in_read_array:
end_of_read_array: j after_read_array


#-----------------------------------------------------------------
#Procedure mspfx
# @brief find the maximum-sum prefix in a list of integers
# @param[in] s0 the base address of this list(A) need to be processed
# @param[in] s1 the number of elements in list(A) 
# @param[out] v0 the length of sub-array of A in which max sum reachs.
# @param[out] v1 the max sum of a certain sub-array
#-----------------------------------------------------------------
#Procedure mspfx
#function: find the maximum-sum prefix in a list of integers
#the base address of this list(A) in $s0 and the number of
#elements is stored in $s1

mspfx:
	add $v0, $zero, $zero # length of max prefix sum
	add $v1, $zero, $zero # max prefix sum
	add $t0, $zero, $zero # index i
	add $t1, $zero, $zero # current sum

loop:
	beq $t0, $s1, end_of_loop
	
	add $t2, $t0, $t0
	add $t2, $t2, $t2
	add $t2, $t2, $s0
	
	lw $t2, 0($t2) 
	
	add $t1, $t1, $t2
	slt $t2, $v1, $t1
	bne $t2, $zero, mdfy
	j inc_id
mdfy:
	addi $t2, $t0, 1 
	add $v0, $zero, $t2
	add $v1, $zero, $t1
inc_id:
	addi $t0, $t0, 1
	j loop
end_of_loop:

end_of_mspfx: j after_mspfx


#-----------------------------------------------------------------------------------------------------------------------------
# Lab 05, Assigment 2
.data
	A: .space 100 	# array
	input_n: .asciiz "enter n = "
	input_A: .asciiz "enter array A:\n"
	result: .asciiz "result: "
	space: .asciiz " "
.text
main:
	j read_array
after_read_array:
	add $s1, $s1, $s1
	add $s1, $s1, $s1
	add $s1, $s1, $s0
	j sort
after_sort:
	li $v0, 4
	la $a0, result
	syscall
	
	j print_result
after_print_result:
exit:
	li $v0, 10 # exit
	syscall
end_of_main:

#-----------------------------------------------------------------
#Procedure read_array
# @brief read a list of integers list(A) 
# @param[out] s0 the first address of list(A)
# @param[out] s1 the length of list(A)
#-----------------------------------------------------------------
#Procedure read_array
#function: read a list of integers list(A)
#the base address of this list(A) in $s0 and the number of
#elements is stored in $s1
read_array:
	li $v0, 4
	la $a0, input_n
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0
	
	li $v0, 4
	la $a0, input_A
	syscall
	
	la $s0, A
	li $t0, 0 	# index i
loop_in_read_array:
	beq $t0, $s1, end_of_loop_in_read_array

	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t1, $t1, $s0
	
	li $v0, 5
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	j loop_in_read_array
end_of_loop_in_read_array:
end_of_read_array: j after_read_array

#-----------------------------------------------------------------
#Procedure print_result
# @brief print array
# @param[in] s0 the base address of this list(A) need to be processed
# @param[in] s1 the end address of A + type of(A) 
# @param[in] space 
#-----------------------------------------------------------------
#Procedure print_result
#function: print list of integer A
#the base address of this list(A) in $s0 and the end address of A + type of(A)  is stored in $s1
print_result:
	li $t0, 0	# index i
loop_in:
	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t1, $s0, $t1
	
	beq $t1, $s1, end_of_loop_in
	
	li $v0, 1
	lw $a0, 0($t1)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 1
	j loop_in
end_of_loop_in:
end_of_print_result: j after_print_result

#-----------------------------------------------------------------
#Procedure sort
# @brief sort array
# @param[in] s0 the base address of this list(A) need to be processed
# @param[in] s1 the end address of A + type of(A) 
#-----------------------------------------------------------------
#Procedure sort
#function: sort list of integer A
#the base address of this list(A) in $s0 and the end address of A + type of(A)  is stored in $s1
sort:
	add $a0, $zero, $s0 # the base address of A
	add $a1, $zero, $s1 # the end address of A + type of(A)
	addi $a1, $a1, -4 # the end of address
loop_in_sort:
	beq $a0, $a1, end_of_sort
	j max
after_max:
	lw $t0, 0($a1)
	sw $t0, 0($v0)
	sw $v1, 0($a1)	
	addi $a1, $a1, -4
	j loop_in_sort	
end_of_sort: j after_sort

#-----------------------------------------------------------------
#Procedure max
# @brief find the value and address of max element in the list
# @param[in] a0 the base address of this list(A) need to be processed
# @param[in] a1 the end address of A + type of(A) 
# @param[out] v0 the address of A in which max value reachs.
# @param[out] v1 the max value of a array
#-----------------------------------------------------------------
#Procedure max
#function: find the value and address of max element in the list A
#the base address of this list(A) in $a0 and the end address of A + type of(A)  is stored in $a1
max:
	addi $v0, $a0, 0	# init max pointer to first element
	lw $v1, 0($v0)		# init max value to first value
	addi $t0, $a0, 0	# init current pointer
loop_in_max:
	beq $t0, $a1, end_of_max
	add $t0, $t0, 4
	lw $t1, 0($t0)
	slt $t2, $v1, $t1
	beq $t2, $zero, loop_in_max
	addi $v1, $t1, 0
	addi $v0, $t0, 0
	j loop_in_max	 
end_of_max: j after_max


#-----------------------------------------------------------------------------------------------------------------------------
# Lab 05, Assigment 3
.data
	A: .space 100 	# array
	input_n: .asciiz "enter n = "
	input_A: .asciiz "enter array A:\n"
	result: .asciiz "result: "
	space: .asciiz " "
.text
main:
	j read_array
after_read_array:
	add $s1, $s1, $s1
	add $s1, $s1, $s1
	add $s1, $s1, $s0
	j sort
after_sort:
	li $v0, 4
	la $a0, result
	syscall
	
	j print_result
after_print_result:
exit:
	li $v0, 10 # exit
	syscall
end_of_main:

#-----------------------------------------------------------------
#Procedure read_array
# @brief read a list of integers list(A) 
# @param[out] s0 the first address of list(A)
# @param[out] s1 the length of list(A)
#-----------------------------------------------------------------
#Procedure read_array
#function: read a list of integers list(A)
#the base address of this list(A) in $s0 and the number of
#elements is stored in $s1
read_array:
	li $v0, 4
	la $a0, input_n
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0
	
	li $v0, 4
	la $a0, input_A
	syscall
	
	la $s0, A
	li $t0, 0 	# index i
loop_in_read_array:
	beq $t0, $s1, end_of_loop_in_read_array

	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t1, $t1, $s0
	
	li $v0, 5
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	j loop_in_read_array
end_of_loop_in_read_array:
end_of_read_array: j after_read_array

#-----------------------------------------------------------------
#Procedure print_result
# @brief print array
# @param[in] s0 the base address of this list(A) need to be processed
# @param[in] s1 the end address of A + type of(A) 
# @param[in] space 
#-----------------------------------------------------------------
#Procedure print_result
#function: print list of integer A
#the base address of this list(A) in $s0 and the end address of A + type of(A)  is stored in $s1
print_result:
	li $t0, 0	# index i
loop_in:
	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t1, $s0, $t1
	
	beq $t1, $s1, end_of_loop_in
	
	li $v0, 1
	lw $a0, 0($t1)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 1
	j loop_in
end_of_loop_in:
end_of_print_result: j after_print_result

#-----------------------------------------------------------------
#Procedure sort
# @brief sort array
# @param[in] s0 the base address of this list(A) need to be processed
# @param[in] s1 the end address of A + type of(A) 
#-----------------------------------------------------------------
#Procedure sort
#function: sort list of integer A
#the base address of this list(A) in $s0 and the end address of A + type of(A)  is stored in $s1
sort:
	add $a0, $zero, $s0 	# init point of first loop = the base address of A
first_loop_in_sort:
	beq $a0, $s1, end_of_first_loop_in_sort
	addi $a1, $a0, 4
	second_loop_in_sort:
		beq $a1, $s1, end_of_second_loop_in_sort
		lw $t0, 0($a0)
		lw $t1, 0($a1)
		slt $t2, $t1, $t0
		beq $t2, $zero, inc_pointer
		addi $a2, $a0, 0
		addi $a3, $a1, 0
		j swap
	after_swap:
	inc_pointer:
		addi $a1, $a1, 4
	end_of_second_loop_in_sort:
	addi $a0, $a0, 4
end_of_first_loop_in_sort:

end_of_sort: j after_sort

#-----------------------------------------------------------------
#Procedure swap
# @brief swap value in 2 address
# @param[in] a2 address1 
# @param[in] a3 address2 
# @param[out] a2 with value of a3
# @param[out] a3 with value of a2
# NOTE: value of t6, t7 will be changed 
#-----------------------------------------------------------------
#Procedure max
#function: wap value in 2 address 
#first address is stored in a2 and another is stored in a3
swap:
	lw $t6, 0($a2)
	lw $t7, 0($a3)
	sw $t7, 0($a2)
	sw $t6, 0($a3)
end_of_swap: j after_swap

