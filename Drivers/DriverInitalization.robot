*** Settings ***
Library    SeleniumLibrary   
Resource    ../Parameters/Config.robot

*** Keywords ***
Open browser and go to ${url} page
    Set Selenium Timeout    ${timeout}
    ${chrome options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver    
    Run Keyword If    '${headless}' == 'true'    Call Method    ${chrome options}   add_argument    headless
    Run Keyword If    '${headless}' == 'true'    Call Method    ${chrome options}   add_argument    disable-gpu
    Create Webdriver    Chrome    executable_path=${CURDIR}\\chromedriver_${chromedriver_vesion}.exe    chrome_options=${chrome options} 
    Maximize Browser Window 
    go to   ${url}