*** Settings ***
Library    SeleniumLibrary
Resource   ViewChecksPage.robot

*** Variables ***
${url_scenario_details}       scenario-details
${btn_deleteCheckScenario}    id=deleteCheckScenario
${btn_viewChecks}             xpath=//button[normalize-space()='View checks']
${btn_YestoDelete}            xpath=//button[normalize-space()='Yes']
${txt_description}            id=description
${btn_saveCheckScenario}      id=saveCheckScenario
${txt_name}                   id=name
${chx_copyChecks}             id=copyChecks
${txt_callingSystem}          id=callingSystem
${chx_callingSystemAll}       xpath=//input[@formcontrolname='callingSystemCheckAll']


*** Keywords ***
Delete scenario
    Location Should Contain          ${url_scenario_details}
    Wait Until Element Is Visible    ${btn_deleteCheckScenario}
    Click button                     ${btn_deleteCheckScenario}
    Page Should Contain              Are you sure you want to delete this item?
    Wait Until Element Is Visible    ${btn_YestoDelete}
    Click button                     ${btn_YestoDelete}

Copy scenario
    #new name to save copy
    ${name}                             Generate Random String                                            length=6
    ${name}=                            Catenate                                                          SEPARATOR=    Auto    ${name}
    Input Text                          ${txt_name}                                                       ${name} 
    Click button                        ${btn_saveCheckScenario}
    Wait Until Page Does Not Contain    Loading
    Page Should Contain                 A check scenario exist by same name, hence could not be saved.
    # update
    UnSelect Checkbox                   ${chx_callingSystemAll}
    Input Text                          ${txt_callingSystem}                                              ${name}
    Click button                        ${btn_saveCheckScenario}
    Wait Until Page Does Not Contain    Loading
    ELement Should Be Visible           ${btn_deleteCheckScenario}

Go to view-checks page
    Wait Until Element Is Visible       ${btn_viewChecks}
    Click button                        ${btn_viewChecks}
    Wait Until Page Does Not Contain    Loading
    Location Should Contain             ${url_viewChecks}

