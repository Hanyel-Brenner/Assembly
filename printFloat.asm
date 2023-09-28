.text
.globl main
main:
	li $t0,0
	j readFloat
	
readFloat:
    li $v0,6
    syscall
    s.s $f0,array
    li $v0,2
    l.s $f12,array
    syscall
    j end
end:
    li $v0,10
    syscall
    
.data
    array: .word 4
