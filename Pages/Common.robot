*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Keywords ***
Set Calendar Value to Today
    [Arguments]                         ${locator}
    Wait Until Element Is Visible       ${locator}
    Set Focus to Element                ${locator}
    Press Keys                          ${locator}    \ue007
    Wait Until Page Does Not Contain    Loading


Get Today in format mm/dd/yyyy
    ${date}=    Get Current Date    time_zone=UTC    result_format=%#m/%#d/%Y
    Return From Keyword  ${date}

# If spring ${arg} contains ',', remove it, then convert to float
Common_ConvertStrToFloat
    [Arguments]            ${arg}
    ${arg}                 Replace String    ${arg}           search_for=,    replace_with=${empty}
    ${arg}                 Evaluate          float(${arg})
    Return From Keyword    ${arg}