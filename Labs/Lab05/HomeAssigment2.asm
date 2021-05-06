# Laboratory Exercise 5, Home Assignment 2
.data
	x: .space 50
 	y: .asciiz "Hello"
.text
strcpy:
	add $s0, $zero, $zero
	la $a0, x
	la $a1, y
L1:
	add $t1, $s0, $a1
	lb $t2, 0($t1)
	
	add $t1, $s0, $a0 
	sb $t2, 0($t1)
	
	beq $t2, $zero, end_of_strcpy 	 
	addi $s0, $s0, 1
	j L1
end_of_strcpy:
	li $v0, 4
	syscall