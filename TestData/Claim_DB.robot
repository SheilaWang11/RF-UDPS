*** Setting ***
Library     DatabaseLibrary
Resource    DBConn.robot
Resource    ../Parameters/Config.robot

*** Variables ***
${registrationNo_invalid}    111
#${operationId}              17737-0

#RepairOrderno is not saved in database, can enter anything
${RepairOrderno}    12344


*** Keywords ***
Prepare test data for new claim job
    Connect DB
    Comment                       get importor id
    @{queryResults}               Query                      select top 1 Id as dealerId,importerId from [${dbName}].[dbo].[Dealer] order by Id desc
    Log Many                      @{queryResults} 
    Set Test Variable             ${DealerId}                ${queryResults[0][0]}
    Set Test Variable             ${ImportorId}              ${queryResults[0][1]}
    Comment                       get vehicle info
    @{queryResults_1}             Query                      select top 1 ChassisSeries,ChassisNo,Mileage,RegistrationNo from [${dbName}].[dbo].[Vehicle]
    Log Many                      @{queryResults_1} 
    Set Test Variable             ${ChassisSeries}           ${queryResults_1[0][0]}
    Set Test Variable             ${ChassisNum}              ${queryResults_1[0][1]}
    Set Test Variable             ${Mileage}                 ${queryResults_1[0][2]}
    Set Test Variable             ${registrationNo}          ${queryResults_1[0][3]}
    Disconnect DB

Get testdata OperationNo for VST
    Connect DB
    @{queryResult_operationNo}    Query                      select top 2 OperationNo from [${dbName}].[dbo].[Operation]
    Set Test Variable             ${operationId}             ${queryResult_operationNo[0][0]}
    Set Test Variable             ${operationId_1}             ${queryResult_operationNo[1][0]}
    Disconnect DB

Get CostPerHour By ClaimType_Dealer_Importer
    [Arguments]  ${claimtype}  ${dealer}  ${importer}
    ${getCostPerHour_query}=  catenate
    ...  select top 1 lr.BeforeLabourRate,lr.BaseLabourRate,Format(lr.BaseDate, 'MM/dd/yyyy'),lr.ClaimJobTypeId 
    ...  from [${dbName}].[dbo].[LabourRate] lr
    ...  inner join [${dbName}].[dbo].[ClaimJobType] cjy 
    ...  on lr.ClaimJobTypeId=cjy.Id
    ...  where cjy.Name='${claimtype}' and lr.DealerId='${dealer}'
    ...  and lr.ImporterId='${importer}' and lr.BrandId=1
    ...  UNION All
    ...  select top 1 lr.BeforeLabourRate,lr.BaseLabourRate,Format(lr.BaseDate, 'MM/dd/yyyy'),lr.ClaimJobTypeId
    ...  from [${dbName}].[dbo].[LabourRate] lr
    ...  where  lr.DealerId='${dealer}' and lr.ImporterId='${importer}' and lr.BrandId=1
    ...  and lr.ClaimJobTypeId is null
    ...  order by lr.ClaimJobTypeId desc
    Connect DB
    @{query_CostPerHour}               Query         ${getCostPerHour_query}
    Log Many
    Set Test Variable     ${BeforeLabourRate}   ${query_CostPerHour[0][0]}
    Set Test Variable     ${BaseLabourRate}   ${query_CostPerHour[0][1]}  
        ${BaseDate}     Convert Date  ${query_CostPerHour[0][2]}    result_format=%#m/%#d/%Y    date_format=%m/%d/%Y
    Set Test Variable     ${BaseDate}   
    Disconnect DB

Get CAF for VST
    [Arguments]  ${claimtype}  ${dealer}  ${importer}
    ${getCAF_query}=  catenate
    ...  select top 1 caf.Value,caf.[CostTypeId] from [${dbName}].dbo.[CostAdjustFactor] caf
    ...  inner join [${dbName}].[dbo].[ClaimJobType] cjy
    ...  on caf.ClaimJobTypeId=cjy.Id
    ...  where cjy.Name='${claimtype}'
    ...  and DealerId='${dealer}'
    ...  and ImporterId='${importer}'
    ...  and caf.CostTypeId=1
    ...  union all
    ...  select top 1 caf.Value,caf.[CostTypeId] 
    ...  from [${dbName}].dbo.[CostAdjustFactor] caf 
    ...  inner join [${dbName}].[dbo].[ClaimJobType] cjy
    ...  on caf.ClaimJobTypeId=cjy.Id where cjy.Name='${claimtype}'
    ...  and DealerId='${dealer}' and ImporterId='${importer}' 
    ...  and caf.CostTypeId is null
    ...  order by caf.[CostTypeId]
    Connect DB
    @{queryresult_CAF}               Query         ${getCAF_query}
    Log Many
    Set Test Variable     ${CAF}   ${queryresult_CAF[0][0]}
    Disconnect DB