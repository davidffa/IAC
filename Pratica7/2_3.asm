	.data
prompt1: .asciiz "Introduza um numero: "
result:	 .asciiz "\n O numero em binário é: "

	.text
	.globl main
	
main:
	li	$s0, 32
	# n = $t0
	# num = $t1
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
	li	$v0, 5
	syscall
	
	move	$t1, $v0
	
	li	$v0, 4
	la	$a0, result
	syscall
	
loop:
	# for(n=0; n<32;n++)
	bge	$t0, $s0, exit
	
	#print_int10((num & 0x80000000) >> 31);
	andi	$t2, $t1, 0x80000000
	srl	$t2, $t2, 31
	
	li	$v0, 1
	move	$a0, $t2
	syscall
	
        #num = num << 1;
	sll	$t1, $t1, 1
	
	addi 	$t0, $t0, 1
	
	j 	loop
	
	
exit:
	li	$v0, 10
	syscall
