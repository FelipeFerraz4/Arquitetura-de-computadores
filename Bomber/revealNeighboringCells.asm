.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0	#linha
	move $s1, $a1	#coluna
	move $s2, $a2	#posi??o inicial do tabuleiro
	
	move $t0, $zero		#count
	move $t1, $a0
	subi $t1, $t1, 1	#definindo i
	move $t2, $a1
	subi $t2, $t2, 1	#definindo j
	move $t3, $a0
	addi $t3, $t3, 1	#condi??o de parada do for i
	move $t4, $a1
	addi $t3, $t3, 1	#condi??o de parada do for j
	li $t5, -2
	comecoForI:
	bgt $t1, $t3, fimForI
		comecoForJ:
		bgt $t2, $t4, fimForJ
			sll $t6, $t1, 5
			sll $t7, $t2, 2
			add $t6, $t6, $t7
			add $t6, $t6, $a2
			
			lw $t6, 0($t6)
			
			bne $t6, $t5, fimIF
			blt $t1, $zero, fimIF
			bge $t1, SIZE, fimIF
			blt $t2, $zero, fimIF
			bge $t2, SIZE, fimIF
				move $a0, $t1
				move $a1, $t2
				move $a2, $s2
				jal countAdjacentBombs
				
				move $t8, $v0
				
				move $t6, $t8
				
				bne $t8, $zero,fimdoIF
					move $a0, $t1
					move $a1, $t2
					move $a2, $s2
					jal revealNeighboringCells
				fimdoIF:
				
			fimIF:
		addi $t2, $t2, 1
		j comecoForJ
		fimForJ:
	move $t2, $zero
	addi $t1, $t1, 1
	j comecoForI
	fimForI:
	
	
	
	restore_context
	jr $ra