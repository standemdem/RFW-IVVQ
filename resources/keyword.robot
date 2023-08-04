*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot
Library    ExcelLibrary
Library    FakerLibrary
Library    Dialogs
*** Keyword *** 
                    #################################################################
                    #########             BROWSER MANAGEMENT                  #######
                    #################################################################
openNewBrowser
    [Arguments]    ${url}    ${browser}    ${x_path}
    Open Browser    ${url}    ${browser}
    # close cookies popup window
    Click Element    ${x_path}
    Maximize Browser Window
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


                    #################################################################
                    #########             CREATE PROFILE                      #######
                    #################################################################
Scroll To Element
    [Arguments]  ${locator}
    ${x}=        Get Horizontal Position  ${locator}
    ${y}=        Get Vertical Position    ${locator}
    Execute Javascript  window.scrollTo(${x}, ${y})

Scenario Cas_passant
        ${email}=    Email 
        ${mot de passe} =    Password
        ${Telephone}  Phone Number
        ${password} =    Password
        ${FirstName} =    First Name
        ${LastName} =    Name Male
        ${adress} =    Address
        ${ZIP Code} =  Postcode
        ${Town} =    City
        [Arguments]   ${email}    ${mot de passe}    ${FirstName}    ${LastName}    ${Telephone}    ${adress}    ${ZIP Code}    ${Town}
        Click Element   xpath=/html/body/div[4]/div[2]/button
        Sleep   1
        Click Button    xpath=//*[@id="dropdown-account"]/button
        Sleep  2
        Click Button    xpath=//*[@id="redirectCreateAccount"] 
        Sleep   2
        Click Element   xpath=//*[@id="userInfoForm"]/div/fieldset/div[2]/label/span
        Sleep     2
        Input Text    xpath=//*[@id="IdentifiersLogin"]    ${email}
        Sleep    2
        Input Text    xpath=//*[@id="NewPwdPassword"]    ${mot de passe}
        Sleep    2
        Click Element    xpath=//*[@id="civilitie"]/option[3]
        Sleep    2
        Input Text    xpath=//*[@id="InfoFirstname"]    ${FirstName}
        Sleep    2
        Input Text    xpath=//*[@id="InfoLastname"]    ${LastName}
        Sleep    3
        Input Text    xpath=//*[@id="directPhone"]    ${Telephone}
        Sleep    2
        Click Button    xpath=//*[@id="nextStepBtn"]
        Sleep    2
        Input Text    xpath=//*[@id="CompaniesAddress"]     ${adress}
        Sleep    1
        Input Text    xpath=//*[@id="CompaniesPostCode"]    ${ZIP Code}
        Sleep    2
        Input Text    xpath=//*[@id="CompaniesCity"]    ${Town}
        Sleep    2
        Execute Manual Step    Please complete the CAPTCHA portion of the form.
        Sleep    2
        Click Element    xpath=//*[@id="submitAllForm"]
        sleep    2

                    #################################################################
                    #########             SEARCH /FILTER PRODUCT              #######
                    #################################################################

get_user_excel
    [Arguments]    ${file_name}    ${sheet_name}
    Open Excel Document    ${file_name}   ${sheet_name}
    ${email}=    Read Excel Cell    2    3
    ${pwd}=    Read Excel Cell    2    4
    Log To Console    ${email} ${pwd}
    [Return]    ${email}    ${pwd}
    Close All Excel Documents
        
get_col_values
    [Arguments]    ${file}    ${sheet}    ${col}
    Open Excel Document    ${file}     ${sheet}
    @{col_values}=    Read Excel Column    ${col}
    Log To Console    ${col_values}
    Close All Excel Documents
    RETURN    @{col_values}

create_excel_object
    @{short_name}=    get_col_values    ${excel_file}    produit    2
    @{goal_name}=    get_col_values    ${excel_file}    produit    3
    @{categorie}=    get_col_values    ${excel_file}    produit    5
    @{sous catégorie1}=    get_col_values    ${excel_file}    produit   6 
    @{sous catégorie2}=    get_col_values    ${excel_file}    produit    7
    @{Bon Plans}=    get_col_values    ${excel_file}    produit    8
    @{Marque}=    get_col_values    ${excel_file}    produit    9
    @{Matiére}=    get_col_values    ${excel_file}    produit    10
    @{Longueur}=    get_col_values    ${excel_file}    produit    11
    @{Largeur}=    get_col_values    ${excel_file}    produit    12
    @{Diamètre}=    get_col_values    ${excel_file}    produit    13
    @{Couleur}=    get_col_values    ${excel_file}    produit    14
    @{Nouveaux produits}=    get_col_values    ${excel_file}    produit    15
    @{Type de fermeture}=    get_col_values    ${excel_file}    produit    16
    @{Epaisseur}=    get_col_values    ${excel_file}    produit    17
    @{Adapté au contact alimentaire}=    get_col_values    ${excel_file}    produit    18
    @{Cannelure}=    get_col_values    ${excel_file}    produit    19
    RETURN    ${short_name}    ${categorie}    ${sous catégorie1}    ${sous catégorie2}     ${Bon Plans}    ${Marque}    ${Matiére}    ${Longueur}    ${Largeur}    ${Diamètre}       ${Type de fermeture}    ${Epaisseur}    ${Nouveaux produits}     ${Couleur}    ${Adapté au contact alimentaire}    ${Cannelure}

change_quantity
    [Arguments]    ${qty}
    Press Key    //*[@id="articleQuantity"]    \\1   
    Press Key    //*[@id="articleQuantity"]    \\127
    Press Key    //*[@id="articleQuantity"]    ${qty}