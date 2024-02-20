.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
	save_context
	move $s0, $a0	#linha
	move $s1, $a1	#coluna
	move $s2, $a2	#posi��o inicial do tabuleiro
	
	li $s7, 0		#count
	sub $s3, $s0, 1	#definindo linha-1

	comecoForI:
		addi $t3, $s0, 1	#condi��o de parada do for linha + 1
		bgt $s3, $t3, fimForI
		
		sub $s4, $s1, 1	#definindo j - 1
		
		comecoForJ:
			addi $t3, $s1, 1	#condi��o de parada do for coluna + 1
			bgt $s4, $t3, fimForJ
			
			li $t9, SIZE
			mul $t9, $t9, $s3
			add $t9, $t9, $s4
			li $t8, 4
			mul $t9, $t9, $t8
			add $s5, $t9, $s2
			
			lw $s6, 0($s5) #board[i][j]
			
			li $t5, -1
			
			bne $s6, $t5, fimIF
			blt $s3, $zero, fimIF
			bge $s3, SIZE, fimIF
			blt $s4, $zero, fimIF
			bge $s4, SIZE, fimIF
			
			addi $s7, $s7, 1
			
			addi $s4, $s4, 1
			j comecoForJ

		fimForJ:
			addi $s3, $s3, 1
			j comecoForI	
	fimForI	:		
	move $v0, $s7
	restore_context
	jr $ra
	
fimIF:
	addi $s4, $s4, 1
	j comecoForJ	
