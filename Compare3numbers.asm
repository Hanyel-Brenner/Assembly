.data
msg: .asciiz "Maior:"

.text
.globl main



main:	
	li $v0,5  
	syscall
	move $s0,$v0
	li $v0,5
	syscall
	move $s1,$v0
	li $v0,5
	syscall
	move $s2,$v0
	blt $s0,$s1,compare1_2
	j compare0_2
	
	
compare0_2:
	blt $s0,$s2,result2
	move $s7,$s0
	j last

compare1_2:
	blt $s1,$s2,result2
	move $s7,$s1
	j last
	
result2:
	move $s7,$s2
	j last	
	
last:	
	li $v0,4
	la $a0,msg 
	syscall 
	li $v0,1  
	move $a0,$s7
	syscall
