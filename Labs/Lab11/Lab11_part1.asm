# Lab 11, assigment 1

#-----------------------------------------------------------------------
#		col 0x1		col 0x2		col 0x4		col 0x8
# row 0x1	0		1		2		3
#		0x11		0x21		0x41		0x81
# row 0x2	4		5		6		7
#		0x12		0x22		0x42		0x82
# row 0x4	8		9		a		b
#		0x14		0x24		0x44		0x84
# row 0x8	c		d		e		f
#		0x18		0x28		0x48		0x88
#-----------------------------------------------------------------------
# command row number of hexadecimal keyboard (bit 0 to 3)
# Eg. assign 0x1, to get key button 0,1,2,3
#     assign 0x2, to get key button 4,5,6,7
# NOTE must reassign value for this address before reading,
# eventhough you only want to scan 1 row
.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
# Lab11, Assignment 1

# receive row and column of the key pressed, 0 if not key pressed
# Eg. equal 0x11, means that key button 0 pressed.
# Eg. equal 0x28, means that key button D pressed.
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.data
	enter: .asciiz "\n"
.text
main:
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t2, OUT_ADDRESS_HEXA_KEYBOARD
polling1:
	li $t3,0x01         
	sb $t3,0($t1)   
	lb $a0,0($t2)   
	bnez $a0,print
polling2:
	li $t3,0x02
	sb $t3,0($t1)
	lb $a0,0($t2)
	bnez $a0,print
polling4:
	li $t3,0x04
	sb $t3,0($t1)
	lb $a0,0($t2)
	bnez $a0,print
polling8:
	li $t3,0x08
	sb $t3,0($t1)
	lb $a0,0($t2)
print:       
	li $v0,34       # print integer (hexa)
	syscall
	la $a0, enter
	li $v0, 4
	syscall
sleep:       
	li $a0,2000      
	li $v0,32	
	syscall       
back_to_polling: 
	j polling1       
	

#--------------------------------------------------------------------------------------------------------------------
# Lab11, Assignment 2

.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.data
Message: .asciiz "Oh my god. Someone's pressed a button.\n"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.text
main:
#---------------------------------------------------------
# Enable interrupts you expect
#---------------------------------------------------------
# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t3,0x80       
	sb $t3,0($t1)   
next:
#---------------------------------------------------------
# No-end loop, main program, to demo the effective of interrupt
#---------------------------------------------------------
Loop:
	nop
	nop
	nop
	nop
	b Loop # Wait for interrupt
end_main:

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 0x80000180
	#--------------------------------------------------------
	# Processing
	#--------------------------------------------------------
IntSR: 
	li $v0, 4
	la $a0, Message
	syscall
	#--------------------------------------------------------
	# Evaluate the return address of main routine
	# epc <= epc + 4
	#--------------------------------------------------------
next_pc:
	mfc0 $at, $14 		# $at <= Coproc0.$14 = Coproc0.epc
	addi $at, $at, 4 	# $at = $at + 4 (next instruction)
	mtc0 $at, $14		# Coproc0.$14 = Coproc0.epc <= $at
return: 
	eret			# Return from exception



#---------------------------------------------------------------------------------------------------------------------
# lab 11, assignment 3
.eqv IN_ADRESS_HEXA_KEYBOARD       0xFFFF0012 
.eqv OUT_ADRESS_HEXA_KEYBOARD      0xFFFF0014 
.data
Message: .asciiz "Key scan code "
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.text
main:
#---------------------------------------------------------
# Enable interrupts you expect
#---------------------------------------------------------
# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
	li $t1,IN_ADRESS_HEXA_KEYBOARD
	li $t3,0x80      # bit 7 = 1 to enable           
	sb $t3,0($t1)
#---------------------------------------------------------
# Loop an print sequence numbers
#---------------------------------------------------------
	xor $s0, $s0, $s0  # count = $s0 = 0
