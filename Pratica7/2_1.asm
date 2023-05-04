	.data
prompt: .asciiz "Escreva um número: "
output: .asciiz "A soma dos números é "

	.text
	.globl main
	
main:
	li	$t0, 0
	li	$t2, 0
	li	$s0, 5
	
	# i = $t0
	# $t1 = input
	# $t2 = soma
	# for (int i=0; i<5; ++i)
loop:
	bge	$t0, $s0, done
	
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 5
	syscall
	
	move	$t1, $v0
	
	add	$t2, $t2, $t1
	
	addi	$t0, $t0, 1
	
	j 	loop
done:
	li	$v0, 4
	la	$a0, output
	syscall
	
	li	$v0, 1
	move	$a0, $t2
	syscall
	
	li	$v0, 10
	syscall