	.data
prompt1: .asciiz "Introduza uma string\n"
result: .asciiz "O número de caracteres numéricos: "
str:	.space 40

	.text
	.globl main

main:
	li	$t0, 0 # i = 0
	li	$t1, 0 # n = 0
	la	$t2, str
	
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
	li	$v0, 8
	la	$a0, str
	li	$a1, 40
	syscall
	
loop:
	addu	$t3, $t2, $t0
	
	lb	$t4, 0($t3)
	
	beqz	$t4, endfor
	
	addi	$t0, $t0, 1 # i++
	
	blt	$t4, '0', loop
	bgt	$t4, '9', loop
	
	addi	$t1, $t1, 1
	
	j loop
	
endfor:
	li	$v0, 4
	la	$a0, result
	syscall
	
	li	$v0, 1
	move	$a0, $t1
	syscall 