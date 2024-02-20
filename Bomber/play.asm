.include "macros.asm"

.globl play

play:
# your code here
	save_context
	move $s0, $a0 # linha
	move $s1, $a1 # coluna
	move $s2, $a2 # tabela - Board

	li $t9, SIZE
	mul $t9, $t9, $s0
	add $t9, $t9, $s1
	li $t8, 4
	mul $t9, $t9, $t8
	add $s4, $t9, $s2

	lw $s5, 0($s4)

	li $t4, -1
	
	bne $s5, $t4, hitBomb
		move $v0, $zero
		restore_context
		jr $ra
	hitBomb:

	li $t5, -2

	bne $s5, $t5, celulaVazia
		move $a0, $s0
		move $a1, $s1
		move $a2, $s2
		jal countAdjacentBombs

		move $s6, $v0

		sw $s6, 0($s4)

		bne $s6, $zero, haveBomb
			move $a0, $s0
			move $a1, $s1
			move $a2, $s2
			jal revealNeighboringCells
		haveBomb:

	celulaVazia:

	li $t6, 1

	move $v0, $t6
	restore_context
	jr $ra
