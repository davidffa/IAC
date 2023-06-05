	.data
frase:	.asciiz "Te3m In5tei1ros Mis8tura9dos"
msg:	.asciiz	"\nO nr de Alfas e: "

	.text
	.globl main
	
main:
	li	$s0, 0
	li	$v0, 4
	la	$a0, msg
	syscall
	
	la	$a0, frase
	jal	n_alphas
	move	$s0, $v0
	
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	li	$v0, 10
	syscall
	
n_alphas:
	# $t0 = i
	# $t1 = alfas
	# $a0 = *str
	li	$t0, 0
	li	$t1, 0
	
for:
	addu	$t2, $a0, $t0	# &str[i]
	lb	$t3, 0($t2)	# str[i]
	
	addi	$t0, $t0, 1
	
	beqz	$t3, endfor
	blt	$t3, 'A', for
	bgt	$t3, 'z', for
	
	addi	$t1, $t1, 1
	
	j	for
endfor:
	move	$v0, $t1
	jr	$ra