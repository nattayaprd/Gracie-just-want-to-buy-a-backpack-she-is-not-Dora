*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# --- Configuration ---
${URL}    https://www.saucedemo.com/
${browser}    chrome

# --- Test Data ---
${username}    problem_user
${password}    secret_sauce
${firstname}    Gracie
${lastname}    Abrams
${postalcode}    20160
${total_price}    5    


# --- Locators ---
${username_field}        id=user-name
${password_field}        id=password  
${login_button}        id=login-button  
${shoppingcart_button}    id=shopping_cart_container 
${add_saucelabs_backpack}    id=add-to-cart-sauce-labs-backpack
${checkoutpage_saucelabs_backpack_name}    //div[contains(text(), 'Sauce Labs Backpack')]
${checkout_button}        id=checkout
${header_your_information_page}        //span[contains(text(), 'Checkout: Your Information')]
${firstname_field}    id=first-name
${lastname_field}        id=last-name      
${postalcode_field}        id=postal-code   
${continue_button}        id=continue             


*** Keywords ***
Open Browser and Go to Secretsauce
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --incognito
    Call Method    ${chrome_options}    add_argument    --disable-autofill-client-side
    Call Method    ${chrome_options}    add_argument    --disable-save-password-bubble
    Open browser        ${URL}      ${browser}      options=${chrome_options}
    Wait Until Element Is Visible       ${username_field}  

Input Username and Password
    Input Text        ${username_field}   ${username}
    Input Text        ${password_field}    ${password}

Click Login button
    Click Element       ${login_button}    

Landing to shopping page
    Wait Until Element Is Visible        ${shoppingcart_button}

Add Saucelabs Backpack To The Shopping Cart
    Click Element        ${add_saucelabs_backpack}

Click on Shopping Cart Button
    Click Element       ${shoppingcart_button} 

Verify that Saucelabs Backpack was Added to Cart
    Wait Until Element Is Visible    ${checkoutpage_saucelabs_backpack_name}  

Click "Check Out" button to go to "Your Information" Page
    Click Element        ${checkout_button}
    Wait Until Element Is Visible        ${header_your_information_page}

Input Your Information
    Sleep    5s
    Execute Javascript    document.getElementById('first-name').value='${firstname}';document.getElementById('first-name').dispatchEvent(new Event('input',{bubbles: true}));
    Sleep    5s
    Execute Javascript    document.getElementById('last-name').value='${lastname}';document.getElementById('last-name').dispatchEvent(new Event('input',{bubbles: true}));
    Sleep    5s
    Execute Javascript    document.getElementById('postal-code').value='${postalcode}';document.getElementById('postal-code').dispatchEvent(new Event('input',{bubbles: true}));
    Sleep    10s

# Input Your Information
#     Wait Until Element Is Visible        ${firstname_field}    10s
#     Click Element        ${firstname_field}
#     Clear Element Text     ${firstname_field}    
#     Input Text        ${firstname_field}        ${firstname}
#     Sleep    2s

#     Wait Until Element Is Visible        ${lastname_field}    10s
#     Click Element        ${lastname_field}
#     Clear Element Text    ${lastname_field}
#     Input Text        ${lastname_field}        ${lastname}
#     Sleep    2s

#     Wait Until Element Is Visible        ${postalcode_field}    10s
#     Click Element        ${postalcode_field}
#     Clear Element Text    ${postalcode_field}
#     Input Text        ${postalcode_field}        ${postalcode}
#     Sleep    2s

Click on 'Continue' button
    Click Element    ${continue_button}      
    

*** Test Cases ***
TC-01 Verify that User can Login Successfully with Username and Password which is contained in the system
    Open Browser and Go to Secretsauce
    Input Username and Password
    Click Login button
    Landing to shopping page

TC-02 Verify that User can Add One Item To The Shopping cart
    Add Saucelabs Backpack To The Shopping Cart
    Click on Shopping Cart Button
    Verify that Saucelabs Backpack was Added to Cart

TC-03 Verify that User can go to Your Information Page after Clicking "Checkout" button
    Click "Check Out" button to go to "Your Information" Page

TC-04 Verify that User can Input an information in each field and can Click 'Continue'
    Input Your Information
    Click on 'Continue' button