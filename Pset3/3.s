start: 
#    li a0, 2401 # test value
    li a1, 0 # default return value of square number
    li t6, 2 # to be used as divider
    mv t4, a0 # original value of a0
    mv t0, a0 # copy of original value of a0
    div t0, a0, t6 # half the runtime
    addi t0, t0, 1 # to fix edge cases need to add 1, neglectable runtime increase
    j findGreatestDivisor
    
findGreatestDivisor: # loop to find greatest divisor
    addi t0, t0, -1 # works because is bigger than 1
    rem t2, t4, t0
    
    bne x0, t2, findGreatestDivisor
    
isDivisor: 
    mv a0, t0 # store the divisor in a0
    mv t1, t0 # move the divisor to t1 for the next calculations
    j findRoot

findRoot:
    mul  t2, t1, t1 # t2 = t1^2
    beq  t2, t4, isRoot # compare with the original value
    addi t1, t1, -1
    bgtz t1, findRoot
    j end
    
isRoot:
    addi a1, x0, 1
    j end

end:
    nop