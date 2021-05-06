# Lab04, Home Assignment 5
# This work only when you comment other exercise
.text
# Check whether $s2 + $s1 is overflow or not
start:
	li $s0, 1
	li $s1, 16
	# $s0 = $s0 * 2^$s1
	sllv $s0, $s0, $s1