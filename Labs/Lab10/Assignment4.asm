# Lab10, Assignment 4
.eqv KEY_CODE 0xFFFF0004
.eqv KEY_READY 0xFFFF0000

.eqv DISPLAY_CODE 0xFFFF000C
.eqv DISPLAY_READY 0xFFFF0008

.data
	EXIT: .asciiz "exit"

.text
main:
	li $k0, KEY_CODE
	li $k1, KEY_READY
	
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_READY

	li $s2, 0
	li $s4, 4
	la $s3, EXIT
loop:	
	nop
WaitForKey:
	lw $t1, 0($k1) 			# $t1 = [$k1] = KEY_READY
	nop
	beq $t1, $zero, WaitForKey 	# if $t1 == 0 then Polling
	nop
	#-----------------------------------------------------
ReadKey:
	lw $t0, 0($k0) 			# $t0 = [$k0] = KEY_CODE
	nop
	#-----------------------------------------------------
WaitForDis:
	lw $t2, 0($s1) 			# $t2 = [$s1] = DISPLAY_READY
	nop
	beq $t2, $zero, WaitForDis 	# if $t2 == 0 then Polling
	nop
	#-----------------------------------------------------
CheckTerminate:
	beq $s2, $s4, exit
	add $t1, $s2, $s3
	lb $t1, 0($t1) 
	bne $t0, $t1, Reset
	addi $s2, $s2, 1
	j Encypt
Reset:
	li $s2, 0
Encypt:
	add $t0, $t0, 1			# change input key
	#-----------------------------------------------------
ShowKey:
	sw $t0, 0($s0)			# show key
	nop
	#-----------------------------------------------------
	j loop
	nop
exit:
	li $v0, 10
	syscall
endmain:
