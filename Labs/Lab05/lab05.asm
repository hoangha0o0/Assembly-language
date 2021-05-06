# Laboratory Exercise 5, Assignment 1
.data
	test: .asciiz "Hello world"
.text
	# check how test string are stored  and packed in memory
	# 0x10010000 => H
	# 0x10010001 => e
	# 0x10010002 => l
	# 0x10010003 => l
	# 0x10010004 => o
	# 0x10010005 => 
	# 0x10010006 => w
	# 0x10010007 => o
	# 0x10010008 => r
	# 0x10010009 => l
	# 0x1001000a => d
	# 0x1001000b => \0
	li $v0, 4
	la $a0, test
	syscall

#--------------------------------------------------------------------------------------------
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

#--------------------------------------------------------------------------------------------
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


#--------------------------------------------------------------------------------------------
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

#--------------------------------------------------------------------------------------------
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

