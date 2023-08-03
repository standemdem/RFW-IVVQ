*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot
*** Keyword *** 
                    #################################################################
                    #########             BROWSER MANAGEMENT                  #######
                    #################################################################
openNewBrowser
    [Arguments]    ${url}    ${browser}    ${x_path}
    Open Browser    ${url}    ${browser}
    # close cookies popup window
    Click Element    ${x_path}
    Sleep    1
closeBrowser
    Close All Browsers
    

                    #################################################################
                    #########             AUTHENTIFICATION                    #######
                    #################################################################
openConnectionPopup
    [Arguments]    ${xpath}
    Click Element    ${xpath}
    Sleep    2  
   

connectUser
    [Arguments]    ${email}    ${pwd}
    Input Text    xpath=//*[@id="UserLoginDropdown"]    ${email}
    Sleep    1.2
    Input Text    xpath=//*[@id="UserPasswordDropdown"]    ${pwd}
    Sleep    2
    Click Element    xpath=//*[@id="dropdownConnexion"]/div[3]/button
    Sleep    3


Ouverture pour user invalide
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window  
    Sleep    2
    Click Element    xpath=/html/body/div[4]/div[2]/div/button[2] 
    Sleep    2  
   
User Invalid
    Click Button    xpath=//*[@id="dropdown-account"]/button
    Sleep    2
    Input Text    xpath=//*[@id="UserLoginDropdown"]    ${Email_invalid}
    Sleep    2
    Input Password    xpath=//*[@id="UserPasswordDropdown"]    ${mdp}
    Sleep    2
    Click Button    xpath=//*[@id="dropdownConnexion"]/div[3]/button
    Sleep    2
    Click Element    xpath=//*[@id="dropdown-block"]/section/a[9]
    Sleep    2

Création d’un profil
    Click Button    xpath=//*[@id="dropdown-account"]/button
    Sleep    2
    Click Button    xpath=//*[@id="redirectCreateAccount"]
    Sleep    2
    ${email}=       FakerLibrary.email    /html/body/main/div/section[2]/div[2]/div[1]/form/div/div[2]/div/fieldset/input
    Log To Console    ${email}
    Sleep    2
   


    Sleep    2

#CREATE A NEW USER case: valid credentials
New_USER with valid credentials
    # open    Browser    ${website_url}
    Sleep        20
    Click Element   xpath=/html/body/div[4]/div[2]/button
    Sleep   5
    Click Button    xpath=//*[@id="dropdown-account"]/button
    Sleep  6
    Click Button    xpath=//*[@id="redirectCreateAccount"] 
    Sleep   4
    Click Element   xpath=//*[@id="userInfoForm"]/div/fieldset/div[2]/label/span
    Sleep     6