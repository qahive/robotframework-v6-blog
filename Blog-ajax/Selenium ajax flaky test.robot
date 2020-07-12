*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Demo selenium flaky test
    Open Browser    http://127.0.0.1:7272/ajax-demo.html    browser=chrome
    Maximize Browser Window
    Input Text    id=idcard    123456789
    Click Element    id=verify
    Wait Until Element Is Not Visible    id=loading
    Click Element    id=submit
    Wait Until Page Contains    Login succeeded
    
