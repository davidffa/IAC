	.data
prompt1: .asciiz "Introduza um número\n"
result1: .asciiz "O fatorial do número "
result2: .asciiz " é: "
	
	.text
	.globl main
	
main:
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
	li	$v0, 5
	syscall
	
	move	$s0, $v0
	move	$a0, $s0
	
	jal	factorial
	
	# mover o resultado da função fatorial para s1
	move	$s1, $v0
	
	li	$v0, 4
	la	$a0, result1
	syscall
	
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	li	$v0, 4
	la	$a0, result2
	syscall
	
	li	$v0, 1
	move	$a0, $s1
	syscall
	
	li	$v0, 10
	syscall
	
factorial:
	# i = $t0
	# res = $v0
	move	$t0, $a0
	li	$v0, 1
	
for:
	beqz	$t0, endfor
	
	mul	$v0, $v0, $t0
	
	subi	$t0, $t0, 1
	j	for
	
endfor:
	jr	$ra