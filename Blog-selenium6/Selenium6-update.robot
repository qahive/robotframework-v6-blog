*** Settings ***
Library     SeleniumLibrary


*** Test Cases ***
Demo chain locator
    Open Browser    https://demoqa.com/books    browser=chrome
    Maximize Browser Window
    Input Text    id:searchBox-wrapper >> css:input    JavaScript
    Sleep    3s
    ${book name} =    Get Text    xpath://div[@role="rowgroup"][1] >> css:a
    Should Contain    ${book name}    JavaScript
