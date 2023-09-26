.text
.globl main
main:
	li $t0,0
	j readFloat
	
readFloat:
    li $v0,2
    l.s $f12,array
    syscall
    j end
end:
    li $v0,10
    syscall
    
.data
    array: .float 5.5
