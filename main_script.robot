*** Settings ***
Library    FakerLibrary    locale=fr_FR
resource     resources/keyword.robot
resource    resources/variables.robot
Library    ExcelLibrary
Library    XML
# Test Setup    openNewBrowser    ${url}    ${browser}    ${cookie_xpath}

*** Test Cases ***
LOGGING TESTS
    ${email}=    Email
    Log To Console   ${email}
    ${phone}=    Phone Number
    Log To Console    ${phone}
    Log To Console    ${products}[0]
    get elem from Excel    ${excel_file}    produit
    get items from Excel    ${excel_file}    produit
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

# 4 Search a Product
    
    # click on search bar to display search popup
    Click Element    xpath=//*[@id="algolia-loader"]
    Sleep    1.8
    # write in search bar
    Input Text    xpath=//*[@id="searchAlgolia"]/div[1]/section/div/div/input    ${products}[0]
    Sleep    0.9
    # select 2nd element
    Click Element     xpath=//*[@id="scroll-horizontal-wrapper"]/div/button[2]
    Sleep    1.3
    Click Element     xpath=//*[@id="searchAlgolia"]/div[1]/div[1]/div[3]/div[3]/div[1]
    Scroll To Element    //*[@id="variations-table-sorters"]
    Sleep    0.7

    Click Element    xpath=//*[@id="btn-quantity-more-3739H4866-desktop"]
    keyword.closeBrowser