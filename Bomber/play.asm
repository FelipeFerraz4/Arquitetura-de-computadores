.include "macros.asm"

.globl play

play:
# your code here
	save_context
	move $s0, $a0	#linha
	move $s1, $a1	#coluna
	move $s2, $a2	#posição inicial do tabuleiro//
	
	sll $t2, $a0, 5
	sll $t3, $a1, 2
	add $t4, $t2, $t3
	add $t5, $t4, $a2
	
	lw $s6, 0($t5)		#board[i][j]	#lw $t6, $t5
	li $t7, -1
	li $t8, -2
	li $t9, 1
	    
	beq $t6, $t7, bomb
	#bne $t6, $t8, safe
		move $s2, $a2
		jal countAdjacentBombs
		move $t0, $v0
		sw $t0, 0($s6) #board[i][j] = countAdjacenteBombs
		#move $t6, $t0
		# move $v0, $t9
		beq $t0, $zero, fimdoIf
			move $a0, $s0
			move $a1, $s1
			move $a2, $s2
			jal revealNeighboringCells
			restore_context
			jr $ra
		fimdoIf
		
	move $v0, $t9		#teste
	restore_context
	jr $ra
	
	bomb: 
		sw $t9, 0($t6) #board[i][j] = countAdjacenteBombs
		move $v0,$zero
		restore_context
		jr $ra
		
	safe:
		
		restore_context
		jr $ra
		
	revelar:
		jal revealNeighboringCells
		restore_context
		jr $ra
		
	
	
	
	
