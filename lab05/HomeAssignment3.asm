# Laboratory Exercise 5, Home Assignment 3
.data
	string: .space 50
	mess1: .asciiz "Nhap xau:"
	mess2: .asciiz "Do dai la:"
.text
main:
get_string:
	li $v0, 8
	la $a0, string
	li $a1, 49
	syscall
	# li $v0, 4
	# syscall
end_of_get_string:

get_length:
	add $s0, $zero, $zero # s0 = length of string = 0
	add $t0, $zero, $zero # t0 = i = 0	
check_char:
	add $t1, $t0, $a0
	lb $t2, 0($t1)
	
	beq $t2, $zero, end_of_check_char
	
	addi $s0, $s0, 1
	addi $t0, $t0, 1
	
	j check_char
end_of_check_char:
	subi $s0, $s0, 1
end_of_get_length:

print_length:
	li $v0, 1
	add $a0, $s0, $zero
	syscall	
