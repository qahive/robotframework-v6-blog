*** Settings ***
Library    String    

*** Test Cases ***
Example regex for product amount
    ${product amount} =    Get Regexp Matches    สินค้า หูฟัง v1 ราคา 1,000.50 บาท    ([0-9,]+\.[0-9]{2}) บาท    1
    ${product amount} =    Replace String    ${product amount}[0]    ,    ${EMPTY}
    ${product amount} =    Convert To Number    ${product amount}
    Should Be Equal As Numbers    1000.5    ${product amount}
    
