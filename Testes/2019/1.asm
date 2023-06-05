	.data
nums:	.word -2, 3, 6, 4, 8, 126, -131, 17

	.text	
	.globl main
main:
	# $t0 = i
	# $t1 = val
	li	$t0, 0
	la	$s0, nums
for:
	bge	$t0, 8, endfor
	
	sll	$t2, $t0, 2
	addu	$t2, $s0, $t2
	
	lw	$t1, 0($t2)
	
	addi	$t0, $t0, 1 # i++
	
	rem	$t3, $t1, 2
	
	bne	$t3, 0, for
	
	li	$v0, 1
	move	$a0, $t1
	syscall
	
	li	$v0, 11
	li	$a0, ','
	syscall
	
	j	for
	
endfor:
	li	$v0, 10
	syscall
