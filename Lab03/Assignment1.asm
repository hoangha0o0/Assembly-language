# Lab03, Assignment 1
.data
	i: .word 1
	j: .word 2
.text
	la $t0, i
	lw $s1, ($t0)
	la $t0, j
	lw $s2, ($t0)
	add $t1, $zero, $zero	# x = t1 = 0
	add $t2, $zero, $zero 	# y = t2 = 0
	add $t3, $zero, $zero	# z = t3 = 0
start: 
	slt $t0, $s2, $s1 	# j = $s2, i = $s1 ==> $t0 = 1 if $s2 < $s1 else $t0 = 0
	bne $t0, $zero, else    # if $t0 != 0 then jump to else
	addi $t1, $t1, 1 	# x = $t1          ==> x = x+1
	add $t3, $zero, 1	# z = $t3	   ==> z = 1
	j endif
else:
	addi $t2, $t2, -1	# y = $t2	   ==> y = y-1
	add $t3, $t3, $t3	# z = $t3	   ==> z = 2*z
endif: