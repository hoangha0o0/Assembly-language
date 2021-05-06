# Laboratory Exercise 5, Assignment 2
.data
	x: .word 1
	y: .word 3
	mess1: .asciiz "The sum of ("
	mess2: .asciiz ") and ("
	mess3: .asciiz ") is ("
	mess4: .asciiz ")"
.text
	lw $s0, x
	lw $s1, y
	
	add $s2, $s0, $s1
	
	li $v0, 4
	la $a0, mess1
	syscall
	
	li $v0, 1
	add $a0, $s0, $zero
	syscall
	
	li $v0, 4
	la $a0, mess2
	syscall
	
	li $v0, 1
	add $a0, $s1, $zero
	syscall
	
	li $v0, 4
	la $a0, mess3
	syscall	
	
	li $v0, 1
	add $a0, $s2, $zero
	syscall
	
	li $v0, 4
	la $a0, mess4
	syscall