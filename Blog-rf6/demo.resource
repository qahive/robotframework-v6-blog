*** Keywords ***
Log msg A
    [Arguments]    ${text}
    Log    ${text}

Log msg B
    [Tags]    robot:private
    [Arguments]    ${text}
    Log    ${text}
