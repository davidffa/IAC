	.data
prompt1: .asciiz "Insira a frase 1: "
prompt2: .asciiz "\nInsira a frase 2: "
result1: .asciiz "\nO número de caracteres da frase 1 é "
result2: .asciiz "\nA frase concatenada é: "

frase1:	.space 20
frase2: .space 20
frase3: .space 40

	.text
	.globl main
	
main:
	# $s0 = n
	li	$s0, 0
	
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
	li	$v0, 8
	la	$a0, frase1
	li	$a1, 20
	syscall
	
	li	$v0, 4
	la	$a0, prompt2
	syscall
	
	li	$v0, 8
	la	$a0, frase2
	li	$a1, 20
	syscall
	
	li	$v0, 4
	la	$a0, result1
	syscall
	
	la	$a0, frase1
	jal	strlen
	
	move	$s0, $v0
	
	li	$v0, 1
	move	$a0, $s0
	syscall
	
	la	$a0, frase3
	la	$a1, frase1
	jal	strcpy
	
	la	$a0, frase3
	la	$a1, frase2
	jal	strcat
	
	li	$v0, 4
	la	$a0, result2
	syscall
	
	li	$v0, 4
	la	$a0, frase3
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
	
strlen:
	# n = $v0
	# i = $t0
	li	$t0, 0
	li	$v0, 0
	
wh_sl:
	addu	$t1, $t0, $a0
	
	lb	$t2, 0($t1)
	
	beq	$t2, '\0', endwh_sl
	
	addi 	$v0, $v0, 1
	addi	$t0, $t0, 1
	
	j	wh_sl
endwh_sl:
	jr	$ra
