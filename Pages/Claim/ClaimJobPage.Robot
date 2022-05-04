*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     DateTime
Library     String
Resource    ../../TestData/Claim_DB.Robot
Resource    ../../TestData/DBConn.Robot
Resource    NewClaimJobPage.Robot
Resource    ../Common.robot

*** Variables ***
# Url variable
${url_claimjob}    claim/claim-job

#Claim-job default page elements
${txt_referenceNo}              css=div:nth-child(3) div:nth-child(1) div:nth-child(1) div:nth-child(2)
${btn_claimjobsavebtn}          id=claimjobsavebtn
${btn_deleteclaimbtn}           id=deleteclaimbtn
${chb_forced}                   id=forced
${chx_SearchPage_operation1}    id=k-grid0-checkbox0
${chx_SearchPage_operation2}    id=k-grid0-checkbox1
${btn_selectOperation}          xpath=//button[normalize-space()='Select']
${chx_firstVstCheckBox}         id=vst_0
${btn_AddRow}                   xpath=//table[@class='table table-bordered table-striped ng-valid ng-dirty ng-touched']//thead//tr//th//button[@type='button'][normalize-space()='Add row']

# Repair header infomation
${lbl_dealer}      xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
${lbl_importor}    xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[2]

#Remarks tab elements
${tab_remarks}             xpath=//span[normalize-space()='Remarks']
${txt_remarkComplaint}     id=remarkComplaint
${txt_remarkCause}         id=remarkCause
${txt_remarkCorrection}    id=remarkCorrection
${txt_claimComment}        id=claimComment
${txt_internalComment}     id=internalComment

#Labour tab elements
${tab_Labour}                xpath=//span[normalize-space()='Labour']
${btn_labourlinedelete_2}    xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[3]/claim-job-item-labour[1]/form[1]/div[1]/table[1]/tbody[1]/tr[2]/td[9]/button[1]
${btn_labourlinedelete_3}    xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[3]/claim-job-item-labour[1]/form[1]/div[1]/table[1]/tbody[1]/tr[3]/td[9]/button[1]
${btn_YesDeleteLine}         xpath=//button[normalize-space()='YES']
${input_operationNo_1}       id=operationNo_0
${input_operationNo_2}       id=operationNo_1
${input_operationNo_3}       id=operationNo_2
${input_quantity_1}          id=quantity_0
${input_quantity_2}          id=quantity_1
${input_quantity_3}          id=quantity_2
${lbl_net1}                  css=body > div:nth-child(1) > udcp-root:nth-child(1) > div:nth-child(2) > claim-job-page:nth-child(3) > div:nth-child(1) > claim-job:nth-child(1) > div:nth-child(2) > div:nth-child(1) > kendo-tabstrip:nth-child(1) > div:nth-child(2) > claim-job-item:nth-child(1) > div:nth-child(1) > kendo-tabstrip:nth-child(2) > div:nth-child(3) > claim-job-item-labour:nth-child(1) > form:nth-child(1) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(8)
${lbl_net2}                  xpath=//tbody/tr[2]/td[8]
${lbl_nettotal}              css=table[formarrayname='jobLabours'] th[class='text-right ng-star-inserted'] span
${txt_OperationHour1}        id=hours_0
${txt_OperationHour2}        id=hours_1
${txt_OperationHour3}        id=hours_2
${chx_VstCheckBox_2}         id=vst_2
${txt_costPerHour_1}         xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[3]/claim-job-item-labour[1]/form[1]/div[1]/table[1]/tbody[1]/tr[1]/td[7]
${txt_costPerHour_2}         xpath=//tbody/tr[2]/td[7]
${radioBtn_GroupName}        name=operationType
${radioBtn_main_1}           id=operationType_0
${radioBtn_main_2}           id=operationType_1

