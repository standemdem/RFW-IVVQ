*** Settings ***
Library    FakerLibrary
Library    ExcelLibrary
*** Variables ***
#################################################################
#########             BROWSER MANAGEMENT                  #######
#################################################################
${url}=    https://www.raja.fr/
${browser}=    Chrome

#################################################################
#########             XPATH MANAGEMENT                    #######
#################################################################
${cookie_xpath}=    xpath=/html/body/div[4]/div[2]/button
${connexion_popup}=    xpath=//*[@id="dropdown-account"]/button

#################################################################
#########             AUTHENTIFICATION                    #######
#################################################################
${excel_file}=   ${CURDIR}\\raja.xlsx
${valid_user}=    stan.demontmarin@gmail.com
${valid_pwd}=    Ajcformation08
${unvalid_user}=    unvalid
${unvalid_pwd}=    Ajcformation08


@{products}=    Ruban    Sachet    Colis    Carton