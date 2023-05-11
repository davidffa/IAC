	.data
minus:	.asciiz "texto em minusculas"
maius:	.space 20

	.text
	.globl main
	
main:
	li	$t0, 0
	la	$a1, minus
	la	$a2, maius
	
wh:
	addu	$t1, $t0, $a1
	addu	$t3, $t0, $a2
	
	lb	$t2, 0($t1)
	
	beqz	$t2, endwh
	beq	$t2, ' ', savechar
	
	addi	$t2, $t2, 'A'
	subi	$t2, $t2, 'a'
	
savechar:
	sb	$t2, 0($t3)
	
	addi	$t0, $t0, 1
	
	j wh
	
endwh:
	li	$v0, 4
	la	$a0, maius
	syscall

	li	$v0, 10
	syscall
