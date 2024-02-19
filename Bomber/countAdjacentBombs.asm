.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
	save_context
	move $s0, $a0	#linha
	move $s1, $a1	#coluna
	move $s2, $a2	#posição inicial do tabuleiro
	
	li $s7, 0		#count
	sub $s3, $s0, 1	#definindo linha-1

	comecoForI:
		addi $t3, $s0, 1	#condição de parada do for linha + 1
		bgt $s3, $t3, fimForI
		
		sub $s4, $s1, 1	#definindo j - 1
		
		comecoForJ:
			addi $t3, $s1, 1	#condição de parada do for coluna + 1
			bgt $s4, $t3, fimForJ
			
			sll $t6, $s3, 5
			sll $t7, $s4, 2
			add $t6, $t6, $t7
			add $t6, $t6, $s2
			
			lw $s5, 0($t6) #board[i][j]
			
			li $t5, -1
			
			bne $s5, $t5, fimIF
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
