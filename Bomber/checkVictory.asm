.include "macros.asm"

.globl checkVictory

checkVictory:
# your code here
	save_context
	move $s0, $a2
	
	move $t0, $zero
	move $t2, $a2
	li $t9, 1
	
	move $t4, $zero		#definindo o i
	move $t5, $zero		#definindo o j
	
	comecoForI:
	bge $t4, SIZE, endForI
		comecoForJ:
		bge $t5, SIZE, endForJ
		
			sll $t6, $t4, 5
			sll $t7, $t5, 2
			add $t6, $t6, $t7
			add $t6, $t6, $a2
			
			blt $t6, $zero, fimIF
				addi $t0, $t0, 1
			fimIF:
		
		addi $t5, $t5, 1
		j comecoForJ 
		endForJ:
	move $t5, $zero
	addi $t4, $t4, 1
	j comecoForI
	endForI:
	
	li $t8, SIZE
	mul $t3, $t8, $t8
	sub $t4, $t3, BOMB_COUNT
	blt $t0, $t4, continua
	
	move $v0, $t9
	restore_context
	jr $ra
	
	continua:
		move $t0, $zero
		restore_context
		jr $ra
	
