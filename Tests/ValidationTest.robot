*** Settings ***
Library         SeleniumLibrary
Library          String
Resource         ../Pages/LoginPage.Robot
Resource         ../Pages/HomePage.Robot
Resource         ../Pages/Validation/NewScenarioPage.robot
Resource         ../Pages/Validation/ListScenarioPage.robot
Resource         ../Pages/Validation/ScenarioDetailsPage.robot
Test Setup       Login with admin
Test Teardown    Close Browser
Force Tags       Validation
Default Tags     Regression

*** Test Cases ***
#The check scenario can be created successfully
Validation_CheckScenario_Create
    Go to new-check-scenario page
    New scenario with valid data entered

#The check scenario can be created successfully
Validation_CheckScenario_PageCheck
    [Tags]                                          UI
    Go to new-check-scenario page
    Validate new-sceanrio page elements
    Validate new-sceanrio page mandantory fields

Validation_CheckScenario_DuplicatedScenarioName
    [Tags]                           Negative
    ${name}                          Generate Random String                                            length=6
    ${name}=                         Catenate                                                          SEPARATOR=    Auto    ${name}
    Log                              ${name}
    Go to new-check-scenario page
    New scenario by name             ${name}    testdesc
    ELement Should Be Visible        ${btn_deleteCheckScenario}
    # new same scenario with same name
    Go to new-check-scenario page
    New scenario by name             ${name}    testdesc
    Page Should Contain              A check scenario exist by same name, hence could not be saved.

Validation_CheckScenario_Delete
    #preparation
    ${name}                           Generate Random String    length=6
    ${name}=                          Catenate                  SEPARATOR=    Auto    ${name}
    Log                               ${name}
    Go to new-check-scenario page
    New scenario by name              ${name}  testdesc
    #delete
    Go to list-check-scenario page
    Search check scenario by Name     ${name}
    Open Frist scenario
    Delete scenario
    Search check scenario by Name     ${name}
    Page Should Contain               No records available

#The check scenario can be copied without checks successfully
Validation_CheckScenario_Copy
    Go to list-check-scenario page  
    Click copy of first scenario
    Copy scenario

#The check scenario can add the checks
Validation_CheckScenario_AddChecks
    # preparation
    ${name}                           Generate Random String    length=6
    ${name}=                          Catenate                  SEPARATOR=    Auto    ${name}
    Log                               ${name}
    Go to new-check-scenario page
    New scenario by name              ${name}   testdesc
    # test steps
    Go to view-checks page
    Validate view-checks page  ${name}  testdesc
    Add top2 checks
    Filter checks for all checks and selected checks
    Reload Page
    Delete all select checks


