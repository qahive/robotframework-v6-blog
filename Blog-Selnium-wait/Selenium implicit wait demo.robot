*** Settings ***
Library    SeleniumLibrary    implicit_wait=2

*** Test Cases ***
Demo Selenium implicit wait
    [Teardown]    Close All Browsers
    Open Browser    https://ajaxsearchpro.com/    browser=chrome
    Maximize Browser Window
    Click Element    css=input[aria-label="Search input 1"]
    Input Text    css=input[aria-label="Search input 1"]    cars
    # This wait will use default wait time equal to 2 seconds that we define when import library
    Page Should Contain    Lamborghini Urus
