*** Settings ***
Library     Collections


*** Test Cases ***
Demo vs code ide hello world
    ${name} =    Set Variable    Art
    Log    Hello world ${name}
