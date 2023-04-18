	.text
	.globl main
	
main:
	li 	$t1, 0xFF
	li 	$t0, 27 # 30 - 3
	li 	$s0, 7
	
	# Imprime os primeiros 2 bits em octal
	andi 	$t2, $t1, 3
	srl 	$t3, $t2, 30
	
	li 	$v0, 1
	move 	$a0, $t3
	syscall
	
	li 	$v0, 11
	li 	$a0, ' '
	syscall
	
	# A partir daqui já é possível fazer grupos de 3 (27 % 3 = 0)
	
	# for (int i = 27; i >= 0; i -= 3)
	# $t0 = i
loop:
	blt 	$t0, $zero, exit
	
	sllv 	$t4, $s0, $t0
	
	and 	$t2, $t1, $t4
	srlv 	$t3, $t2, $t0
	
	li 	$v0, 1
	move 	$a0, $t3
	syscall
	
	li 	$v0, 11
	li 	$a0, ' '
	syscall
	
	subi 	$t0, $t0, 3
	
	j loop
		
exit:
	li	$v0, 10
	syscall
	
