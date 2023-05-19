	.data
prompt: .asciiz "Introduza uma string: "
input: 	.space 64
input_cpy: .space 64
	
	.text
	.globl main
	
main:
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 8
	la	$a0, input
	li	$a1, 64
	syscall
	
	la	$a0, input_cpy
	la	$a1, input
	jal	strcpy
	
	# o strcpy retorna o pointer para a string destino
	move	$a0, $v0
	
	li	$v0, 4
	syscall
	
	li	$v0, 10
	syscall
	
strcat:
	# *dst = $a0
	# *src = $a1
	# aux = $s0
	# Guardar na stack: $s0 e $ra
	addiu	$sp, $sp, -8
	sw	$s0, 0($sp)
	sw	$ra, 4($sp)
	
	move	$s0, $a0
while:
	lb	$t0, 0($a0)
	beq	$t0, '\0', endwhile
	
	addiu	$a0, $a0, 1
	
	j	while
	
endwhile:
	jal	strcpy
	
	# Mover o aux para o retorno da strcat
	move	$v0, $s0
	
	# Restaurar $s0 e $ra da stack
	lw	$s0, 0($sp)
	lw	$ra, 4($sp)
	addiu	$sp, $sp, 8
	
	jr	$ra
	
strcpy:
	# i = $t0
	# *dst = $a0
	# *src = $a1
	li	$t0, 0
	
wh:
	addu	$t1, $t0, $a1
	addu	$t2, $t0, $a0
	lb	$t3, 0($t1)
	
	beq	$t3, '\0', endwh
	
	sb	$t3, 0($t2)
	
	addi	$t0, $t0, 1
	
	j	wh
	
endwh:
	addu	$t2, $t0, $a0
	sb	$zero, 0($t2)
	
	move	$v0, $a0
	jr	$ra	