Loop:   
	addi $s0, $s0, 1    # count = count + 1
prn_seq:
	addi $v0,$zero,1    
	add $a0,$s0,$zero  # print auto sequence number 
	syscall
prn_eol:
	addi $v0,$zero,11
	li $a0,'\n'      #print endofline
	syscall
sleep:  
	addi $v0,$zero,32          
	li $a0,300        # sleep 300 ms
	syscall
	nop# WARNING: nop is mandatory here. 
	b Loop           # Loop
end_main:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 0x80000180                
#-------------------------------------------------------
#SAVE the current REG FILE to stack
#-------------------------------------------------------
IntSR:  
	addi $sp,$sp,4    # Save $ra  because we may change it later
	sw $ra,0($sp)
	addi $sp,$sp,4    # Save $ra  because we may change it later
	sw $at,0($sp)
	addi $sp,$sp,4    # Save $ra  because we may change it later
	sw $v0,0($sp)
	addi $sp,$sp,4    # Save $a0, because we may change it later
	sw $a0,0($sp)
	addi $sp,$sp,4    # Save $t1, because we may change it later
	sw $t1,0($sp)
	addi $sp,$sp,4    # Save $t3, because we may change it later
	sw $t3,0($sp)
#--------------------------------------------------------
# Processing
#--------------------------------------------------------
prn_msg:
	addi $v0, $zero,  4     
	la $a0, Message
	syscall
get_cod1:
	li $t1,IN_ADRESS_HEXA_KEYBOARD
	li $t3,0x81      # check row 1 and re-enable bit 7
	sb $t3,0($t1)    # must reassign expected row
	li $t1,OUT_ADRESS_HEXA_KEYBOARD
	lb $a0,0($t1)
	bnez $a0,prn_cod
get_cod2:
	li $t1,IN_ADRESS_HEXA_KEYBOARD	
	li $t3,0x82      # check row 2 and re-enable bit 7
	sb $t3,0($t1)    # must reassign expected row
	li $t1,OUT_ADRESS_HEXA_KEYBOARD
	lb $a0,0($t1)
	bnez $a0,prn_cod
get_cod4:
	li $t1,IN_ADRESS_HEXA_KEYBOARD
	li $t3,0x84      # check row 3 and re-enable bit 7
	sb $t3,0($t1)    # must reassign expected row
	li $t1,OUT_ADRESS_HEXA_KEYBOARD
	lb $a0,0($t1)
	bnez $a0,prn_cod
get_cod8:
	li $t1,IN_ADRESS_HEXA_KEYBOARD
	li $t3,0x88      # check row 4 and re-enable bit 7
	sb $t3,0($t1)    # must reassign expected row
	li $t1,OUT_ADRESS_HEXA_KEYBOARD
	lb $a0,0($t1)
prn_cod:
	li $v0,34          
	syscall
	li $v0,11
	li $a0,'\n'        # print endofline
	syscall
#--------------------------------------------------------
# Evaluate the return address of main routine
# epc  <= epc + 4
#--------------------------------------------------------
next_pc:
	mfc0 $at, $14        # $at <=  Coproc0.$14 = Coproc0.epc
	addi $at, $at, 4     # $at = $at + 4   (next instruction)
	mtc0 $at, $14        # Coproc0.$14 = Coproc0.epc <= $at  
#--------------------------------------------------------
# RESTORE the REG FILE from STACK
#--------------------------------------------------------
restore:
	lw $t3, 0($sp)     # Restore the registers from stack
	addi $sp,$sp,-4
	lw $t1, 0($sp)     # Restore the registers from stack
	addi $sp,$sp,-4
	lw $a0, 0($sp)     # Restore the registers from stack
	addi $sp,$sp,-4
	lw $v0, 0($sp)     # Restore the registers from stack
	addi $sp,$sp,-4        
	lw $ra, 0($sp)     # Restore the registers from stack
	addi $sp,$sp,-4        
return: eret# Return from exception
