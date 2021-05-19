# Lab10, Assignment 3
.eqv HEADING 0xffff8010
.eqv MOVING 0xffff8050
.eqv LEAVETRACK 0xffff8020

.eqv WHEREX 0xffff8030
.eqv WHEREY 0xffff8040

.text
main: 
#GO to start point
	jal TRACK
running:
	addi $a0, $zero, 180
	jal ROTATE
	nop
	jal GO
	nop
sleep1: 
	addi $v0,$zero,32
	li $a0,5000
	syscall
	jal UNTRACK
	nop

#GO to Up Right		
	jal TRACK
	nop
goUpRight:
	addi $a0, $zero, 60
	jal ROTATE
	nop
sleep2: 
	addi $v0,$zero,32
	li $a0,5000
	syscall
	jal UNTRACK
	nop
	
#GO to Down
	jal TRACK
	nop
goDown:
	addi $a0, $zero, 180
	jal ROTATE
	nop
sleep3: 
	addi $v0,$zero,32
	li $a0,5000
	syscall
	jal UNTRACK
	nop
	
#GO to Up left
	jal TRACK
	nop
goUpLeft:
	addi $a0, $zero, 300
	jal ROTATE
	nop
sleep4: 
	addi $v0,$zero,32
	li $a0,5000
	syscall
	jal UNTRACK
	nop

#GO to Down
	jal TRACK
	nop
goDown_:
	addi $a0, $zero, 180
	jal ROTATE
	nop
sleep5: 
	addi $v0,$zero,32
	li $a0,5000
	syscall
	jal UNTRACK
	nop	
	jal STOP
exit:
	li $v0, 10
	syscall
endmain:
#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $at, MOVING
	addi $k0, $zero,1
	sb $k0, 0($at)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $at, MOVING
	sb $zero, 0($at)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK: 
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $at, LEAVETRACK
	addi $k0, $zero,1
	sb $k0, 0($at)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $at, LEAVETRACK
	sb $zero, 0($at)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
#		0 : North (up)
#		90: East (right)
#		180: South (down)
#		270: West (left)
#-----------------------------------------------------------
ROTATE: 
	sw $fp, -4($sp)
	sw $ra,-8($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	#------------------ 
	li $at, HEADING
	sw $a0, 0($at)
	nop
	#------------------
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	sw $fp, -4($sp)
	jr $ra
