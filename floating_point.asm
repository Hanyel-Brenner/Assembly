.data
 array: .word 12
 resultArray: .word 12
.text
.globl main

main:
	li $t0,0
	j read_loop
	
read_loop:
	beq $t0,12,initialize_values
	li $v0,5
	syscall
	sw $v0, array($t0)
	addi $t0,$t0,4
	j read_loop

initialize_values:
	li $t0,0  #counter
	j verify

verify:
	beq $t0,12,reset_t
	lw $s0, array($t0)
	j subtract

subtract:
	ble $s0,2,save_remainder
	subi $s0,$s0,2
	j subtract

save_remainder:
	sw $s0,resultArray($t0)
	addi $t0,$t0,4
	j verify

reset_t:
    li $t0,0
	j print

print:
    beq $t0,12,end
    lw $s7,resultArray($t0)
    addi $t0,$t0,4
    li $v0,1
    move $a0,$s7
    syscall
    j print

end:
    li $v0,10
    syscall