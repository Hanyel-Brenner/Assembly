.data
 array: .word 12
.text
.globl main

main:
	li $t0,0
	j read_loop
	
read_loop:
	beq $t0,12,reset_t
	li $v0,5
	syscall
	sw $v0, array($t0)
	addi $t0,$t0,4
	j read_loop
	
reset_t:
    li $t0,0
	j print
print:
    beq $t0,12,end
    lw $s7,array($t0)
    addi $t0,$t0,4
    li $v0,1
    move $a0,$s7
    syscall
    j print
end:
    li $v0,10
    syscall
