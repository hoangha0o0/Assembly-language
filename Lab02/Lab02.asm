# Laboratory Exercise 2
.data
	X: .word 5 
	Y: .word -1
	Z: .word 
.text

# Assignment 1
	addi $s0, $zero, 0x2110003d 
	# The value of immediate operand is 32-bit, so this instruction above is psuedo code. Instead, the machine execute 3 instruction
	# lui $1, 0x2110
	# ori $1, $1, 0x3d
	# add $16, $0, $1
	
	add $s0, $zero, $0

# Assignment 2
	# NOTE: all the result in the comment are what I observe when run this assigment in the seperated file

	# pc = 0x00400000, $s0 = 0  
	lui $s0, 0x2110
	# pc = 0x00400004, $s1 = 0x21100000
	ori $s0, $s0, 0x3d
	# pc = 0x0040008, $s1 = 0x2110003d
	
	# Code of instruction in the text segnebt is the same as the value of data segment when i choose .text mode

# Assignment 3
	# NOTE: all the result in the comment are what I observe when run this assigment in the seperated file

	li $s0, 0x2110003d
	# This instruction above is psuedo code, and the value of immediate operand is 32-bit, the machine execute 3 instructions below instead
	# lui $1, 0x2110
	# ori $16, $1, 0x3d
	
	li $s1, 0x2
	# This instruction above is psuedo code, the inmediate value is small, the machine execute a instruction below instead:
	# add $17, $0, 0x2

# Assignment 4
	# NOTE: all the result in the comment are what I observe when run this assigment in the seperated file

	# Assign X, Y
	addi $t1, $zero, 5 		# X = $t1 = 0x00000005
	addi $t2, $zero, -1		# Y = $t2 = 0xffffffff
	# Expression Z = 2X + Y
	add $s0, $t1, $t1		# $s0 = $t1 + $t1 = X + X = 2X = 0x0000000a
	add $s0, $s0, $t2		#  $s0 = $s0 + $t2 = 2X + Y = 0x00000009
	
	# After executing the program, the result is true
	
	# the code of the first instruction add addi $t1, $zero, 5  is 0x20090005 = 
	# 0010 00|00 000|0 1001| 0000 0000 00000 0101 
	# Hence the format of I-type is true
	
	# the code of the third instruction add $s0, $t1, $t1 is 0x01298020 = 
	# 0000 00|01 001|0 1001| 1000 0|000 00010 0000 
	# Hence the format of R-type is true
	
# Assignment 5
	# NOTE: all the result in the comment are what I observe when run this assigment in the seperated file
	
	# Assign X, Y
 	addi $t1, $zero, 4 		# X = $t1 = 4
 	addi $t2, $zero, 5 		# Y = $t2 = 5
 	# Expression Z = 3*XY
	mul $s0, $t1, $t2 		# HI-LO = $t1 * $t2 = X * Y ; $s0 = LO = 0x14
 	mul $s0, $s0, 3 		# LO = $s0 = $s0 * 3 = 3 * X * Y = 0x3c
 	# Z' = Z
 	mflo $s1			# $s1 = LO = 0x3c
 	
 # Assignment 6
 	# NOTE: all the result in the comment are what I observe when run this assigment in the seperated file
 	
 	# Load X, Y to registers
 	la $t8, X # Get the address of X in Data Segment
 	la $t9, Y # Get the address of Y in Data Segment
 	# a instruction la is translated into 2 instructions lui, and ori
 	# the value of immediate operand lui is the upper part of the address of variable
 	# the value of immediate operand ori is the lower part of the address of variable   
 	
 	lw $t1, 0($t8) # $t1 = X = 0x00000101
 	lw $t2, 0($t9) # $t2 = Y = 0xffffSffff
 	
 	# Calcuate the expression Z = 2X + Y with registers only
 	add $s0, $t1, $t1 # $s0 = $t1 + $t1 = X + X = 2X
 	add $s0, $s0, $t2 # $s0 = $s0 + $t2 = 2X + Y
 	# Store result from register to variable Z
 	la $t7, Z # Get the address of Z in Data Segment
 	sw $s0, 0($t7) # Z = $s0 = 2X + Y 
 	