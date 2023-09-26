.text
.globl main
main:
	li $t0,0
	j readFloat
	
readFloat:
    li $v0,2
    lw $v0,arrayFloat
    syscall
    j end
end:
    li $v0,10
    syscall
    
.data
    arrayFloat: .float 304.5
    array: .word 24
    msg: .asciiz " valores positivos"
