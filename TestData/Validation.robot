
*** Setting ***
Library     DatabaseLibrary
Resource    DBConn.robot
Resource    ../Parameters/Config.robot

*** Keywords ***
Get Check Num from DB
    Connect DB
    @{QueryResult_check}    Query   select Count(*) from [${dbName}].[dbo].[Check]
    Log Many
    Set Test Variable   ${totalCheckNum}    ${QueryResult_check[0][0]}
    Disconnect DB

