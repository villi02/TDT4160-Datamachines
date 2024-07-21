start:

    add t0, a0, a1
    add t1, a2, a3
    add t2, a4, a5

    bge t0, t1, t0_bigger
    bge t1, t2, t1_bigger
    
    mv a0, t2
    j end
    
t0_bigger:
    bge t2, t0, t2_bigger 
    mv a0, t0
    j end
t1_bigger:
    bge t0, t1, t0_bigger
    mv a0, t1
    j end
t2_bigger:
    mv a0, t2
    j end

end:
    nop