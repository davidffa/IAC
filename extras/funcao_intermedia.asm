	.text
	.globl main

main:
	li	$s0, 2
	li	$a0, 2
	li	$a1, 3
	li	$a2, 4
	li	$a3, 5
	
	jal	diff_of_sums	
	
	
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	li	$v0, 10
	syscall
	
diff_of_sums:
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$a2, 4($sp)
	sw	$a3, 8($sp)
	sw	$s0, 12($sp)

	jal	sum
	
	move	$s0, $v0
	
	lw	$a0, 4($sp)
	lw	$a1, 8($sp)
	
	jal	sum
	
	sub	$v0, $s0, $v0

	lw	$s0, 12($sp)
	lw	$ra, 0($sp)
	addu	$sp, $sp, 16
	
	jr	$ra
	
sum:
	add	$v0, $a0, $a1
	jr	$ra
	