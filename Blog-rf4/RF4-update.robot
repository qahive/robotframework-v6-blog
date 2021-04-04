*** Settings ***
Library    Collections


*** Test Cases ***
Native if else statement
    ${input}    Set Variable    ${10}
    IF    ${input} == ${10}
        LOG    Match
    ELSE
        LOG    Not match
    END

Native if else and elsif statement
    ${input}    Set Variable    ${12}
    IF    ${input} < ${10}
        LOG    Less than 10
    ELSIF    ${input} > ${15}
        LOG    Greater than 15
    ELSE
        LOG    Not in range
    END

Nested control structure
    @{row 1} =    Create List    1    2    3
    @{row 2} =    Create List    4    5    
    @{rows} =    Create List    ${row 1}    ${row 2}    
    FOR    ${row}    IN    @{rows}
        FOR    ${cell}    IN    @{row}
            IF    ${cell} > 3 
                LOG    Match
            END
        END
    END

Skip status
    Skip    No validation

Skil with if condition
    ${input} =    Set Variable    ${20}
    Skip If    ${input} > ${15}

List and dictionary expansion with item access
    @{items} =    Create List    a    b    c
    &{var} =   Create dictionary    items=${items}
    FOR    ${item}    IN    @{var}[items]
        Log    ${item}
    END
