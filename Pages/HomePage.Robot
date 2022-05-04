*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${menu_claim}            xpath=//a[normalize-space()='Claim']
${new_claim_job}         xpath=//a[normalize-space()='New claim job']
${list_claim_job}        xpath=//a[normalize-space()='List claim jobs']
${menu_validation}       xpath=//a[normalize-space()='Validation']
${new_check_scenario}    xpath=//a[normalize-space()='New check scenario']
${list_check_scenario}   xpath=//a[normalize-space()='List check scenarios']


*** Keywords ***
Go to new-claim-job page
    Mouse Over                       ${menu_claim}
    Wait Until Element Is Enabled    ${new_claim_job}
    Click Element                    ${new_claim_job}

Go to new-check-scenario page
    Mouse Over                          ${menu_validation}
    Wait Until Element Is Visible       ${new_check_scenario}
    Click Element                       ${new_check_scenario}
    Wait Until Page Does Not Contain    Loading
    Page Should Contain                 New check scenario

Go to list-check-scenario page
    Mouse Over                          ${menu_validation}
    Wait Until Element Is Visible       ${list_check_scenario}
    Click Element                       ${list_check_scenario}
    Wait Until Page Does Not Contain    Loading
    #Page Should Contain                 Check scenarios

Go to list_claim_jobs page
    Mouse Over                       ${menu_claim}
    Wait Until Element Is Enabled    ${list_claim_job}
    Click Element                    ${list_claim_job}