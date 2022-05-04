*** Setting ***
Library     DatabaseLibrary
Resource    ../Parameters/Config.robot

*** Keywords ***
Connect DB
    Connect To Database    pymssql    ${dbName}    ${dbUsername}    ${dbPassword}    ${dbHost}    ${dbport}
Disconnect DB
    Disconnect from Database