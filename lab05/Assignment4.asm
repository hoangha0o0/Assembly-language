# Laboratory Exercise 5, Assignment 4
.data
	string: .space 50
	mess1: .asciiz "Nhap xau:"
	mess2: .asciiz "Do dai la:"
.text
main:
get_string:
	li $v0, 54
	la $a0, mess1
	la $a1, string
	li $a2, 49
	syscall
	
	# li $v0, 4
	# la $a0, string
	# syscall
end_of_get_string:

# result is stored in s0 = string length
get_length:
	la $s1, string # address of string
	add $s0, $zero, $zero # s0 = length of string = 0
	add $t0, $zero, $zero # t0 = i = 0	
check_char:
	add $t1, $t0, $s1
	lb $t2, 0($t1)
	
	beq $t2, $zero, end_of_check_char
	
	addi $s0, $s0, 1
	addi $t0, $t0, 1
	
	j check_char
end_of_check_char:
	subi $t0, $s0, 1
	add $t1, $t0, $s1
	lb $t2, 0($t1)
	bne $t2, 10, end_of_get_length
	subi $s0, $s0, 1 # not count '\n'
end_of_get_length:

print_length:
	li $v0, 56
	la $a0, mess2
	add $a1, $zero, $s0
	syscall	
