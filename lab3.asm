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
	li $t1,0   
	li $s3,0   
	lw $s1,L   
	j read_loop
	
read_loop:
	beq $t0,$s1,assignVelocity  
	li $v0,5
	syscall
	move $t4,$v0
	bgt $t4,50,endVelocidadeInvalida
	blt $t4,1,endVelocidadeInvalida
	bgt $t4,$s3,assign
	addi $t0,$t0,1
	j read_loop
	
assign:
    move $s3,$t4
    addi $t0,$t0,1
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
    li $v0,4
    la $a0,newline
    syscall
    addi $t0,$t0,1
    j read_loop

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
    array: .word 120
    msg1: .asciiz ": valor invalido."
    msg2: .asciiz ": velocidade invalida"
    msg3: .asciiz "Maior nivel : velocidade "
    newline: .asciiz "\n"
