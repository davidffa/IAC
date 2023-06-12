	.data
prompt: .asciiz "A raiz inteira é: "
	
	.text

	.globl main
main:
	li	$s0, 0
	li	$s1, 11564
	
	li	$v0, 1
	move	$a0, $s1
	syscall
	
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	move	$a0, $s1
	jal	isqrt
	
	move	$a0, $v0
	li	$v0, 1
	syscall

	li	$v0, 10
	syscall
	
isqrt:
	blt	$a0, 2, base_case

	addiu	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$a0, 4($sp)
	sw	$s0, 8($sp)
	sw	$s1, 12($sp)
	sw	$s2, 16($sp)
	
	li	$s0, 0
	li	$s1, 0
	
	srl	$a0, $a0, 2
	
	jal	isqrt
	
	move	$s0, $v0
	sll	$s0, $s0, 1
	
	addi	$s1, $s0, 1
	
	mul	$s2, $s1, $s1
	
	lw	$a0, 4($sp)
	
	bgt	$s2, $a0, smc_ret
	
lgc_ret:
	move	$v0, $s1
	j	isqrt_ret
	
smc_ret:
	move	$v0, $s0
	
isqrt_ret:
	lw	$ra, 0($sp)
	lw	$a0, 4($sp)
	lw	$s0, 8($sp)
	lw	$s1, 12($sp)
	lw	$s2, 16($sp)
	addiu	$sp, $sp, 20
	
	jr	$ra
	
	
base_case:
	move	$v0, $a0
	jr	$ra