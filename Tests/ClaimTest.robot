*** Settings ***
Library          SeleniumLibrary
Resource         ../Pages/LoginPage.robot
Resource         ../Pages/HomePage.robot
Resource         ../Pages/Claim/NewClaimJobPage.robot
Resource         ../Pages/Claim/ClaimJobPage.robot
Resource         ../Pages/Claim/ListClaimJobsPage.robot
Resource         ../TestData/Claim_DB.robot
Resource         ../Pages/Common.robot
Test Setup       Login with admin
Test Teardown    Close Browser
Force Tags       Claim
Default Tags     Regression

*** Test Cases ***
#Create Vehicle Warranty claim with vehicle
Claim_Job_Create_VehicleWarranty
    Go to new-claim-job page
    New Vehicle warranty Claim
    Add one VST and save claim job
#Create Vehicle Warranty claim with vehicle
Claim_Job_Create_VehicleWarranty_InvadlidReg
    Set Tags                                                      Negative
    Go to new-claim-job page
    New Vehicle Warranty Claim Job with invalid registrationNo

Claim_Job_Create_PartsClaim_NoVehicle
    Go to new-claim-job page
    New Parts claim without vehicle

#The labour line with VST unchecked and VST checked records can be saved successfully.
#Add labour line with VST checked and unchecked
Claim_Labour_AddVST
    [Tags]                          vst
    Go to new-claim-job page
    New Vehicle warranty Claim
    New labour line with VST checked and unchecked
     #Assert1:The labour line saved successfully and the success message displayed.
    Page Should Contain             Success
    # Assert2: System has bug, sometime the button still enabled, so remove this assert temporally
    Element Should Be Disabled      ${btn_claimjobsavebtn}
    Verify vst net-costs

#The remarks can be saved successfully
Claim_Remarks_Add
    Go to new-claim-job page
    New Vehicle warranty Claim
    New Remarks

#Check the match logic for certain value and "all"(Type of claim)
Claim_Job_LogicCheck_ClaimType
    Go to new-claim-job page
    # TODO: test case is not that clear, need more details to implement.

#The labour line can be deleted.
Claim_Labour_DeleteLine
    # Preparation
    Go to new-claim-job page
    New Vehicle warranty Claim
    Add three vst lines
    # Get reference No
    ${referenceNo}                Get referenceNo on claim-job page
    # test steps
    Go to list_claim_jobs page
    Search claim-job by refNo     ${referenceNo}
    Open first claim-job
    Go to Labour tab
    # delete 2nd and 3rd vst lines
    Delete vst by line_number     2
    Delete vst by line_number     3
    #save
    Save claim-job
    Page Should Contain           Success

#The Other costs line with more records can be saved successfully.
Claim_OtherCost_AddLine
   # Preparation
    Go to new-claim-job page
    New Vehicle warranty Claim
    # test steps
    Add two other-costs lines
    Wait Until Page Does Not Contain    Loading
    # Assert 1: The other cost line saved successfully and the success message displayed.
    Page Should Contain                 Success
    # Asset 2: After the other cost line saved successfully, the save claim job button will change to disabled.
    Element Should Be Disabled          ${btn_claimjobsavebtn}
    # Assert3: The Net=Quantity*Price*CAF
    # Assert 4. The other cost information will update the value in the claim job information tab
    Verify Costs are correct

Claim_OtherCost_DeleteLine
    # Preparation
    Go to new-claim-job page
    New Vehicle warranty Claim
    Add two other-costs lines
    ${referenceNo}                      Get referenceNo on claim-job page
    Go to list_claim_jobs page
    Search claim-job by refNo           ${referenceNo}
    Open first claim-job
     # test steps
    Delete first other-cost line
    # Assert 1
    Element Should Be disabled          ${btn_del_1}
    # save
    Save claim-job
    # Assert 2
    Wait Until Page Does Not Contain    Loading
    Page Should Contain                 Success

Claim_History_Check
    Go to new-claim-job page
    New Vehicle warranty Claim
    Verify claim-status is "Draft"
    Verify history-tab for draft claim
    ${moddate}                                   Get Today in format mm/dd/yyyy
    Save claim-job
    Verify claim-status is "Validated OK"
    Verify history-tab for Validated-ok claim    ${moddate}








