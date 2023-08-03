*** Settings ***
resource     resources/keyword.robot
resource    resources/variables.robot
*** Test Cases ***
1 J'ouvre le site
    openNewBrowser    ${website_url}
    Sleep    3
    keyword.closeBrowser