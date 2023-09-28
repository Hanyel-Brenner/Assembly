.text
.globl main
main:
	li $t0,0
	j read_loop
	
read_loop:
	beq $t0,24,initializeValues
	li $v0,6
	syscall
	s.s $f0, array($t0)
	addi $t0,$t0,4
	j read_loop
	
initializeValues:
	li $t0,0  
	li $t1,0 
	j sumPositives
	
sumPositives:
    beq $t0,24,print
    l.s $f1,array($t0)
    bgt $f1,0,addToCounter
    addi $t0,$t0,4
    j sumPositives
    
addToCounter:
    addi $t1,$t1,1
    addi $t0,$t0,4
    j sumPositives
    
print:
    li $v0,1
    move $a0,$t1
    syscall
    li $v0,4
    la $a0,msg
    syscall
    j end
    
end:
    li $v0,10
    syscall
    
.data
    array: .word 24
    msg: .asciiz " valores positivos"
