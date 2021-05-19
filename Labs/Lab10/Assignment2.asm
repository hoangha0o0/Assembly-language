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