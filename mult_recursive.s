# #include <stdio.h>

# int mult(int a, int b) {
#     if (b == 1) return a;
#     return a + mult(a, b-1);
# }

# int main() {
#     int result;

#     printf("%d\n", mult(110, 50));
#     return 0;
# }
.text
main:
    # a: calleR
    addi a0, x0, 110  # a
    addi a1, x0, 50  # b
    jal mult

    # print int
    mv a1, a0
    addi a0, x0, 1
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall

    j exit


mult:
    addi sp, sp,  -4
    sw a0, 4(sp)  # storing the a value on to the stack
    sw ra, 0(sp)  # storing the ra value on to the stack

    # base case
    # compare a1 with 1, if the two are equal you exit the mul function
    addi t0, x0, 1 # 1
    bne a1, t0, exit_base_case
    
    
    # recursive case
    addi sp, sp,  -4
    jr ra 
    
     
    
exit_base_case:

    # mult(a, b-1);
    addi a1, a1, -1  # b-1
    j mult
    
    # a + mult(a, b-1);
    mv t1, a0
    lw a0, 0(sp)
    lw t1, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1
    
    lw ra, 0(sp)
    addi sp, sp, 4
    
    jr ra



exit:
    addi a0, x0, 10
    ecall

