	.data
result: .asciiz "\nO numero em que pensaste e: "
prompt: .ascii "1. Pensa num numero!\n"
	.ascii "2. Adiciona 3\n"
	.ascii "3. Multiplica o resultado por 2\n"
	.ascii "4. Subtrai o numero em que pensaste\n"
	.asciiz "\n\tQual o resultado? "
	
	.text
	.globl main
	
main:
	la 	$a0, prompt
	li 	$v0, 4
	syscall
	
	li 	$v0, 5
	syscall
	
	move 	$t0, $v0
	
	la 	$a0, result
	li	$v0, 4
	syscall
	
	sub	$a0, $t0, 6
	li	$v0, 1
	syscall
	
	li	$v0, 10
	syscall
