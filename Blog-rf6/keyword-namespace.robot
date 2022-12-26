*** Settings ***
Resource    demo.resource


*** Test Cases ***
Demo called keyword
    demo.Log msg A    Hello world

Demo called private keyword
    demo.Log msg B    Hello world
