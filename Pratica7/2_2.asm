	.data
prompt1: .asciiz "Introduza um numero: "
result:	 .asciiz "\n O numero em hexadecimal é: "

	.text
	.globl main
	
main:
	li	$s0, 8
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
	# for(n=0; n<8;n++)
	bge	$t0, $s0, exit
	
	#print_int16((num & 0xF0000000) >> 28);
	andi	$t2, $t1, 0xF0000000
	srl	$t2, $t2, 28
	
	li	$v0, 34
	move	$a0, $t2
	syscall
	
        #num = num << 4;
	sll	$t1, $t1, 4
	
	addi 	$t0, $t0, 1
	
	j 	loop
	
	
exit:
	li	$v0, 10
	syscall
