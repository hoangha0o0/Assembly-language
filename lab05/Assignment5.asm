# Laboratory Exercise 5, Assignment 5
.data
	string: .space 21
	reverse_string: .space 21
	mess1: .asciiz "Enter input string (not exceed 20 characters):\n"
	mess2: .asciiz "\nInput string:\n"
	mess3: .asciiz "\nOutput string:\n"
	MAX_LEN: .word 21
.text
	lw $s0, MAX_LEN # s0 = maxlen

# result is stored in string
get_string:
	li $v0, 4
	la $a0, mess1
	syscall

	li $v0, 8
	la $a0, string
	add $a1, $zero, $s0
	syscall
	
	li $v0, 4
	la $a0, mess2
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
end_of_get_string:

#input : s1 = string
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

# input : s1 = string
# result is stored in s2 = reverse_string
Reverse_string:
	addi $t0, $s0, -1 # t0 = i = strlen(string)
	add $t1, $zero, $zero # t1 = strlen(string) - i = 0 
	la $s1, string
	la $s2, reverse_string
copy:
	beq $t0, -1, end_of_copy
	
	add $t2, $t0, $s1
	lb $t3, 0($t2)
	
	add $t2, $t1, $s2
	sb $t3, 0($t2)
	
	subi $t0, $t0, 1
	addi $t1, $t1, 1
	
	j copy
end_of_copy:
end_of_Reverse_string:

print_reverse_string:
	li $v0, 4
	la $a0, mess3
	syscall

	li $v0, 4
	la $a0, reverse_string
	syscall
