*** Settings ***
Library     SeleniumLibrary
Library     Collections
Resource    ScenarioDetailsPage.robot
Resource    ../../TestData/Validation.robot


*** Variables ***
${url_viewChecks}        view-checks
${lbl_name}              xpath=//div[@class='col-md-9 form-control-plaintext']
${lbl_desc}              xpath=//div[@class='col-md-11 form-control-plaintext']
${txt_allChecks}         xpath=//input[@class='form-control ng-untouched ng-pristine ng-valid']
${txt_selectedChecks}    xpath=//div[3]//input[1]
${list_editItems}        name=edit_items
${list_itemsSelected}    name=items_deselected
${btn_select}            css=button[placement='right']
${btn_deSelect}          css=button[placement='left']
${btn_save}              xpath=//button[normalize-space()='Save']
${lbl_checkNum}          css=body > div:nth-child(1) > udcp-root:nth-child(1) > div:nth-child(2) > ng-component:nth-child(3) > div:nth-child(1) > div:nth-child(2) > validation-view-check-details:nth-child(1) > div:nth-child(1) > form:nth-child(1) > div:nth-child(2) > div:nth-child(1) > dual-multi-select-list-box:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > label:nth-child(1) > span:nth-child(2)
${lbl_slectedNum}        css=body > div:nth-child(1) > udcp-root:nth-child(1) > div:nth-child(2) > ng-component:nth-child(3) > div:nth-child(1) > div:nth-child(2) > validation-view-check-details:nth-child(1) > div:nth-child(1) > form:nth-child(1) > div:nth-child(2) > div:nth-child(1) > dual-multi-select-list-box:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(3) > label:nth-child(1) > span:nth-child(2)

*** Keywords ***
Validate view-checks page
    [Arguments]                   ${arg_name}          ${arg_desc}
    Element Should Be Disabled    ${btn_save}
    Element Should Be Visible     ${lbl_name}
    Element Should Be Visible     ${lbl_desc}
    Element Text Should Be        ${lbl_name}          ${arg_name}
    Element Text Should Be        ${lbl_desc}          ${arg_desc}
    Get Check Num from DB
    Element Text Should Be        ${lbl_checkNum}      ${totalCheckNum}
    Element Text Should BE        ${lbl_slectedNum}    0

Add top2 checks
    Select From List By Index    ${list_editItems}    0
    Click button                 ${btn_select}
    Select From List By Index    ${list_editItems}    0
    Click button                 ${btn_select} 
    Get Check Num from DB
    ${checkedNum}                Evaluate             int(${totalCheckNum})-2
    Element Text Should Be       ${lbl_checkNum}      ${checkedNum}
    Element Text Should BE       ${lbl_slectedNum}    2
    Click button                 ${btn_save}

Filter checks for all checks and selected checks
    Filter checks in list    ${list_editItems}        ${txt_allChecks}
    Reload Page
    Filter checks in list    ${list_itemsSelected}    ${txt_selectedChecks}


Filter checks in list
    [Arguments]                         ${list_locator}    ${txt_locator}
    Wait Until Page Does Not Contain    Loading
    Wait Until Element Is Visible       ${list_locator}
    ${list_value}                       Get List Items     ${list_locator}       
    ${list_firstValue}                  Set Variable       ${list_value[0]} 
    Input Text                          ${txt_locator}     ${list_firstValue}    
    ${result_num}                       Get Match Count    ${list_value}         ${list_firstValue}    
    Should Be Equal As Integers         ${result_num}      1                     

Delete all select checks
    Wait Until Element Is Visible    ${list_itemsSelected}
    Select All From List             ${list_itemsSelected} 
    Click Button                     ${btn_deSelect}
    Wait Until Element Is Enabled    ${btn_save}
    Click Button                     ${btn_save}
    Get Check Num from DB
    Element Text Should Be           ${lbl_checkNum}           ${totalCheckNum}
    Element Text Should BE           ${lbl_slectedNum}         0