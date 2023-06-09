	.text
	.globl main

main:
	li	$a0, 4
	jal	print_fact
	
	li	$v0, 10
	syscall
	
print_fact:
	# $s0 = i
	# Vamos usar registos s para as variáveis locais desta função
	# então temos de guardar o valor antigo deles na stack para restaurar ao
	# fim desta função, pois por convenção são registos persistentes
	# ie, o seu valor não pode ser alterado após um jal
	
	# Guardar s0 na stack
	addiu	$sp, $sp, -4
	sw	$s0, 0($sp)
	
	# Agora já podemos alterar s0 à vontade, já que o valor antigo está guardado na stack
	li	$s0, 0 # int i;
	
	bgez	$a0, for
	
	# Estas 4 instruções vão ser executadas caso n < 0
	
	# Restaurar da stack
	lw	$s0, 0($sp)
	addiu	$sp, $sp, 4
	
	# return -1
	li	$v0, -1
	jr	$ra

for:
	bgt	$s0, $a0, pf_ret
	
	# Para chamar a fact(i) precisamos de guardar $ra, $a0 (não persistentes, podem ser alterados durante o jal factorial)
	# Não é necessário guardar $s0, pois o seu valor após a chamada ao factorial NÃO PODE mudar
	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$a0, 4($sp)
	
	move	$a0, $s0
	jal	factorial
	
	# Print
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	# Restaurar da stack os valores antigos dos registos
	lw	$ra, 0($sp)
	lw	$a0, 4($sp)
	addiu	$sp, $sp, 8
	
	addi	$s0, $s0, 1
	
	j	for
	
pf_ret:
	# Restaurar da stack
	lw	$s0, 0($sp)
	addiu	$sp, $sp, 4
	
	li	$v0, 1
	jr	$ra
	
	

factorial:
	blt	$a0, 2, base_case
	
	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)	# Guardar $ra na stack
	sw	$a0, 4($sp)	# Guardar $a0 na stack (precisamos dele após a chamada recursiva)
	
	subi	$a0, $a0, 1
	jal	factorial
	
	# Restaurar da stack
	lw	$ra, 0($sp)
	lw	$a0, 4($sp)
	addiu	$sp, $sp, 8
	
	mul	$v0, $a0, $v0
	
	jr	$ra
base_case:
	li	$v0, 1
	jr	$ra
