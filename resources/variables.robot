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

${email}   
${mot de passe} 
${Telephone} 
${password} 
${FirstName}
${LastName}
${adress} 
${ZIP Code} 
${Town}



#################################################################
#########             SEARCH AND SELECT                   #######
#################################################################
${quantity}=    120
