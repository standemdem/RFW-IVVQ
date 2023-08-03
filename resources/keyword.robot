*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot
*** Keyword *** 
# BROWSER MANAGEMENT
openNewBrowser
    [Arguments]    ${url}
    Open Browser    ${url}    Chrome
closeBrowser
    Close All Browsers