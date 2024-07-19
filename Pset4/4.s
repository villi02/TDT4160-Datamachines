# Øving 4
# Ikke bry deg om denne delen, move along
.data
function_error_str: .string "ERROR: Woops, programmet returnerte ikke fra et funksjonskall!"

.text
# Her starter programmet

# Test Mode
# Sett a7 til 1 for å teste med verdiene under Test - Start
# Sett a7 til 0 når du skal levere
li a7, 1
beq a7, zero, load_complete

# Test - Start
#li a0, 0
#li a1, 0
#li a2, 0
#li a3, 0
#li a4, 0
#li a5, 0
# Test Slutt

load_complete:

# Globale Registre:
# s0-s5 : Foreløpig liste
# s6    : Har byttet verdier denne syklusen (0/1)

# Hopp forbi funksjoner
j main

# Funksjoner:
swap:
    # Args: a0, a1
    # Outputs: a0, a1
    
    # Only swap if bigger
    ble a0, a1, swap_complete
    
    # Swap a0 and a1
    mv t0, a0
    mv a0, a1
    mv a1, t0
    
    # Set s6 to 1 to indicate a swap
    li s6, 1
    
swap_complete:
    ret

# Hvis programmet kommer hit har den ikke greid Ã¥ returnere fra funksjonen over
# Dette bÃ¸r aldri skje
la a0, function_error_str
li a7, 4
ecall
j end

# Main
main:
    # Load s0-s5 with the values from a0-a5
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5
    
loop: # loop through this until it makes no change

    # Reset swap indicator
    li s6, 0
    
    # Sort all registers
    mv a0, s0
    mv a1, s1
    jal swap
    mv s0, a0
    mv s1, a1
    
    mv a0, s1
    mv a1, s2
    jal swap
    mv s1, a0
    mv s2, a1
    
    mv a0, s2
    mv a1, s3
    jal swap
    mv s2, a0
    mv s3, a1
    
    mv a0, s3
    mv a1, s4
    jal swap
    mv s3, a0
    mv s4, a1
    
    mv a0, s4
    mv a1, s5
    jal swap
    mv s4, a0
    mv s5, a1
    
    # Continue loop if something changed
    bnez s6, loop
    
loop_end:
    # Move everything to output registers
    mv a0, s0
    mv a1, s1
    mv a2, s2
    mv a3, s3
    mv a4, s4
    mv a5, s5
    
end:
    nop
