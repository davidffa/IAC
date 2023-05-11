	.data
lista:	.space 24 # 6 * 4
sep:	.asciiz " - "

	.text
	.globl main
main:
	li	$t0, 0 # houveTroca
	li	$t1, 0 # aux
	li	$t2, 0 # i
	
	li	$s0, 24 # SIZE
	li	$s1, 20 # SIZE - 1

	la	$a1, lista
	
readloop:
	bge	$t2, $s0, dowh
	
	add	$t3, $a1, $t2
	
	li	$v0, 5
	syscall
	
	sw	$v0, 0($t3)
	
	addi	$t2, $t2, 4 # i+=4 (int = 4 bytes, 4*1 = 4)

	j readloop
	
dowh:
	li	$t0, 0
	li	$t2, 0
for:
	bge	$t2, $s1, endfor
		
	addu	$t4, $a1, $t2
	addi	$t2, $t2, 4 # i+=4 (int = 4 bytes, 4*1 = 4)
	
	lw	$t5, 0($t4) # lista[i]
	lw	$t6, 4($t4) # lista[i+1]
	
	ble	$t5, $t6, for
	
	move	$t1, $t5
	
	sw	$t6, 0($t4)
	sw	$t1, 4($t4)
	
	li	$t0, 1
	
	j	for
	
endfor:
	beq	$t0, 1, dowh

	li	$t2, 0
	
printloop:
	bge	$t2, $s0, exit
	
	add	$t3, $a1, $t2
	
	li	$v0, 1
	lw	$a0, 0($t3)
	syscall
	
	li	$v0, 4
	la	$a0, sep
	syscall
	
	addi	$t2, $t2, 4 # i+=4 (int = 4 bytes, 4*1 = 4)
	
	j 	printloop
exit:
	li	$v0, 10
	syscall
	
