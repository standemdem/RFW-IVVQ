*** Settings ***
resource     resources/keyword.robot
resource    resources/variables.robot
*** Test Cases ***
Aquecoucou
    Log    ${test}
1 J'ouvre le site
    openNewBrowser    ${website_url}