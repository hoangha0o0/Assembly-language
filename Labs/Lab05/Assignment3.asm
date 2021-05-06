# Laboratory Exercise 5, Assignment 3
.data
	x: .space 50
 	y: .space 50
 	MAX_LEN: .word 21
 	mess1: .asciiz "Enter string y:\n"
 	mess2: .asciiz "\nstring y:\n"
 	mess3: .asciiz "\nPrint copy string:\n"
.text
	lw $s0, MAX_LEN # s0 = maxlen
get_string:
	li $v0, 4
	la $a0, mess1
	syscall

	li $v0, 8
	la $a0, y
	add $a1, $zero, $s0
	syscall
	
	li $v0, 4
	la $a0, mess2
	syscall
	
	li $v0, 4
	la $a0, y
	syscall
end_of_get_string:

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

print_copy_string:
	li $v0, 4
	la $a0, mess3
	syscall

	li $v0, 4
	la $a0, x
	syscall
