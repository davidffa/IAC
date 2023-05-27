	.data
prompt:	.asciiz "Escreva uma string: "
prompt2: .asciiz "Escreva outra string: "
result:	.asciiz "Resultado: "
string1: .space 32
string2: .space 32

	.text
	.globl main	
main:
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 8
	la	$a0, string1
	li	$a1, 32
	syscall
	
	li	$v0, 4
	la	$a0, prompt2
	syscall
	
	li	$v0, 8
	la	$a0, string2
	li	$a1, 32
	syscall
	
	la	$a0, string1
	la	$a1, string2
	jal	strstr
	
	move	$s0, $v0
	
	li	$v0, 4
	la	$a0, result
	syscall
	
	li	$v0, 34
	move	$a0, $s0
	syscall
	
	li	$v0, 10
	syscall

	li	$v0, 10
	syscall

# Nota: Todos os \0 foram substituídos por \n, pois o último caracter do read_string é um \n
strstr:
	# $a0 -> char*
	# $a1 -> char*
	addiu	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$ra, 8($sp)
	
	lb	$s1, 0($a1)
	
	beq	$s1, '\n', str_found
	
wh:
	lb	$s0, 0($a0)
	beq	$s0, '\n', str_notfound
	
	addiu	$sp, $sp, -8
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	
	jal	startswith
	
	lw	$a0, 0($sp)
	lw	$a1, 4($sp)
	addiu	$sp, $sp, 8
	
	beq	$v0, 1, str_found
	
	addiu	$a0, $a0, 1
	j	wh
	
str_found:
	move	$v0, $a0
	j	return
str_notfound:
	li	$v0, 0
return:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$ra, 8($sp)
	addiu	$sp, $sp, 12

	jr	$ra
	
startswith:
	li	$v0, 0
sw_wh:
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	
	beq	$t0, '\n', sw_return
	beq	$t1, '\n', sw_return
	bne	$t0, $t1, not_eq
	
	addiu	$a0, $a0, 1
	addiu	$a1, $a1, 1
	
	j	sw_wh
not_eq:
	li	$v0, 0
	
	jr	$ra
sw_return:
	beq	$t1, '\n', sw_true
	j	sw_endif
sw_true:
	li	$v0, 1
sw_endif:
	jr	$ra
