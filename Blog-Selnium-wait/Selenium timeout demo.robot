*** Settings ***
Library    SeleniumLibrary    timeout=5.0

*** Test Cases ***
Demo Selenium timeout
    [Teardown]    Close All Browsers
    Open Browser    https://ajaxsearchpro.com/    browser=chrome
    Maximize Browser Window
    Wait Until Element Is Visible    css=input[aria-label="Search input 1"]
    Click Element    css=input[aria-label="Search input 1"]
    Input Text    css=input[aria-label="Search input 1"]    cars
    # This wait will use default wait time equal to 5 seconds that we define when import library
    Wait Until Page Contains    Lamborghini Urus
