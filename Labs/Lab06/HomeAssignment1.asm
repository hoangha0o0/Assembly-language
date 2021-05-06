# Lab 05, Home Assigment 1

.data 
	A: .word -2, 6, -1, 4, -2
.text
main:
	la $a0, A
	li $a1, 5
	j mspfx

continue:
	addi $v0, $zero, 1
	add $a0, $zero, $v1
	syscall
lock: 
	j lock

end_of_main:


#-----------------------------------------------------------------
#Procedure mspfx
# @brief find the maximum-sum prefix in a list of integers
# @param[in] a0 the base address of this list(A) need to be processed
# @param[in] a1 the number of elements in list(A) 
# @param[out] v0 the length of sub-array of A in which max sum reachs.
# @param[out] v1 the max sum of a certain sub-array
#-----------------------------------------------------------------
#Procedure mspfx
#function: find the maximum-sum prefix in a list of integers
#the base address of this list(A) in $a0 and the number of
#elements is stored in a1

mspfx:
	add $v0, $zero, $zero # length of max prefix sum
	add $v1, $zero, $zero # max prefix sum
	add $t0, $zero, $zero # index i
	add $t1, $zero, $zero # current sum

loop:
	beq $t0, $a1, end_of_loop
	
	add $t2, $t0, $t0
	add $t2, $t2, $t2
	add $t2, $t2, $a0
	
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

done: 
	j continue
end_of_mspfx: