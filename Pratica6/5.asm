# Input: Um número qualquer (em string)
# 	 A base do número
# Output: Imprimir o número em base 10

	.data
buf: 	.space 32
prompt: .asciiz "Escreva um número: "
prompt2: .asciiz "Qual a base do número? "

	.text
	.globl main
	
main:
	la 	$s1, buf
	li 	$s2, 0
	li 	$t1, '9'

	li 	$v0, 4
	la	$a0, prompt
	syscall
	
	li 	$v0, 8
	la	$a0, buf
	li	$a1, 32
	syscall
	
	li 	$v0, 4
	la	$a0, prompt2
	syscall
	
	li	$v0, 5
	syscall
	
	move 	$s0, $v0
	
loop:
	lb 	$t0, 0($s1)
	beq	$t0, '\n', exit
	
	mul 	$s2, $s2, $s0
	
	bgt	$t0, $t1, letter
	
	subi	$t0, $t0, '0'
	
	j	done
letter:
	subi	$t0, $t0, 'A'
	addi	$t0, $t0, 10
	
done:
	add	$s2, $s2, $t0
	addi 	$s1, $s1, 1
	
	j 	loop
	
exit:
	li	$v0, 1
	move	$a0, $s2
	syscall
	
	li 	$v0, 10
	syscall
