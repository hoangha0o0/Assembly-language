# Lab10, Assignment 1
.eqv SEVENSEG_LEFT 0xFFFF0011
.eqv SEVENSEG_RIGHT 0xFFFF0010

.text
main:
# Display 00
	li $a0, 0x3F
	jal SHOW_7SEG_LEFT
	nop
	li $a0, 0x3F
	jal SHOW_7SEG_RIGHT
	nop
# Sleep 1000ms
sleep1: 
	addi $v0,$zero,32
	li $a0,1000
	syscall
# Display 01
next1:
	li $a0, 0x3F
	jal SHOW_7SEG_LEFT
	nop
	li $a0, 0x6
	jal SHOW_7SEG_RIGHT
	nop
# Sleep 1000ms
sleep2: 
	addi $v0,$zero,32
	li $a0,1000
	syscall
# Display 02
next2:
	li $a0, 0x3F
	jal SHOW_7SEG_LEFT
	nop
	li $a0, 0x5B
	jal SHOW_7SEG_RIGHT
	nop
exit:
	li $v0, 10
	syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $t0, SEVENSEG_LEFT
	sb $a0, 0($t0)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: 
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
