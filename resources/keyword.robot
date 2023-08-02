*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot
*** Keyword *** 
openNewBrowser
    [Arguments]    ${url}
    Open Browser    ${url}    Chrome
closeBrowser
    Close All Browsers