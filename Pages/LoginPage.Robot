*** Settings ***
Library     SeleniumLibrary
Resource    ../Parameters/Config.robot
Resource    ../Drivers/DriverInitalization.robot

*** Variables ***
${signInButton}            id=btnLogIn
${usernameInput}           name=userName
${passwordInput}           name=password
${changeLanguageButton}    xpath=//button[normalize-space()='change language']
#${gtopPageHeader}         xpath=//h1[text()='Group Truck Operations'] 

*** Keywords ***
Login with ${arg_user}
    Login    ${username}    password
    Set Test Variable   ${loginUser}    ${arg_user}

Login
    [Arguments]                               ${username}                 ${password}    
    Open browser and go to ${app_url} page
    Wait Until Element Is Enabled             ${usernameInput}
    Input Text                                ${usernameInput}            ${username}
    Input Password                            ${passwordInput}            ${password}
    Click Element                             ${signInButton} 
    # Verification option1: current page contains text 'Logout'
    wait Until Element Is Visible             ${changeLanguageButton} 
    Element Should Be Visible                 ${changeLanguageButton}