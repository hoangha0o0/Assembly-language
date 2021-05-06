.data 
	message: .asciiz "Hello World"
.text 
 	la $a0, message 
 	li $v0, 4 
 	syscall 

 	# addi $t1,$zero,0x30000000 # Thanh ghi $t1 = 2
 	# addi $t2,$zero,0x40000000 # Thanh ghi $t2 = 3
 	# add $t0, $t1, $t2 # Thanh ghi t- = $t1 + $t2
 	# addi $24, $0,0x00001001
	# mult $t2, $t1
	
