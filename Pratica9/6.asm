	.data
array:	.word 32, 16, 22, 1, 0, 4, 0, -3
result: .asciiz "Array ordenada: "
	
	.text
	.globl main
	
main:
	# n = $s0, numero de elementos da array
	li	$s0, 8

	la	$a0, array
	move	$a1, $s0
	jal	bubble_sort
	
	li	$v0, 4
	la	$a0, result
	syscall
	
	# ptr = $t0
	la	$t0, array
	sll	$s0, $s0, 2
	addu	$t1, $t0, $s0
for_main:
	bge	$t0, $t1, endfor_main
	
	li	$v0, 1
	lw	$a0, 0($t0)
	syscall
	
	li	$v0, 11
	li	$a0, ' '
	syscall
	
	addiu	$t0, $t0, 4
	
	j	for_main
	
endfor_main:
	li	$v0, 10
	syscall
	
bubble_sort:
	# int *array = $a0
	# int n = $a1
	
	# i = $t0
	# *p_aux = $t1
	# houvetroca = $t2
	
	li	$t0, 0
	li	$t1, 0
	li	$t2, 0
	
	sll	$a1, $a1, 2
	addu	$t3, $a0, $a1
	subiu	$t3, $t3, 4
	
dowh:
	li	$t2, 0
	
	move	$t1, $a0
	
for:
	bge	$t1, $t3, endfor
	
	lw	$t4, 0($t1)
	lw	$t5, 4($t1)
	
	ble	$t4, $t5, increment
	
	move	$t6, $t4
	
	sw	$t5, 0($t1)
	sw	$t6, 4($t1)	
	
	li	$t2, 1

increment:
	addiu	$t1, $t1, 4
	
	j	for
	
endfor:
	beq	$t2, 1, dowh
	
	jr	$ra
	
	
