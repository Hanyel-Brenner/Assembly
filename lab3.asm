.text
.globl main

main:
	li $v0,5
	syscall
	move $t0, $v0
	sw $t0, L
	bgt $t0,30,endValorInvalido
	blt $t0,1,endValorInvalido
	li $t0,0
	li t1,0   ;counter solely to multiplyL label
	li $s3,0   ;register with highest number
	lw $s1,L   ;register that holds L times 4 (number of bytes in array)
	j multiplyL
	
multiplyL:
    beq $t1,3,read_loop  ;L+L+L... 4 times so we have number of bytes
    add $s1,$s1,$s1
    addi $t1,$t1,1
    j multiplyL
	
read_loop:
	beq $t0,$s1,assignVelocity  ;s1 should have number of bytes
	li $v0,5
	syscall
	move $t4,$v0
	bgt $v0,50,endVelocidadeInvalida
	blt $v0,1,endVelocidadeInvalida
	sw $v0, array($t0)
	bgt $v0,$s3,assign
	addi $t0,$t0,4
	j read_loop
	
assign:
    move $s3,$v0
    addi $t0,$t0,4
    j read_loop
    
assignVelocity:
    blt $s3,10,assign1
    bge $s3,20,assign3
    j assign2
    
assign1:
    li $s4,1
    j print
assign2:
    li $s4,2
    j print
assign3:
    li $s4,3
    j print
    
print:
    li $v0,4
    la $a0,msg3
    syscall
    li $v0,1
    move $a0,$s4
    syscall
    j end
	
endVelocidadeInvalida:
    li $v0,1
    move $a0,$t4
    syscall
    li $v0,4
    la $a0,msg2
    syscall

endValorInvalido:
    li $v0,1
    move $a0,$t0
    syscall
    li $v0,4
    la $a0,msg1
    syscall
    li $v0,10
    syscall
    
end:
    li $v0,10
    syscall
    
.data
    L: .word 4
    array: word 120
    msg1: .asciiz ": valor invalido."
    msg1: .asciiz ": velocidade invalida."
    msg3: .asciiz "\nMaior nivel : velocidade "
