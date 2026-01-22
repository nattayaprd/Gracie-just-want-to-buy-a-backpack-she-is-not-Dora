*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://web-demo.qahive.com/e-commerce/register
${browser}    chrome
${username}    abcde@test.com
${password}    A12345678_
${total price}    15500

*** Keywords ***
Go to website
    Open browser    ${URL}    ${browser}
    Wait Until Element Is Visible    name=email   
Input username and password
    Input Text    name=email    ${username}
    Input Text    name=password    ${password}
Click submit button
    Click Element    xpath=//button[@type="submit"]
Landing to shopping page
    Wait Until Element Is Visible    xpath=//div[contains(.,'Travel Bag')]/button[contains(text(),'Add to cart')]
Add Travel bag to cart
    Click Element    xpath=//div[contains(.,'Travel Bag')]/button[contains(text(),'Add to cart')]
Add Apple Watch to cart
    Click Element    xpath=//div[contains(.,'Apple Watch')]/button[contains(text(),'Add to cart')]
Click to check the cart
    Click Link    /e-commerce/checkout   
    Wait Until Element Is Visible    xpath=//button/strong[contains(text(),'Payment')]
Check total price
    Wait Until Element Is Visible    xpath=//p[contains(text(),'${total price}')]

*** Test Cases ***
TC 01 Login Successfully
    Go to website
    Input username and password
    Click submit button
    Landing to shopping page
    Add Travel bag to cart
    Add Apple Watch to cart
    Click to check the cart
    Check total price