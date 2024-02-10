.include "macros.asm"

.globl play

play:
# your code here
	save_context
	move $s0, $a0	#linha
	move $s1, $a1	#coluna
	move $s2, $a2	#posição inicial do tabuleiro
	
	sll $t2, $a0, 5
	sll $t3, $a1, 2
	add $t4, $t2, $t3
	add $t5, $t4, $a2
	move $t6, $t5			#lw $t6, $t5
	li $t7, -1
	li $t8, -2
	li $t9, 1
	    
	beq $t6, $t7, bomb
	beq $t6, $t8, safe
	
	
	
	move $v0, $t9		#teste
	restore_context
	jr $ra
	
	bomb: 
		move $v0,$zero
		restore_context
		jr $ra
		
	safe:
		jal countAdjacentBombs
		move $t0, $v0
		move $t6, $t0
		# move $v0, $t9
		beq $t6, $zero, revelar
		restore_context
		jr $ra
		
	revelar:
		jal revealNeighboringCells
		restore_context
		jr $ra
		
	
	
	
	