# Lab10

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


#----------------------------------------------------------------------------------------
# Lab10, Assignment 2
.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
main:
	li $k0, MONITOR_SCREEN
# |
	li $t0, WHITE
	
	sw $t0, 68($k0)
	sw $t0, 72($k0)
	
	sw $t0, 104($k0)
	sw $t0, 100($k0)
	
	sw $t0, 136($k0)
	sw $t0, 132($k0)
	
	sw $t0, 168($k0)
	sw $t0, 164($k0)
# -
	li $t0, RED
	
	sw $t0, 108($k0)
	sw $t0, 112($k0)
	
	sw $t0, 140($k0)
	sw $t0, 144($k0)
# |
	li $t0, WHITE
	
	sw $t0, 84($k0)
	sw $t0, 88($k0)
	
	sw $t0, 120($k0)
	sw $t0, 116($k0)
	
	sw $t0, 152($k0)
	sw $t0, 148($k0)
	
	sw $t0, 184($k0)
	sw $t0, 180($k0)
exit:
	li $v0, 10
	syscall
endmain:


#----------------------------------------------------------------------------------------
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


#----------------------------------------------------------------------------------------
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

