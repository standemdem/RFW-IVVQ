*** Settings ***
Library    FakerLibrary    locale=fr_FR
resource     resources/keyword.robot
resource    resources/variables.robot
Test Setup    openNewBrowser    ${url}    ${browser}    ${cookie_xpath}
*** Test Cases ***
LOGGING TESTS
    ${email}=    Email
    Log To Console   ${email}
    ${phone}=    Phone Number
    Log To Console    ${phone}
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