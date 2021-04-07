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
