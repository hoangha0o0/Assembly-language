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