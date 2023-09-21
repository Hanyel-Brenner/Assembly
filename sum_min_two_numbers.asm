.data
	array: .word 12
.text
.globl main

main:
	li $t0,0
	j read_loop
	
read_loop:
	beq $t0,12,func1
	li $v0,5
	syscall
	sw $v0, array($t0)
	add $t0,$t0,4
	j read_loop
	
func1:
	li $t0,0
	lw $s1,array($t1)
	beq $t2,12,end
	j assign_loop
	

	
exit:
	
