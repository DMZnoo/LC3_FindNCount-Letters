.ORIG x3000
count1 .stringz "\nTotally, it has "
count2 .stringz " characters including spaces\n"
OUTPUTSTRING .stringz "\nThe text you have typed is: "
MY_NAME .stringz "Jinwoo Lee, ID number:18018154\n\n"
PRINT_INSTRUCTION .stringz "Please enter a text: "
sentence_1 .stringz "It has "
space_string .stringz " spaces\n"
lower_string .stringz " lower-case letters\n"
upper_string .stringz " upper-case letters\n"


lea r0, MY_NAME
    puts
    ; initialise registers
    and r2,r2,#0 
    AND r3, r3, #0
    AND r5, r5, #0
    AND r6, r6, #0

; print the input prompt

    LEA r0, PRINT_INSTRUCTION
PUTS

LEA r4, ARRAY

    GETSTRING
    GETC
    ld r1, NEWLINE_NEG ;negative ascii code for newline feed
    add r1,r0,r1
    BRz EXIT_LOOP ;if enter was pressed, exit the loop
    OUT
    ld r1, SPACE_COUNT ;load negative ascii code for space
    add r1,r0,r1
    Brnp COUNT_SPACE ;count spaces
    
    add r5,r5,#1
    COUNT_SPACE
    

    STR r0, r4, #0 ;store the input in the array
    ADD r3, r3, #1 ;count++
    ld r1, ten ;load negative ascii code for ten

    add r1,r3,r1 ;check if it is double digit
    brn DOUBLE_DIGIT ;if it is then count++
    add r2,r2,#1 ;store the 10s digit
    and r3,r3,#0
    
    DOUBLE_DIGIT
    ADD r4, r4, #1 ;go to next index
    add r6,r6,#1 ;count++ of the array size
    BR GETSTRING
EXIT_LOOP

    LEA R0, OUTPUTSTRING ;output string loaded for instruction
    PUTS
    LEA r0, ARRAY ;load array
    puts
    
    lea r0, count1 ;first half of the sentence
    puts
    ld r1, number
    add r0,r2,r2
    BRz ZERO ;if the first number is zero, do not print
    add r0,r1,r2 ;if two digits, load the 10s
    out
    ZERO
    
    add r0,r1,r3 ;the 1s of the digit
    out
    
    lea r0, count2 ;finish the sentence
    puts

    lea r0, sentence_1 ;first part of the sentence
    puts

    ld r3, ten ;load negative ascii code for ten
    ld r1, number ;ascii value for 0, which is 48
    and r4,r4,#0 ;initialise registers
    and r2,r2,#0
    STILL_LEFT_0
    add r2,r3,r5 ;check if the remainder is still double digit
    brn NOT_TWO_DIGIT_0
    add r4,r4,#1 ;count the 10s
    add r5,r3,r5 ;subtract 10 from the count
    add r2,r3,r5 ;subtract again to see if it is still double digit
    brp STILL_LEFT_0
    add r0,r4,r1 ;output the 10s of the count
    out
    
    NOT_TWO_DIGIT_0

    add r0,r1,r5 ;output the 1s of the count
    out

    lea r0, space_string ;finish the sentence for space count
    puts

    and r2,r2,#0 ;initialise registers
    and r5,r5,#0
    lea r4, ARRAY ;load the array into the register
COUNTLETTERS
    ldr r0, r4, #0 ;load the value at current index into r0
    ld r1, upper_A
    add r1,r1,r0 ;check to see if item is bigger than uppercase letter A
    BRn EXIT_CONDITION
    ld r1, upper_Z ;check to see if item is smaller than upper case Z
    add r1,r1,r0
    brp UPPER_Z
    add r2,r2,#1 ;if it is in range between A and Z, it is a upper case letter and add to count
    UPPER_Z
    
    ld r1, lower_a
    add r1,r1,r0 ;check to see if the item is bigger than the lower case a
    brn EXIT_CONDITION
    ld r1, lower_z
    add r1,r1,r0 ;check to see if the item is smaller than the lower case z
BRp EXIT_CONDITION
    add r5,r5,#1 ; if the item is in range between a and z, it is a lower case letter, count++
EXIT_CONDITION


    add r4,r4,#1 ; go to the next array item
    add r6,r6,#-1 ;subtract 1 from the size of the loop
    brz EXIT
    BR COUNTLETTERS
EXIT


    lea r0, sentence_1 ;print first half of the sentence
    puts
    and r4,r4,#0 ;initialise the register
    ld r3, ten ;load negative ascii value for ten
    ld r1, number ;load #48 which is the value for 0
    STILL_LEFT
    add r6,r3,r2 ;;check if the remainder is still double digit
    brn NOT_TWO_DIGIT
   
    add r4,r4,#1; add count for 10s
    add r2,r3,r2 ;subtract 10 from the count
    add r6,r3,r2 ;check if it is still double digit
    brp STILL_LEFT
    
    
    add r0,r4,r1 ;load the 10s digit of the count
    out

    NOT_TWO_DIGIT

    add r0,r1,r2 ;load the 1s digit of the count
    out
    lea r0, upper_string ;end the sentence for the upper case count
    puts

    lea r0, sentence_1 ;print first half of the sentence
    puts
    and r4,r4,#0 ;initialise the register
    STILL_LEFT_2
    add r6,r3,r5 ;check if the remainder is still double digit
    brn NOT_TWO_DIGIT_2
    
    add r4,r4,#1 ;count++ for 10s
    add r5,r3,r5 ;subtract 10 from the count
    add r6,r3,r5 ;check if it is still double digit
    brp STILL_LEFT_2
    
    
    add r0,r4,r1 ;print 10s digit of the count
    out

    NOT_TWO_DIGIT_2

    
    add r0,r1,r5 ;print 1st digit of the count
    out
    lea r0, lower_string
    puts



HALT


ARRAY .blkw #99 ;array size of 99
NEWLINE_NEG .FILL x-000A ;ascii hex value for the newline feed
upper_A .fill #-65 ;negative ascii value for upper case A
upper_Z .fill #-90 ;negative ascii value for upper case Z
lower_a .fill #-97 ;negative ascii value for lower case a
lower_z .fill #-122 ;negative ascii value for lower case z
ten .fill #-10 ;negative ascii value for tens
number .fill #48 ;ascii value for the 0

SPACE_COUNT .fill x-0020 ;negative ascii value for space


.END
