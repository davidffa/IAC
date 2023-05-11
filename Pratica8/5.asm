	.data
prompt: .asciiz "Insira 6 números: \n"
lista: 	.space 24 # 6 * 4

	.text
	.globl main
	
main:
	li	$t0, 0 # i = 0
	li	$t1, 24 # 6 * 4
	la	$a1, lista
	
	li	$v0, 4
	la	$a0, prompt
	syscall
	
readloop:
	bge	$t0, $t1, endreadloop
	
	add	$t2, $a1, $t0
	
	li	$v0, 5
	syscall
	
	sw	$v0, 0($t2)
	
	addi	$t0, $t0, 4 # i+=4 (int = 4 bytes, 4*1 = 4)

	j readloop

endreadloop:
	li	$t0, 0
	
printloop:
	bge	$t0, $t1, exit
	
	add	$t2, $a1, $t0
	
	lw	$t3, 0($t2)
	
	li	$v0, 1
	move	$a0, $t3
	syscall
	
	li	$v0, 11
	li	$a0, ' '
	syscall
	
	addi	$t0, $t0, 4
	
	j printloop
	

exit:
	li	$v0, 10
	syscall
	
