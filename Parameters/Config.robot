*** Variables ***
# http://52.163.60.246/
${app_url}    http://udcp_tower:8080/login
${headless}   false
${timeout}    60 seconds
${username}   admin
${password}   1
${chromedriver_vesion}  100

#DB info
${dbName}   udcp-test-db
${dbUsername}   udcp
${dbPassword}   welcome 
${dbHost}   UDCP_TOWER
${dbport}   1433