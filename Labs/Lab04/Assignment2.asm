# Lab04, Home Assignment 2
.text
	li $s0, 0x12345678
	# Extract $t0 =  MSB of $s0 = 12
	andi $t0, $s0, 0xff000000
	srl  $t0, $t0, 24
	# Clear LSB of $s0
	addi $t1, $zero , 0xff
	nor $t1, $t1, $zero
	and $s0, $s0, $t1
	# Set LSB of $s0 (bits from 7 to 0 to 1)
	li $t2, 0xff
	or $s0, $s0, $t2
	# Clear $s0 ($s0 = 0)
	and $s0, $s0, $zero