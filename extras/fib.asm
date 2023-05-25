	.data
prompt:	.asciiz "Gerar sequência de fibonacci até que ordem? "

	.text
	.globl main
	
main:
	li	$s0, 0
	
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 5
	syscall
	
	move	$s1, $v0
	
loop:
	beq	$s0, $s1, end
	
	move	$a0, $s0
	jal	fib
	
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	li	$v0, 11
	li	$a0, ' '
	syscall

	addi	$s0, $s0, 1
	
	j	loop

end:	
	li	$v0, 10
	syscall
	
fib:
	beqz	$a0, base_case
	beq	$a0, 1, base_case
	
	addiu	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$a0, 4($sp)
	sw	$s0, 8($sp)
	
	subi	$a0, $a0, 1
	jal	fib
	
	move	$s0, $v0
	
	lw	$a0, 4($sp)
	subi	$a0, $a0, 2
	jal	fib
	
	add	$v0, $v0, $s0
	
	# Restore stack contents
	lw	$ra, 0($sp)
	lw	$s0, 8($sp)
	addiu	$sp, $sp, 12
	
	jr	$ra
	
base_case:
	li	$v0, 1
	jr	$ra