# Other Costs tab
${tab_othercosts}    xpath=//span[normalize-space()='Other costs']
${txt_qty_1}         xpath=//td[@class='width5']//input[@type='text']
${txt_price_1}       xpath=//td[@class='width10']//input[@name='unitPrice_0']
${txt_desc_1}        xpath=//td[@class='text-nowrap']//input[@name='description_0']
${txt_qty_2}         xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[5]/claim-job-item-other-costs[1]/form[1]/div[1]/table[1]/tbody[1]/tr[2]/td[1]/input[1]
${txt_price_2}       name=unitPrice_1
${txt_desc_2}        name=description_1
${btn_addnew}        xpath=//thead[@class='ng-star-inserted']//th//button[@type='button'][normalize-space()='Add row']
${lbl_netcost_1}     xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[5]/claim-job-item-other-costs[1]/form[1]/div[1]/table[1]/tbody[1]/tr[1]/td[5]
${lbl_netcost_2}     xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[5]/claim-job-item-other-costs[1]/form[1]/div[1]/table[1]/tbody[1]/tr[2]/td[5]
${btn_del_1}         xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[5]/claim-job-item-other-costs[1]/form[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/button[1]
${btn_del_2}         xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[5]/claim-job-item-other-costs[1]/form[1]/div[1]/table[1]/tbody[1]/tr[2]/td[6]/button[1]


# Claim Job Information tab
${tab_claimjobinfo}    xpath=//span[normalize-space()='Claim job information']
${lbl_othercosts}      xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item-information[1]/form[1]/div[1]/div[1]/div[3]/table[2]/tbody[1]/tr[3]/td[2]
${lbl_Status}          xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item-information[1]/form[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]


# History Tab
${lbl_history}      xpath=//span[normalize-space()='History']
${status_line1}     xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[8]/claim-job-item-history[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]
${comment_line1}    xpath=//body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[8]/claim-job-item-history[1]/div[1]/table[1]/tbody[1]/tr[1]/td[2]
${modTime_line1}    xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[8]/claim-job-item-history[1]/div[1]/table[1]/tbody[1]/tr[1]/td[3]
${modBy_line1}      xpath=/html[1]/body[1]/div[1]/udcp-root[1]/div[1]/claim-job-page[1]/div[1]/claim-job[1]/div[2]/div[1]/kendo-tabstrip[1]/div[2]/claim-job-item[1]/div[1]/kendo-tabstrip[1]/div[8]/claim-job-item-history[1]/div[1]/table[1]/tbody[1]/tr[1]/td[4]

# Test data
${RepairOrderno}           12344
${OperationHour1_value}    2

*** Keywords ***
Go to claim-job-infomation tab
    Go to tab    ${tab_claimjobinfo} 

Go to Labour tab
    Go to tab    ${tab_Labour}

Go to history tab
    Go to tab    ${lbl_history} 

Go to remarks tab
    Go to tab    ${tab_remarks}

Go to other costs tab
    Go to tab    ${tab_othercosts}

Go to Tab
    [Arguments]                         ${arg_tab}
    Wait Until Page Does Not Contain    Loading
    Wait Until Element Is Visible       ${arg_tab} 
    Click Element                       ${arg_tab} 

Add one VST and save claim job
    # Add vst line
    Get testdata OperationNo for VST
    Input Text                          ${input_operationNo_1}    ${operationId}
    Wait Until Page Does Not Contain    Loading
    Click button                        ${btn_claimjobsavebtn}
    # Wait Until Element Is Visible    ${chb_forced}
    Wait Until Page Does Not Contain    Loading
    Element Text Should NoT Be          ${txt_referenceNo}        0

Delete vst by line_number
    [Arguments]                      ${arg_lineNo}
    # delete 2nd vst
    Wait Until Element Is Visible    ${btn_labourlinedelete_${arg_lineNo}}
    Click Element                    ${btn_Labourlinedelete_${arg_lineNo}}
    Wait Until Element Is Visible    ${btn_YesDeleteLine}
    Click Element                    ${btn_YesDeleteLine}
    Element Should Be Disabled       ${btn_labourlinedelete_${arg_lineNo}}


# default on claim/claim-job page
# The labour line with VST unchecked and VST checked records can be saved successfully.
New labour line with VST checked and unchecked
    # Add two vst lines
    Get testdata OperationNo for VST
    Wait Until Page Does Not Contain    Loading
    Input Text                          ${input_operationNo_1}     ${operationId}
    UnSelect Checkbox                   ${chx_firstVstCheckBox}
    Input Text                          ${txt_OperationHour1}      ${OperationHour1_value}
    Click button                        ${btn_AddRow} 
    Input Text                          ${input_operationNo_2}     ${operationId_1}
    # save claim job
    Click button                        ${btn_claimjobsavebtn}
    # Assertion
    Wait Until Page Does Not Contain    Loading

Verify vst net-costs
    # Assert3: The Cost/hour from labour rate table according to brand, importer, dealer, claim job type and repair date
    Get CostPerHour By ClaimType_Dealer_Importer    Vehicle warranty           ${DealerId}                       ${ImportorId}
    ${actual_costperhour_1}                         Get Text                   ${txt_costPerHour_1}
    ${actual_costperhour_2}                         Get Text                   ${txt_costPerHour_2}
    ${repairdate}                                   Get Current Date           time_zone=UTC                     result_format=%#m/%#d/%Y
    ${expected_costperhour}                         Set Variable If            ${repairdate}>${BaseDate}         ${BeforeLabourRate}         ${BaseLabourRate}
    ${expected_costperhour}                         Evaluate                   float(${expected_costperhour})
    ${actual_costperhour_1}                         Replace String             ${actual_costperhour_1}           search_for=,                replace_with=${empty}
    ${actual_costperhour_2}                         Replace String             ${actual_costperhour_2}           search_for=,                replace_with=${empty}
    ${actual_costperhour_1}                         Evaluate                   float(${actual_costperhour_1})
    ${actual_costperhour_2}                         Evaluate                   float(${actual_costperhour_2})
    Should Be Equal                                 ${actual_costperhour_1}    ${expected_costperhour}
    Should Be Equal                                 ${actual_costperhour_2}    ${expected_costperhour}
    
    #Assert4. The Net=Quantity*Hours*Cost/hour*CAF for each labour line and the labour net  total will sum all the Net
    Get CAF for VST     Vehicle warranty            ${DealerId}                                        ${ImportorId}
    #line 1
    ${qty1}             Get Value                   ${input_quantity_1}
    ${hour1}            Get Value                   ${txt_OperationHour1}
    IF                  '${hour1}'=='${empty}'
    ${expected_net1}    Evaluate                    float(0)
    ELSE
    ${expected_net1}    Evaluate                    ${qty1}*${hour1}*${expected_costperhour}*${CAF}
    END
    ${actual_net1}      Get Text                    ${lbl_net1}
    ${actual_net1}      Common_ConvertStrToFloat    ${actual_net1}
    Should Be Equal     ${expected_net1}            ${actual_net1}
    #line 2
    ${qty2}             Get Value                   ${input_quantity_2}
    ${hour2}            Get Value                   ${txt_OperationHour2}
    IF                  '${hour2}'=='${empty}'
    ${expected_net2}    Evaluate                    0.0
    ELSE
    ${expected_net2}    Evaluate                    ${qty2}*${hour2}*${expected_costperhour}*${CAF}
    END
    ${actual_net2}      Get Text                    ${lbl_net2}
    ${actual_net2}      Common_ConvertStrToFloat    ${actual_net2}
    Should Be Equal     ${expected_net2}            ${actual_net2}
    #total
    ${expected_total}    Evaluate                    ${expected_net1}+${expected_net2}
    ${Actual_total}      Get Text                    ${lbl_nettotal}
    ${Actual_total}      Common_ConvertStrToFloat    ${Actual_total}
    Should Be Equal      ${Actual_total}             ${expected_total}
   # Capture Page Screenshot    claim-vst-{index}.png

New Remarks
    Go to remarks tab
    Element Should Be Enabled           ${txt_remarkComplaint}
    Element Should Be Enabled           ${txt_remarkCause}
    Element Should Be Enabled           ${txt_remarkCorrection}
    Element Should Be Enabled           ${txt_claimComment}
    Element Should Be Enabled           ${txt_internalComment}
    Input Text                          ${txt_remarkComplaint}     test remarkComplaint
    Input Text                          ${txt_remarkCause}         test remarkCause
    Input Text                          ${txt_remarkCorrection}    test remarkCorrection
    Input Text                          ${txt_claimComment}        test claim comments
    Input Text                          ${txt_internalComment}     test internalComment
    Click button                        ${btn_claimjobsavebtn}
    Wait Until Page Does Not Contain    Loading
    Page Should Contain                 Success

Delete first labour line
    Wait Until Element Is Visible    ${btn_Labourlinedelete_1}
    Click Element                    ${btn_Labourlinedelete_1}
    Wait Until Element Is Visible    ${btn_YesDeleteLine}
    Click Element                    ${btn_YesDeleteLine}

# Data preparation for Claim_DeleteLabourLine
# 1st line: main operation cannot be deleted
# 2st line: vst checked for delete
# 3st line: vst unchecked for delete
Add three vst lines
    # Add two vst lines
    Get testdata OperationNo for VST
    Wait Until Page Does Not Contain    Loading
    #1st vst
    Input Text                          ${input_operationNo_1}     ${operationId}
    UnSelect Checkbox                   ${chx_firstVstCheckBox}
    Input Text                          ${txt_OperationHour1}      ${OperationHour1_value}
    #2nd vst
    Wait Until Element Is Visible       ${btn_AddRow}
    Click button                        ${btn_AddRow} 
    Input Text                          ${input_operationNo_2}     ${operationId_1}
    #3rd vst
    Click button                        ${btn_AddRow} 
    Input Text                          ${input_operationNo_3}     ${operationId}
    UnSelect Checkbox                   ${chx_VstCheckBox_2}       
    Input Text                          ${txt_OperationHour_3}     2
    Click button                        ${btn_claimjobsavebtn}
    # Assertion
    Wait Until Page Does Not Contain    Loading
    Page Should Contain                 Success

Add two other-costs lines
    Go to other costs tab
    Set Test Variable                   ${qty1}                   1
    Set Test Variable                   ${qty2}                   2
    Set Test Variable                   ${price1}                 100
    Set Test Variable                   ${price2}                 200
    Wait Until Element Is Visible       ${txt_qty_1}
    Input Text                          ${txt_qty_1}              ${qty1}
    Input Text                          ${txt_price_1}            ${price1}
    Input Text                          ${txt_desc_1}             test cost 1
    Click button                        ${btn_addnew}
    Wait Until Element Is Visible       ${txt_qty_2}
    Input Text                          ${txt_qty_2}              ${qty2}
    Input Text                          ${txt_price_2}            ${price2}
    Input Text                          ${txt_desc_2}             test cost 2
    Click button                        ${btn_claimjobsavebtn}
    Wait Until Page Does Not Contain    Loading

Verify claim-status is "${status}"
    Go to claim-job-infomation tab
    Wait Until Element Is Visible     ${lbl_Status} 
    Element Text Should Be            ${lbl_Status}     ${status}

Save claim-job
    Wait Until Element Is Enabled       ${btn_claimjobsavebtn}
    Click Element                       ${btn_claimjobsavebtn}
    Wait Until Page Does Not Contain    Loading

Verify history-tab for draft claim
    Wait Until Page Does Not Contain    Loading
    Go to history tab
    Page Should Contain                 Status
    Page Should Contain                 Comment
    Page Should Contain                 Modified time
    Page Should Contain                 Modified By
    Page Should Not Contain Element     ${status_line1}

Verify history-tab for Validated-ok claim
    [Arguments]                         ${arg_moddate}
    Wait Until Page Does Not Contain    Loading
    Go to history tab                   
    Wait Until Element Is Visible       ${status_line1} 
    Element Text Should Be              ${status_line1}           Validated OK
    Element Text Should Be              ${comment_line1}          ${Space}
    Element Text Should Be              locator=${modBy_line1}    expected=${loginUser}    ignore_case=True
    Element Should Contain              ${modTime_line1}          ${arg_moddate}

Get referenceNo on claim-job page
    Wait Until Element Is Visible    ${txt_referenceNo}
    ${no}                            Get Text              ${txt_referenceNo}
    Return From Keyword              ${no} 

Delete first other-cost line
    Go to other costs tab
    Wait Until Element Is Visible    ${btn_del_1}
    Click Element                    ${btn_del_1}
    Wait Until Element Is Visible    ${btn_YesDeleteLine} 
    Click Element                    ${btn_YesDeleteLine} 

# qty and price comes from 'Add two other-costs lines'
Verify Costs are correct
    # Assert3: The Net=Quantity*Price*CAF
    ${dealer}                         Get Text                ${lbl_dealer} 
    ${importor}                       Get Text                ${lbl_importor}
    Get CAF for VST                   Vehicle warranty        ${dealer}                                      ${importor} 
    ${expected_netcost_1}             Evaluate                ${qty1}*${price1}*float(${CAF})
    ${expected_netcost_2}             Evaluate                ${qty2}*${price2}*float(${CAF})
    ${actual_netcost_1}               Get Text                ${lbl_netcost_1}
    ${actual_netcost_2}               Get Text                ${lbl_netcost_2}
    ${actual_netcost_1}               Evaluate                float(${actual_netcost_1})
    ${actual_netcost_2}               Evaluate                float(${actual_netcost_2})
    Should Be Equal                   ${actual_netcost_1}     ${expected_netcost_1}
    Should Be Equal                   ${actual_netcost_2}     ${expected_netcost_2}
    # Assert 4. The other cost information will update the value in the claim job information tab
    Go to claim-job-infomation tab
    Wait Until Element Is Visible     ${lbl_othercosts}
    ${actual_totalcosts}              Get Text                ${lbl_othercosts}
    ${actual_totalcosts}              Evaluate                float(${actual_totalcosts})
    ${expected_totalcosts}            Evaluate                ${expected_netcost_1}+${expected_netcost_2}
    Should Be Equal                   ${actual_totalcosts}    ${expected_totalcosts}



