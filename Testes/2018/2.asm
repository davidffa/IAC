	.data
msg:	.asciiz "\n-->Teste2 de IAC, ex2b<--"
minus:	.asciiz "\nO nr de minusculas e: "

	.text
	.globl main
	
main:
	li	$v0, 4
	la	$a0, msg
	syscall
	
	li	$v0, 4
	la	$a0, minus
	syscall
	
	la	$a0, msg
	jal	nr_minus
	
	move	$a0, $v0
	li	$v0, 1
	syscall

	li	$v0, 10
	syscall
	
nr_minus:
	li	$t0, 0

wh:
	lb	$t1, 0($a0)
	beqz	$t1, end_wh
	
	addiu	$a0, $a0, 1
	
	ble	$t1, 'a', wh
	bge	$t1, 'z', wh
	
	addi	$t0, $t0, 1
	
	j	wh
	
end_wh:
	move	$v0, $t0
	jr	$ra