*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
# --- Configuration ---
${URL}    https://www.saucedemo.com/
${browser}    chrome

# --- Test Data ---
${username}    standard_user
${password}    secret_sauce
${firstname}    Gracie
${lastname}    Abrams
${postalcode}    20160
${backpack_price}    29.99
${backpack_tax_for_check}    2.40
${backpack_price_with_tax}    32.39    


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
${lct_fulltext_backpack_price}    //div[@class='inventory_item_price'] 
${lct_total_price_checkout}    //div[@class='summary_total_label'] 
${finish_button}    id=finish 
${thank_you_header}        //h2[@class='complete-header']
${back_home_button}        id=back-to-products      


*** Keywords ***
Open Browser and Go to Secretsauce
    Open browser        ${URL}      ${browser}    options=add_argument("--incognito")
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
    Wait Until Element Is Visible        ${firstname_field}    10s
    Click Element        ${firstname_field}  
    Input Text        ${firstname_field}        ${firstname}
    Sleep    1s

    Wait Until Element Is Visible        ${lastname_field}    10s
    Click Element        ${lastname_field}
    Input Text        ${lastname_field}        ${lastname}
    Sleep    1s

    Wait Until Element Is Visible        ${postalcode_field}    10s
    Click Element        ${postalcode_field}
    Input Text        ${postalcode_field}        ${postalcode}
    Sleep    1s

Click on 'Continue' button
    Click Element    ${continue_button}      
    
Verify price of a backpack, tax and total price
    ${fulltext_backpack_price}=    Get Text    ${lct_fulltext_backpack_price}
    ${backpack_price_only}=    Remove String     ${fulltext_backpack_price}    $ 
    ${tax}=    Evaluate    float(${backpack_price_only}) * 0.08
    Should Be Equal As Numbers    ${backpack_tax_for_check}    ${tax}    precision=2  
    Should Be Equal As Numbers    ${backpack_price_only}    ${backpack_price}
    ${total_price_checkout}=    Get Text    ${lct_total_price_checkout}
    ${total_price_checkout_wo_string}=    Remove String    ${total_price_checkout}    Total:    $          
    Should Be Equal As Numbers   ${backpack_price_with_tax}    ${total_price_checkout_wo_string}  

Click on 'Finish' button
    Click Element    ${finish_button}   

Verify that User lands to page Checkout
    Wait Until Element Is Visible    ${thank_you_header} 
    Page Should Contain Button        ${back_home_button} 

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

TC05- Verify that system display total price correctly
    Verify price of a backpack, tax and total price

TC06- Verify that User make an order succesfully
    Click on 'Finish' button
    Verify that User lands to page Checkout  
    
