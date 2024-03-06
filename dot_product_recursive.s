# The dot product is: 130
.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "The dot product is: \n"
space: .string " "

.text
main:
    la a0, a  # a
    la a1, b  # b
    addi a2, x0, 5  # size of array = 5
    jal dot_product_recursive 

    j exit

dot_product_recursive:
    addi sp, sp, -16 
    sw ra 0(sp) # storing the ra value on to the stack
    sw a0 4(sp) # storing the a value on to the stack
    sw a1 8(sp) # storing the b value on to the stack
    sw a2 12(sp) # storing the size value on to the stack

    addi t0 x0 1 

    # Base Case
    bne a2, t0, exit_dot_product_recursive
    addi sp, sp, 16 
    lw t1, 0(a0)  # a[0]
    lw t2, 0(a1)  # b[0]
    mul a0, t1, t2 # a = a[0]*b[0]
    jr ra
    
exit_dot_product_recursive:
    addi a0, a0, 4  # a + 1
    addi a1, a1, 4  # b + 1

    addi a2, a2, -1  # size
    jal dot_product_recursive

    lw ra 0(sp) 
    lw t0 4(sp) 
    lw t1 8(sp) 
    lw t2 12(sp) 

    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
    addi sp, sp, 16 
    lw t3, 0(t0)
    lw t4, 0(t1)
    mul t5, t3, t4 # t5 = a[0]*b[0] 
    add a0, a0, t5 # a = dot_product_recursive(a+1, b+1, size-1)
    jr ra
    
exit:
    mv t0, a0

    addi a0, x0, 4
    la a1, print_text
    ecall

    mv a1, t0
    addi a0, x0, 1
    ecall

    addi a0, x0, 10
    ecall
