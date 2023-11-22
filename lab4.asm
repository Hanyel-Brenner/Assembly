.data
	string1: .asciiz "idioma:"
	string2: .asciiz "ingles"
 	bufferFirst: .space 20
 	bufferCurrent: .space 20
 	K: .word 4
.text
.globl main
main:
	li $v0,5
	syscall #read K
	sw $v0,K #store value of K
	lw $s0,K
	
	li $t0,0  #contador de 0 até K = s0 do loop compare
	li $t1,0 #contador indice das strings comparadas
	li $s7,1 #flag =1 strings equal until now, flag = 0, strings different 
	
	li $v0,8
	la $a0,bufferFirst
	li $a1,20
	syscall
	
	addi $t0,$t0,1
	
	j compare
	
compare: 
	beq $t0,$s0,next
	li $v0,8
	la $a0,bufferCurrent
	li $a1,20
	syscall
	addi $t0,$t0,1
	j compareAux
	
compareAux:
	beq $t1,20,resett1
	lw $s3,bufferFirst($t1)
	lw $s4,bufferCurrent($t1)
	
	beq $s3,0,compareAux2
	
	bne $s3,$s4,notEqual
	addi $t1,$t1,1
	j compareAux
	
compareAux2:
	bne $s3,$s4,notEqual2
	addi $t1,$t1,1
	j compareAux

resett1:
	li $t1,0
	j compare
	
	
notEqual:
	li $s7, 0  #means that strings are not all equal
	addi $t1,$t1,1
	j compareAux
	
notEqual2:
	li $s7,0
	addi $t1,$t1,1
	j compareAux	
	
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
