# lab07, assignment 1

.text
main:
	li $a0, -45	#load input parameter
	jal abs
	nop
	
	add $a0, $zero , $v0
	li $v0, 10	#terminate
	syscall
endmain:

# function abs
# param a1	the interger need to be gained the absolute value
#return		v0 absolute value

abs:
	sub $v0, $zero, $a1	#put -a0 in v0; in case a0<0
	
	bltz $a0, done	#if a0 < 0 then done
	nop
	add $v0, $a1, $zero	#else put a0 in v0
done:
	jr $ra

# the register $ra change from 0x00000000 to 0x00400008


# lab 07, assignment 2
.text
main:  
	li $a0,3           #load test input
	li $a1,2
	li $a2,1
	jal max            #call max procedure
	nop     
endmain:  

#Procedure max: find the largest of three integers
#param[in]  $a0  integers
#param[in]  $a1  integers
#param[in]  $a2  integers
#return     $v0   the largest value

max: 
	add $v0,$a0,$zero   #copy (a0) in v0; largest so far (v0 = a0 + 0)
	sub $t0,$a1,$v0     #compute t0 = (a1)-(v0)
	bltz $t0,okay        #if (a1)-(v0)<0 then no change
	nop
	add $v0,$a1,$zero   #else (a1) is largest thus far
okay: 
	sub $t0,$a2,$v0     #compute (a2)-(v0)
	bltz $t0,done        #if (a2)-(v0)<0 then no change
	nop
	add $v0,$a2,$zero   #else (a2) is largest overall
done: 
	jr $ra             #return to calling program
# $ra changes from 0x00000000 to 0x00400010


# lab07, assignment 3

.text
	li $s0, 1
	li $s1, 2
push: 
	addi $sp,$sp,-8      #adjust the stack pointer
	sw $s0,4($sp)      #push $s0 to stack
	sw $s1,0($sp)   #push $s1 to stack
work: 
	nop
	nop 
	nop
pop:  
	lw $s0,0($sp)      #pop from stack to $s0
	lw $s1,4($sp)      #pop from stack to $s1
	addi $sp,$sp,8       #adjust the stack pointer



# lab07, assignment 4
.data
Message: .asciiz "Ket qua gia thua la: "

.text
main:	jal WARP

print:	add	$a1, $v0, $zero	# a0 = result from N!
	li	$v0, 56
	la	$a0, Message
	syscall
quit:
	li	$v0, 10		#terminate
	syscall
endmain:

WARP:
	sw	$fp, -4($sp)	#save frame pointer
	addi	$fp, $sp, 0	#new frame pointer point to the top
	addi	$sp, $sp, -8	#adjust stack pointer
	sw	$ra, 0($sp)	#save return address
	
	li	$a0, 3		#local test input N a0 = 3
	jal	FACT		#call fact procedure
	nop
	
	lw	$ra, 0($sp)	#restore return address 
	addi 	$sp, $fp, 0	#return stack pointer 
	lw	$fp, -4($sp)	#return frame pointer
	jr	$ra
wrap_end:

#compute N!
# a0 integer N
#return v0 the largest value

FACT:  
	sw 	$fp,-4($sp)        	#save frame pointer       
	addi 	$fp,$sp,0         	#new frame pointer point to stack’s top
	addi 	$sp,$sp,-12        #allocate space for $fp,$ra,$a0 in stack 
	sw     	$ra,4($sp)	#save return address
	sw     	$a0,0($sp)         #save $a0 register
	slti   	$t0,$a0,2          #if input argument N < 2
	beq    	$t0,$zero,recursive #if it is false ((a0 = N) >=2) 
	nop
	li     	$v0,1              #return the result N!=1
	j	done
	nop
recursive:                                   
	addi   	$a0,$a0,-1         #adjust input argument
	jal    	FACT               #recursive call 
	nop    
	lw     	$v1,0($sp)         #load a0
	mult   	$v1,$v0            #compute the result
	mflo   	$v0
done:  
	lw     	$ra,4($sp)         #restore return address
	lw     	$a0,0($sp)         #restore a0
	addi   	$sp,$fp,0          #restore stack pointer
	lw     	$fp,-4($sp)        #restore frame pointer
	jr     	$ra                #jump to calling
fact_end:
$a0 = 1
$ra
$fp
$a0 = 2
$ra
$fp
$a0 = 3
$ra
$fp


# lab07, assignment 5
.data
Mess: .asciiz "Largest: "
comma: .asciiz ","
mess: .asciiz "\nSmallest: "
.text
main:
li $s0,2
li $s1,6
li $s2,-9
li $s3,3
li $s4,8
li $s5,10
li $s6,7
li $s7,1

add $a2,$zero,$zero
jal max
add $a1,$v0,$zero

li $v0,4
la $a0,Mess
syscall

li $v0,1
add $a0,$a1,$zero
syscall

li $v0,4
la $a0,comma
syscall

li $v0,1
add $a0,$a2,$zero
syscall

nop
jal min

add $a1,$v0,$zero
li $v0,4
la $a0,mess
syscall

li $v0,1
add $a0,$a1,$zero
syscall

li $v0,4
la $a0,comma
syscall

li $v0,1
add $a0,$a2,$zero
syscall

nop
li $v0,10
syscall

max:
add $v0,$s0,$zero
sub $t0,$s1,$v0
bltz $t0,okay1
nop
add $v0,$s1,$zero
li $a2,1

okay1:
sub $t0,$s2,$v0
bltz $t0,okay2
nop
add $v0,$s2,$zero
li $a2,2

okay2:
sub $t0,$s3,$v0
bltz $t0,okay3
nop
add $v0,$s3,$zero
li $a2,3

okay3:
sub $t0,$s4,$v0
bltz $t0,okay4
nop
add $v0,$s4,$zero
li $a2,4

okay4:
sub $t0,$s5,$v0
bltz $t0,okay5
nop
add $v0,$s5,$zero
li $a2,5

okay5:
sub $t0,$s6,$v0
bltz $t0,okay6
nop
add $v0,$s6,$zero
li $a2,6

okay6:
sub $t0,$s6,$v0
bltz $t0,done
nop
add $v0,$s6,$zero
li $a2,7

done:
jr $ra

min:
add $v0,$s0,$zero
sub $t0,$s1,$v0
bgtz $t0,minokay1
nop
add $v0,$s1,$zero
li $a2,1

minokay1:
sub $t0,$s2,$v0
bgtz $t0,minokay2
nop
add $v0,$s2,$zero
li $a2,2

minokay2:
sub $t0,$s3,$v0
bgtz $t0,minokay3
nop
add $v0,$s3,$zero
li $a2,3

minokay3:
sub $t0,$s4,$v0
bgtz $t0,minokay4
nop
add $v0,$s4,$zero
li $a2,4

minokay4:
sub $t0,$s5,$v0
bgtz $t0,minokay5
nop
add $v0,$s5,$zero
li $a2,5

minokay5:
sub $t0,$s6,$v0
bgtz $t0,minokay6
nop
add $v0,$s6,$zero
li $a2,6

minokay6:
sub $t0,$s6,$v0
bgtz $t0,mindone
nop
add $v0,$s6,$zero
li $a2,7

mindone:
jr $ra