.text
.globl main
main:
	li $t0,0
	li $t1,0  
	li $t2,0  
	li $t3,0  
	li $t4,0 
	j read_loop
	
read_loop:
	beq $t0,20,initializeValues
	li $v0,5
	syscall
	sw $v0,array($t0)
	bge $v0,0,addPositive
	blt $v0,0,addNegative

addPositive:
	addi $t3,$t3,1
	addi $t0,$t0,4
	j read_loop
addNegative:
	addi $t4,$t4,1
	addi $t0,$t0,4
	j read_loop
	
initializeValues:
	li $t0,0  
	li $t1,0
	li $t2,0
	j verify

verify:
	beq $t0,20,reset_t
	lw $s0, array($t0)
	abs $s0,$s0
	j subtract

subtract:
	blt $s0,2,save_remainder
	subi $s0,$s0,2
	j subtract

save_remainder:
	sw $s0,resultArray($t0)
	addi $t0,$t0,4
	j verify

reset_t:
    li $t0,0
    j assign
    
assign:
	beq $t0,20,lastStep
	lw $s1,resultArray($t0)
	beq $s1,0,assignEven
	beq $s1,1,assignOdd
	
assignEven:
	addi $t1,$t1,1
	addi $t0,$t0,4
	j assign
assignOdd:
	addi $t2,$t2,1
	addi $t0,$t0,4
	j assign
	
	
lastStep:
	li $t0,0
	j print
print:
	la $a0,terminator
	li $v0,4
	syscall
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,msg2
	syscall
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,4
	la $a0,msg3
	syscall
	li $v0,1
	move $a0,$t4
	syscall
	li $v0,4
	la $a0,msg4
	syscall
	li $v0,10
	syscall
	
.data
	array: .word 20
	resultArray: .word 20
	msg1: .asciiz " valor(es) par(es)\n"
	msg2: .asciiz " valor(es) impar(es)\n"
	msg3: .asciiz " valor(es) positivo(s)\n"
	msg4: .asciiz " valor(es) negativo(s)"
	terminator: .ascii "\0"
