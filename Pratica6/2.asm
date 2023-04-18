	.text
	.globl main
	
main:
	li 	$t1, 0xF0000003
	
	sll 	$t2, $t1, 4
	srl 	$t3, $t1, 4
	sra 	$t4, $t1, 4
	
	li	$v0, 10
	syscall
