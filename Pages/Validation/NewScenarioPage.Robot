*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ../../TestData/CommonData.robot
Resource    ../Common.robot
Resource    ScenarioDetailsPage.robot

*** Variables ***
${lbl_typeOf}                  xpath=//span[normalize-space()='Warranty']
${list_typeOfClaim}            id=claimJobTypeId
${bl_brand}                    xpath=//span[normalize-space()='UD']
${chx_callingSystemAll}        xpath=//input[@formcontrolname='callingSystemCheckAll']
${chx_situationNoAll}          xpath=//input[@formcontrolname='callSystSituationCheckAll']
${chx_importerAll}             xpath=//input[@formcontrolname='importerIdCheckAll']
${chx_dealerAll}               xpath=//input[@formcontrolname='dealerIdCheckAll']
${btn_saveCheckScenario}       id=saveCheckScenario
${txt_name}                    id=name
${txt_description}             id=description
${txt_callingSystem}           id=callingSystem
${txt_callSystSituation}       id=callSystSituation
${txt_importerId}              id=importerId
${txt_dealerId}                id=dealerId
${repairedate_from}            xpath=//udcp-date-picker[@dateformcontrolname='repairDateFrom']//span[@class='k-icon k-i-calendar']
${repairedate_to}              xpath=//udcp-date-picker[@dateformcontrolname='repairDateTo']//span[@class='k-icon k-i-calendar']
${regdate_from}                xpath=//udcp-date-picker[@dateformcontrolname='regDateFrom']//span[@class='k-icon k-i-calendar']
${regdate_to}                  xpath=//udcp-date-picker[@dateformcontrolname='regDateTo']//span[@class='k-icon k-i-calendar']
${list_typeOfUpdateId}         id=typeOfUpdateId
${list_typeOfCheckId}          id=typeOfCheckId
${list_organizationLevelId}    id=organizationLevelId

*** Keywords ***
Validate new-sceanrio page elements
    Wait Until Element Is Visible    ${lbl_typeOf}
    Element Should Be Visible        ${list_typeOfClaim}
    Element Should Be Visible        ${bl_brand} 
    Checkbox Should Be Selected      ${chx_callingSystemAll} 
    Checkbox Should Be Selected      ${chx_SituationNoAll}
    Checkbox Should Be Selected      ${chx_importerAll}
    Checkbox Should Be Selected      ${chx_dealerAll} 
    Element Should Be Disabled       ${btn_saveCheckScenario}

Validate new-sceanrio page mandantory fields
    Input Text                    ${txt_name}                 AutoTestSC
    Element Should Be Disabled    ${btn_saveCheckScenario}
    Input Text                    ${txt_description}          testdesc
    #Clear Element Text            ${txt_name}
    Element Should Be Enabled     ${btn_saveCheckScenario}
    UnSelect Checkbox             ${chx_callingSystemAll} 
    Element Should Be Disabled    ${btn_saveCheckScenario}
    Select Checkbox               ${chx_callingSystemAll}
    UnSelect Checkbox             ${chx_SituationNoAll}
    Element Should Be Disabled    ${btn_saveCheckScenario}
    Select Checkbox               ${chx_situationNoAll}
    UnSelect Checkbox             ${chx_dealerAll}
    Element Should Be Disabled    ${btn_saveCheckScenario}
    Select CheckBox               ${chx_dealerAll}
    UnSelect CheckBox             ${chx_importerAll}
    Element Should Be Disabled    ${btn_saveCheckScenario}
    Select CheckBox               ${chx_importerAll}
    Element Should Be Enabled     ${btn_saveCheckScenario}

New scenario with valid data entered
    Get DealerId and ImportorId Combination
    ${name}                                    Generate Random String         length=6
    ${name}=                                   Catenate                       SEPARATOR=       Auto    ${name}
    Log                                        ${name}
    Wait Until Element Is Visible              ${txt_name}
    Input Text                                 ${txt_name}                    ${name}
    Input Text                                 ${txt_description}             testdesc
    Select From List By Index                  ${list_typeOfClaim}            1
    UnSelect Checkbox                          ${chx_callingSystemAll}
    Input Text                                 ${txt_callingSystem}           ${name}
    UnSelect Checkbox                          ${chx_SituationNoAll}
    Input Text                                 ${txt_callSystSituation}       12345
    UnSelect Checkbox                          ${chx_dealerAll}
    Input Text                                 ${txt_dealerId}                ${DealerId}
    UnSelect Checkbox                          ${chx_importerAll}
    Input Text                                 ${txt_importerId}              ${ImportorId}
    Set Calendar Value to Today                ${repairedate_from}
    Set Calendar Value to Today                ${repairedate_to}
    Set Calendar Value to Today                ${regdate_from}
    Set Calendar Value to Today                ${regdate_to}
    Select From List By Index                  ${list_typeOfUpdateId}         1
    Select From List By Index                  ${list_typeOfCheckId}          1
    Select From List By Index                  ${list_organizationLevelId}    1
    Click button                               ${btn_saveCheckScenario}
    Wait Until Page Does Not Contain           Loading
    ELement Should Be Visible                  ${btn_deleteCheckScenario}
    Element Should Be Visible                  ${btn_viewChecks}

New scenario by name
    [Arguments]                         ${arg_name}     ${arg_desc}
    Wait Until Element Is Visible       ${txt_name}
    Input Text                          ${txt_name}                 ${arg_name}
    Input Text                          ${txt_description}          ${arg_desc}
    UnSelect Checkbox                   ${chx_callingSystemAll}
    Input Text                          ${txt_callingSystem}        ${arg_name}
    Click button                        ${btn_saveCheckScenario}
    Wait Until Page Does Not Contain    Loading

New scenario by name and typeOfClaim
    [Arguments]   ${arg_name}   ${arg_type}
    Wait Until Element Is Visible       ${txt_name}
    Input Text                          ${txt_name}                 ${arg_name}
    Input Text                          ${txt_description}          ${arg_name}
    Select From List By Label           ${list_typeOfClaim}         ${arg_type}
    UnSelect Checkbox                   ${chx_callingSystemAll}
    Input Text                          ${txt_callingSystem}        ${arg_name}
    Click button                        ${btn_saveCheckScenario}
    Wait Until Page Does Not Contain    Loading
    









