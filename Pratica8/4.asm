	.data
lista: 	.word 4, 3, -2, 1, 27, 45
result: .asciiz "O conteudo do Array é: \n"
sep:	.asciiz " - "

	.text
	.globl main
	
main:
	li	$t0, 0 # i = 0
	li	$t1, 24 # 6 * 4
	la	$a1, lista
	
loop:
	bge	$t0, $t1, endfor
	
	add	$t2, $a1, $t0
	
	li	$v0, 1
	lw	$a0, 0($t2)
	syscall
	
	li	$v0, 4
	la	$a0, sep
	syscall
	
	addi	$t0, $t0, 4 # i+=4 (int = 4 bytes, 4*1 = 4)
	
	j loop

endfor:
	li	$v0, 10
	syscall
	