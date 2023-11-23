.data
	string1: .asciiz "idioma:"
	string2: .asciiz "ingles"
	bufferFirst: .space 20
	bufferCurrent: .space 20
	K: .word 4
.text
.globl main

main:
	li $v0, 5
	syscall
	sw $v0,K
	lw $s0,K
	jal resetCounter1
	jal resetCounter2
	li $s7,1  #esse valor eh 1 se as strings forem iguais e 0 se as strings forem diferentes
	li $v0,8
	la $a0,bufferFirst
	li $a1,20
	syscall
	addi $t0,$t0,1
	
	j insertAndCompare
	
insertAndCompare:
	beq $t0,$s0,next
	jal insert
	j innerLoop
	
innerLoop:
	lbu $s1,bufferFirst($t1)
	lbu $s2,bufferCurrent($t1)
	addi $t1,$t1,1
	beq $s1,$zero,compare1
	j compare2
	
compare1:
	bne $s1,$s2,setFlagZero1
	jal resetCounter2
	j insertAndCompare
	
compare2:
	bne $s1,$s2,setFlagZero2
	j innerLoop
setFlagZero1:
	li $s7,0
	jal resetCounter2
	j insertAndCompare
	
setFlagZero2:
	li $s7,0
	jal resetCounter2
	j insertAndCompare

insert:
	li $v0,8
	la $a0, bufferCurrent
	li $a1,20
	syscall
	addi $t0,$t0,1
	jr $ra

resetCounter1:
	addi $t0,$zero,0
	jr $ra
resetCounter2:
	addi $t1,$zero,0
	jr $ra

next:
	li $v0,4
	la $a0,string1
	syscall
	bne $s7,1,printIngles
	li $v0,4
	la $a0,bufferFirst
	syscall
	j end
	
printIngles:
	li $v0,4
	la $a0,string2
	syscall
	j end

end:
	li $v0,10
	syscall
