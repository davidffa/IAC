	.data
prompt: .asciiz "Introduza uma string: "
result: .asciiz "A string tem comprimento "
buffer: .space 64

	.text
	.globl main
	
main:
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 8
	la	$a0, buffer
	li	$a1, 64
	syscall
	
	la	$a0, buffer
	# OBS: Neste caso vai dar o comprimento da string + 1 por causa do \n
	jal	strlen
	
	move	$s0, $v0
	
	li	$v0, 4
	la	$a0, result
	syscall
	
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	li	$v0, 10
	syscall
	
strlen:
	# n = $v0
	# i = $t0
	li	$t0, 0
	li	$v0, 0
	
wh:
	addu	$t1, $t0, $a0
	
	lb	$t2, 0($t1)
	
	beq	$t2, '\0', endwh
	
	addi 	$v0, $v0, 1
	addi	$t0, $t0, 1
	
	j	wh
endwh:
	jr	$ra