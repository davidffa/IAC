	.eqv	SIZE, 8
	
	.data
nums:	.word	-2, 3, -19, 4, 8, 126, -131, 17
msg:	.asciiz "O nr de impares: "

	.text
	.globl main
	
main:
	li	$t0, 0
	li	$t1, 0
	la	$t2, nums
	
for:
	bge	$t0, SIZE, endfor
	
	sll	$t3, $t0, 2
	addu	$t3, $t3, $t2
	lw	$t4, 0($t3)
	
	addi	$t0, $t0, 1
	
	andi	$t5, $t4, 1
	
	bnez	$t5, for
	
	addi	$t1, $t1, 1
	
	j	for
	
endfor:
	li	$v0, 4
	la	$a0, msg
	syscall
	
	li	$v0, 1
	move	$a0, $t1
	syscall
	
	li	$v0, 10
	syscall