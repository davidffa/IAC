	.text
	.globl main
	
main:
	li 	$t1, 0x00014
	li 	$t0, 28
	li 	$s0, 0xF
	
	# for (int i = 28; i >= 0; i -= 4)
	# $t0 = i
loop:
	bltz 	$t0, exit
	
	sllv 	$t4, $s0, $t0
	
	and 	$t2, $t1, $t4
	srlv	$t3, $t2, $t0
	
	li	$v0, 34
	move 	$a0, $t3
	syscall
	
	li 	$v0, 11
	li 	$a0, ' '
	syscall
	
	subi 	$t0, $t0, 4
	
	j 	loop
		
exit:
	li	$v0, 10
	syscall
	
