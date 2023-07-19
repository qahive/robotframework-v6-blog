*** Settings ***
Library         RPA.Email.ImapSmtp    smtp_server=smtp.ethereal.email    smtp_port=587

Test Setup      Authorize    account=${EMAIL_ACCOUNT}    password=${EMAIL_PASSWORD}


*** Variables ***
${EMAIL_ACCOUNT}        yessenia36@ethereal.email
${EMAIL_PASSWORD}       qSr3DGDVK8WmrQQvKQ


*** Test Cases ***
Read email from ethereal email
    @{EMAILS}    Wait For Message    SUBJECT "rpa task"    timeout=300    interval=10
    FOR    ${email}    IN    @{EMAILS}
        Log    ${email}[Subject]
        Log    ${email}[From]
        Log    ${email}[Date]
        Log    ${email}[Delivered-To]
        Log    ${email}[Received]
        Log    ${email}[Body]
    END
