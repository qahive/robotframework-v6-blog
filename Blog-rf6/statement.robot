*** Test Cases ***
Demo if else statement
    Log direction    LEFT
    Log direction    STRAIGHT
    # Log direction    UP

Demo new for loop
    @{List}    Create List    LEFT    RIGHT
    FOR    ${element}    IN    @{LIST}
        Log    ${element}
        Log direction    ${element}
    END

Demo new while loop
    ${count}    Set Variable    3
    WHILE    ${count} > 0
        Log    This is run limit to 3 times.
        ${count}    Evaluate    ${count} - 1
    END

Demo break and continue
    FOR    ${x}    IN RANGE    30
        IF    ${x} > 10            BREAK
        Log    Executed only when ${x} < 11
        IF    ${x} % 2 == 0            CONTINUE
        Log    Executed only when ${x} is odd.
    END

Demo return value
    ${is adult}    Is adult by age    12
    Log    ${is adult}

Demo Try Except
    TRY
        Log    ${not existing variable}
    EXCEPT
        Log    found error
    FINALLY
        Log    always log
    END


*** Keywords ***
Log direction
    [Arguments]    ${direction}
    IF    "${direction}" == "STRAIGHT"
        Log    Going straight
    ELSE IF    "${direction}" == "LEFT"
        Log    Turning left
    ELSE IF    "${direction}" == "RIGHT"
        Log    Turning right
    ELSE
        Fail    Unrecognized direction: ${direction}
    END

Is adult by age
    [Arguments]    ${age}
    IF    ${age} >= 18
        Log    Adult
        RETURN    Adult
    ELSE
        RETURN    Children
    END
