	.data
prompt1: .asciiz "Qual a base? "
prompt2: .asciiz "Qual o expoente? "
	
	.text
	.globl main
	
main:
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
	li	$v0, 5
	syscall
	
	move	$s0, $v0
	
	li	$v0, 4
	la	$a0, prompt2
	syscall
	
	li	$v0, 5
	syscall
	
	move	$s1, $v0
	
	move	$a0, $s0
	move	$a1, $s1
	jal	x_to_y
	
	move	$s2, $v0
	
	li	$v0, 1
	move	$a0, $s2
	syscall

	li	$v0, 10
	syscall
	
x_to_y:
	# $a0 = base
	# $a1 = exp
	beqz	$a1, base_case
	
	# Guardar o $ra na stack
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	subi	$a1, $a1, 1
	
	jal	x_to_y
	
	# Restaurar o $ra da stack
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	
	mul	$v0, $a0, $v0
	
	jr	$ra	
	
base_case:
	# Caso base da função recursiva, retorna 1
	li	$v0, 1
	jr	$ra