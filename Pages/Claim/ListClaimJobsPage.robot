*** Settings ***
Library  SeleniumLibrary
Resource    ClaimJobPage.robot

*** Variable  ***
${txt_refNo}  id=refNo
${btn_search}   xpath=//button[normalize-space()='Search']
${lbl_RefNoJobNo_1}  xpath=//body[1]/div[1]/udcp-root[1]/div[1]/list-claim-jobs-page[1]/div[1]/div[2]/list-claim-jobs-list[1]/kendo-tabstrip[1]/div[4]/list-claim-jobs-notfinished[1]/kendo-grid[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]



*** Keywords  ***
Search claim-job by refNo
    [Arguments]    ${arg_refno}
    Wait Until Element Is Visible   ${txt_refNo}
    Input Text   ${txt_refNo}   ${arg_refno}
    Click button    ${btn_search}
    Wait Until Page Does Not Contain    Loading
    Element Should Contain  ${lbl_RefNoJobNo_1}  ${arg_refno}

Open first claim-job
    Wait Until Element Is Visible  ${lbl_RefNoJobNo_1}
    Click Element   ${lbl_RefNoJobNo_1}
    Wait Until Page Does Not Contain  Loading
    Location Should Contain     ${url_claimjob}