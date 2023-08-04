*** Settings ***
Library    FakerLibrary    locale=fr_FR
resource   resources/keyword.robot
resource   resources/variables.robot
Library    ExcelLibrary
Library    XML
Library    Dialogs
Library    Collections
Test Setup    openNewBrowser    ${url}    ${browser}    ${cookie_xpath}

*** Test Cases ***
    
#################################################################
#########             AUTHENTIFICATION                    #######
#################################################################

1 Check Auth with missing credentials
    openConnectionPopup    ${connexion_popup}
    connectUser    ""    ""
    ${error_msge}=    Get Text    xpath=//*[@id="dropdownConnexion"]/div[1]/fieldset/div[1]/label
    Log To Console    ${error_msge}
    IF    '${error_msge} == Information obligatoire'
        Log To Console   ----------------TEST SUCCESSFULL----------------
    END
    keyword.closeBrowser

2 Check Auth with unvalid credentials
    openConnectionPopup    ${connexion_popup}
    connectUser    ${unvalid_user}    ${unvalid_pwd}
    ${error_msge}=    Get Text    xpath=//*[@id="dropdownConnexion"]/div[3]/span
    Log To Console    ${error_msge}
    IF    '${error_msge} == Couple login/mot de passe invalide'
        Log To Console   ----------------TEST SUCCESSFULL----------------
    END
    keyword.closeBrowser
    
3 Check Auth with valid credentials
    openConnectionPopup    ${connexion_popup}
    connectUser    ${valid_user}    ${valid_pwd}
    ${class}=    Get Element Attribute    xpath=//*[@id="dropdown-account"]    class
    Should Contain    ${class}    is-connected

                    #################################################################
                    #########             CREATE PROFILE                      #######
                    #################################################################
#CREATE A NEW USER case: valid credentials
New_USER with valid credentials
    [Tags]    N01
    ${email}=    Email   
    ${mot de passe} =    Password
    ${Telephone}  Phone Number
    ${password} =    Password
    ${FirstName} =    First Name
    ${LastName} =    Name Male
    ${adress} =    Address
    ${ZIP Code} =  Postcode
    ${Town} =    City

    openConnectionPopup    ${connexion_popup}
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
   
    Close All Browsers

                    #################################################################
                    #########             SEARCH /FILTER PRODUCT              #######
                    #################################################################

6 test automatisation
    [Tags]    N04
    Click Element    xpath=//*[@id="algolia-loader"]
    Sleep    0.5
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
    ${len_short_name}=    Evaluate    len(${short_name})

    FOR    ${index}    IN RANGE    1    2     #${len_short_name}    
        # write in search bar
        Input Text    xpath=//*[@id="searchAlgolia"]/div[1]/section/div/div/input    ${short_name}[${index}]
        Sleep    0.5
        ${exists}=     Run Keyword And Return Status    Page Should Contain Button    xpath=//*[@id="filters-layer-content"]/button
        Run Keyword If    ${exists}    Click Element    xpath=//*[@id="filters-layer-content"]/button

        @{temp1}=     Create List    ${categorie}    ${sous catégorie1}    ${sous catégorie2}     ${Bon Plans}    ${Marque}    ${Matiére}    ${Longueur}    ${Largeur}    ${Diamètre}       ${Type de fermeture}    ${Epaisseur}    ${Nouveaux produits}     ${Couleur}    ${Adapté au contact alimentaire}    ${Cannelure}   
        ${len_temp1}=    Evaluate    len($temp1)

        Sleep    1

        FOR    ${counter}    IN RANGE    0    ${len_temp1}
            ${element_exists} =    Run Keyword And Return Status    Page Should Contain     + Plus
            Run Keyword If    ${element_exists}    Click Element    xpath=//*[contains(text(),'+ Plus')]
            Run Keyword If    "${temp1}[${counter}][${index}]" != "None"    Click Element    xpath=//*[text()='${temp1}[${counter}][${index}]']
            Log To Console    ${short_name}[${index}] ${counter} success 
            Sleep    0.7 
        END
        Click Element    //*[@id="searchAlgolia"]/div[1]/div[1]/div[3]/div[3]/div    #//*[@id="searchAlgolia"]/div[1]/div[1]/div[3]/div[4]/div[1]/article
        
        Sleep     0.5
        # input new qtty
        Press Key    //*[@id="articleQuantity"]    \\1   
        Press Key    //*[@id="articleQuantity"]    \\127
        Press Key    //*[@id="articleQuantity"]    ${quantity}
        Sleep    0.5
        # add to cart
        Click Element    //*[@id="addToCart"]
        Sleep    0.2
        # See cart
        Wait Until Element Is Visible    //*[@id="open-cart-confirmation"]
        Click Element    //*[@id="open-cart-confirmation"] 
        Sleep    0.2
        #Validate cart
        Click Element    //*[@id="nextBtnStep1"]
        Sleep    0.2

    END
    