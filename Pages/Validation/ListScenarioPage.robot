*** Settings ***
Library     SeleniumLibrary
Resource    ScenarioDetailsPage.robot


*** Variables ***
${btn_search}            xpath=//button[normalize-space()='Search']
${txt_name}              id=name
${top1_scenario_name}    css=tbody tr:nth-child(1) td:nth-child(1)
${top1_scenario_desc}    css=tbody tr:nth-child(1) td:nth-child(2)
${top1_scenario_copy}    css=tbody tr:nth-child(1) td:nth-child(9) div:nth-child(1) span:nth-child(1)


*** Keywords ***
Search check scenario by Name
    [Arguments]                         ${arg_name}
    Wait Until Element Is Visible       ${txt_name}
    Input Text                          ${txt_name}      ${arg_name}
    Click button                        ${btn_search}
    Wait Until Page Does Not Contain    Loading

Open Frist scenario
    #TRY
    Wait Until Page Does Not Contain    Loading
    Wait Until Element Is Visible    ${top1_scenario_name}
    Click Element                    ${top1_scenario_name} 
    #EXCEPT
    #Log                              No records available
    #END

Click copy of first scenario
    Wait Until Element Is Visible    ${top1_scenario_copy}
    ${top1_desc_value}               Get Text                    ${top1_scenario_desc}
    Click Element                    ${top1_scenario_copy}
    Location Should Contain          ${url_scenario_details}
    Wait Until Element Is Visible    ${txt_description}
    # Assert Page
    #Element Text Should Be           ${txt_description}          ${top1_desc_value}
    Element Attribute Value Should Be  ${txt_description}   value       ${top1_desc_value}
    Element Text Should Be           locator=${txt_name}         expected=       
    Element Should Be Disabled       ${btn_saveCheckScenario}
    Page Should Contain Element      ${chx_copyChecks}






