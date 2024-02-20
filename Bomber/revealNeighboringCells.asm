.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:#s3 -<
# your code here
	save_context
	move $s0, $a0 	# linha
	move $s1, $a1 	# coluna
	move $s2, $a2 	# arrayBoard

	subi $s3, $s0, 1	# i

	comecoForI:
		addi $t0, $s0, 1 	# condição do For I
		bgt $s3, $t0, fimForI
		subi $s4, $s1, 1	# j 
	
		comecoForJ:
			addi $t9, $s1, 1 	# condição do For J
			bgt $s4, $t9, fimForJ
			
			li $t0, SIZE
			mul $t0, $t0, $s3
			add $t0, $t0, $s4
			li $t1, 4
			mul $t0, $t0, $t1
			add $s5, $t0, $s2

			lw $s6, 0($s5) 
			li $t1, -2
	
			blt $s3, $zero, fimIF
			bge $s3, SIZE, fimIF
			blt $s4, $zero, fimIF
			bge $s4, SIZE, fimIF
			bne $s6, $t1, fimIF 	
	
			move $a0, $s3
			move $a1, $s4
			move $a2, $s2
			jal countAdjacentBombs

			move $t2, $v0 	
			sw $t2, 0($s5) 	# board[i][j] = x
		
			bne $s6, $zero, fimdoIF
				move $a0, $s3   
				jal revealNeighboringCells
			fimdoIF:
			fimIF:				
			addi $s4, $s4, 1
			j comecoForJ
		fimForJ:
		addi $s3, $s3, 1
		j comecoForI
	fimForI:
	restore_context
	jr $ra
