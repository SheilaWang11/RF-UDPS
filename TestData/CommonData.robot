*** Setting ***
Library     DatabaseLibrary
Resource    DBConn.robot
Resource    ../Parameters/Config.robot

*** Keywords ***
Get DealerId and ImportorId Combination
    Connect DB
    @{queryResults}               Query                      select top 1 Id as dealerId,importerId from [${dbName}].[dbo].[Dealer] order by Id desc
    Log Many                      @{queryResults} 
    Set Test Variable             ${DealerId}                ${queryResults[0][0]}
    Set Test Variable             ${ImportorId}              ${queryResults[0][1]}
    Disconnect DB