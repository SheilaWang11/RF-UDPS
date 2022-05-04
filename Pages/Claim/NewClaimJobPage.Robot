*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     DateTime
Resource    ../../TestData/Claim_DB.robot
Resource    ../../TestData/DBConn.robot
Resource    NewClaimJobPage.Robot

*** Variables ***
# new-claim-job Elements
${list_claim_job_type}      id=typeOfClaim
${input_ImproterId}         id=repairingImporterId
${input_DealerId}           id=repairingDealerId
${input_repairOrderNo}      id=repairOrderNo
${input_repairDate}         xpath=//span[@class='k-icon k-i-calendar']
${input_registrationNo}     id=registrationNo
${input_chassisSeries}      id=chassisSeries
${input_chassisNo}          id=chassisNo
${input_vehicleMilageKM}    id=vehicleMilageKM
${input_vin}                id=vin
${btn_continue}             xpath=//button[normalize-space()='Continue']
${lable_msg}                xpath=//div[@class='row-fix']
${chx_noVehicle}            id=noVehicle
${lab_Brand}                xpath=//label[normalize-space()='Brand']

*** Keywords ***
# Don't check No Vehicle, input a wrong Registration Number which is not existing in UDCP
# Expected: Chassis Id and VIN should disappear, and Continue button is enabled.
New Vehicle Warranty Claim Job with invalid registrationNo
    Prepare test data for new claim job
    Enter repair header info               Vehicle warranty
    Input Text                             ${input_registrationNo}       ${registrationNo_invalid} 
    Element Should Not Be Visible          ${input_chassisSeries}
    Element Should Not Be Visible          ${input_vin}
    Element Should Be Enabled              ${btn_continue}
    Click Element                          ${btn_continue}
    Wait Until Page Does Not Contain       Loading
    Page Should Contain                    Vehicle could not be found

New Parts claim without vehicle
    Prepare test data for new claim job
    Enter repair header info               Parts
    Select Checkbox                        ${chx_noVehicle}
    # Validate elements status
    Element Should Not Be Visible          ${input_registrationNo}
    Element should Not Be Visible          ${input_chassisNo}
    Element Should Not Be Visible          ${input_vin}
    Element Should Not Be Visible          ${input_vehicleMilageKM}
    Element Should Be Visible              ${lab_Brand}
    Element Should Be Enabled              ${btn_continue}
    Click Element                          ${btn_continue}
    Wait Until Location Contains           ${url_claimjob}
    Location Should Contain                ${url_claimjob}

New Vehicle warranty Claim
    Prepare test data for new claim job
    Enter repair header info               Vehicle warranty
    # enter vehile info
    Input Text                             ${input_chassisSeries}      ${ChassisSeries}
    Input Text                             ${input_chassisNo}          ${ChassisNum}
    Element Should Be Enabled              ${btn_continue}
    Element Should Not Be Visible          ${input_vin}
    Input Text                             ${input_vehicleMilageKM}    ${Mileage}
    # save claim job
    Click button                           ${btn_continue}
    Wait Until Element Is Visible          ${txt_referenceNo}
    Element Text Should Be                 ${txt_referenceNo}          0

# New Claim header info
Enter repair header info
    [Arguments]                         ${cliam_type}
    Wait Until Page Does Not Contain    Loading
    Wait Until Element is Visible       ${list_claim_job_type}
    Click Element                       ${list_claim_job_type}
    Select From List By Label           ${list_claim_job_type}    ${cliam_type}
    Input Text                          ${input_ImproterId}       ${ImportorId} 
    Input Text                          ${input_DealerId}         ${DealerId}
    Input Text                          ${input_repairOrderNo}    ${RepairOrderno}
    # Set Focus To Element                ${input_repairDate}
    # Press Keys                          ${input_repairDate}       \ue007
    Element Should Be Disabled          ${btn_continue}









