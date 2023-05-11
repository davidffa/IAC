	.data
maius:	.asciiz "TEXTO EM MAIUSCULAS"
minus:	.space 20

	.text
	.globl main
	
main:
	la	$a1, maius
	la	$a2, minus
	
wh:
	lb	$t0, 0($a1)
	
	beqz	$t0, endwh
	beq	$t0, ' ', savechar
	
	subi	$t0, $t0, 'A'
	addi	$t0, $t0, 'a'
	
savechar:
	sb	$t0, 0($a2)
	
	addiu	$a1, $a1, 1
	addiu	$a2, $a2, 1
	
	j wh
	
endwh:
	li	$v0, 4
	la	$a0, minus
	syscall

	li	$v0, 10
	syscall
