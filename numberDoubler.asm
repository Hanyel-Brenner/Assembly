.data

.text
.globl main

main:
	li $v0,5
	syscall
	move $s0,$v0
	li $s3,0
	bgt $s0,$s3,continue
	j end	
continue:
	add $s1,$s0,$s0
	li $v0,1
	move $a0,$s1
	syscall
	j end
end:
	li $v0,10
	syscall
