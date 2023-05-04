	.data
prompt1: .asciiz "Introduza um numero\n"
strpar:  .asciiz "O numero é par\n"
strimp:  .asciiz "O numero é impar\n"

	.text
	.globl main

main:
	# print_str( prompt1 );
	li 	$v0, 4
	la 	$a0, prompt1
	syscall
	
	# $t0 = a
	# a = read_int();
	
	li 	$v0, 5
	syscall
	
	move	$t0, $v0
	
	andi 	$t0, $t0, 1
	
	li	$v0, 4
	
	# if ((a & 1) == 0)
	beqz	$t0, par
	
	# print_str( strimp );
	la	$a0, strimp
	j	endif
par:
	# else
	# print_str( strpar );
	la	$a0, strpar
	
endif:
	# syscall de print_str
	syscall
	
	li	$v0, 10
	syscall
	