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


                    #################################################################
                    #########             SEARCH /FILTER PRODUCT              #######
                    #################################################################

Scroll To Element
    [Arguments]  ${locator}
    ${x}=        Get Horizontal Position  ${locator}
    ${y}=        Get Vertical Position    ${locator}
    Execute Javascript  window.scrollTo(${x}, ${y})

get elem from Excel
    [Arguments]    ${file_name}    ${sheet_name}
    Open Excel Document    ${file_name}   ${sheet_name}
    ${email}=    Read Excel Cell    2    3
    ${pwd}=    Read Excel Cell    2    4
    Log To Console    ${email} ${pwd}
    [Return]    ${email}    ${pwd}
    Close All Excel Documents

get items from Excel
    [Arguments]    ${file}    ${sheet}
    Open Excel Document    ${file}     ${sheet}
    # get all columns in a list
    # get number of columns
    @{option_names}=    Read Excel Row    1
    ${num_of_col}=    Evaluate    len(@{option_names})
    Log To Console    ${option_names} ${num_of_col}
    # get all columns in a list
    # get number of rows
    @{option_values}=    Read Excel Column    1
    ${num_of_rows}=    Evaluate    len(@{option_values})
    Log To Console    ${option_values} ${num_of_rows}
    Close All Excel Documents
        
    # END