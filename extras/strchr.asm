	.data
prompt:	.asciiz "Escreva uma string: "
prompt2: .asciiz "Qual o caracter? "
result:	.asciiz "\nEndereço do caracter: "
string:	.space 32

	.text
	.globl main

main:
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 8
	la	$a0, string
	li	$a1, 32
	syscall
	
	li	$v0, 4
	la	$a0, prompt2
	syscall
	
	li	$v0, 12
	syscall
	
	move	$a1, $v0
	la	$a0, string
	jal	strchr
	
	move	$s0, $v0
	
	li	$v0, 4
	la	$a0, result
	syscall
	
	li	$v0, 34
	move	$a0, $s0
	syscall
	
	li	$v0, 10
	syscall
	
strchr:
	# $a0 -> char*
	# $a1 -> char
	li	$v0, 0 # NULL
wh:
	lb	$t0, 0($a0)
	beqz	$t0, end_wh
	
	beq	$t0, $a1, char_found
	
	addiu	$a0, $a0, 1
	
	j	wh
end_wh:
	bnez	$a1, endif
	
char_found:
	move	$v0, $a0
endif:
	
	jr	$ra
