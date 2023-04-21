# Igual ao 4 mas imprimir usando o print_char
	.text
	.globl main
	
main:
	li 	$t1, 0x14ABCF
	li 	$t0, 28
	li 	$s0, 0xF
	li 	$s1, 9
	
	# for (int i = 28; i >= 0; i -= 4)
	# $t0 = i
loop:
	bltz 	$t0, exit
	
	sllv 	$t4, $s0, $t0
	
	and 	$t2, $t1, $t4
	srlv	$t3, $t2, $t0
	
	subi 	$t0, $t0, 4

	bgt $t3, $s1, letter
	
	# print de 0 a 9
	li 	$v0, 11
	addi 	$t3, $t3, '0'
	move 	$a0, $t3
	syscall
	
	j done
letter:
	# print de A a F
	li 	$v0, 11
	
	addi 	$t3, $t3, 'A'
	subi	$t3, $t3, 10
	move 	$a0, $t3
	syscall
	
done:
	li	$v0, 11
	li	$a0, ' '
	syscall
	
	j 	loop
		
exit:
	li	$v0, 10
	syscall
	
