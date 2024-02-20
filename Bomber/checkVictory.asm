.include "macros.asm"

.globl checkVictory

checkVictory:
# your code here
	save_context
	move $s0, $a2 # board
	move $s1, $zero # count

	move $s2, $zero # i
	li $t0, SIZE
	
	comecoForI:
		bge $s2, $t0, fimForI
		move $s3, $zero # j
		comecoForJ:
			bge $s3, $t0, fimForJ
			mul $t9, $s2, $t0
			add $t9, $t9, $s3
			li $t8, 4
			mul $t9, $t9, $t8
			add $s4, $t9, $s0

			lw $s5, 0($s4)

			blt $s5, $zero, fimIF
				addi $s1, $s1, 1
			fimIF:
			addi $s3, $s3, 1
			j comecoForJ
		fimForJ:
		addi $s2, $s2, 1
		j comecoForI
	fimForI:
	mul $t1, $t0, $t0
	subi $t2, $t1, BOMB_COUNT
	bge $s1, $t2, vitoria
		move $v0, $zero
		jr $ra
	vitoria:
	li $t3, 1
	move $v0, $t3
	jr $ra	
