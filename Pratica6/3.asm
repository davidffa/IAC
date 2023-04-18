	.data
prompt:	.asciiz "Introduza dois números: "
result: .asciiz "A soma dos dois números é: "

	.text
	.globl main
	
main:
	# print_string( “Introduza dois números :” );
	li 	$v0, 4
	la 	$a0, prompt
	syscall
	
	# a = read_int();
	# a = $t0
	li 	$v0, 5
	syscall
	
	move $t0, $v0
	
	# b = read_int();
	# b = $t1
	li	$v0, 5
	syscall
	
	move $t1, $v0
	
	# print_string( “A soma dos números e’: ” );
	li	$v0, 4
	la 	$a0, result
	syscall
	
	# a+b
	add 	$t3, $t0, $t1
	
	# print_int10( a + b )
	# li $v0, 1
	# move $a0, $t3
	# syscall
	
	# print_intu10( a + b )
	li 	$v0, 36
	move 	$a0, $t3
	syscall
	
	# exit
	li	$v0, 10
	syscall
