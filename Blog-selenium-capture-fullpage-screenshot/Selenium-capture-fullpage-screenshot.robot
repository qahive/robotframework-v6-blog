*** Settings ***
Library     SeleniumLibrary
Library     CustomSeleniumLibrary.py


*** Test Cases ***
Demo capture screenshot
    Open Browser
    ...    https://robotframework.org/
    ...    browser=chrome
    Maximize Browser Window
    Capture Page Screenshot
    Capture Fullpage Screenshot
