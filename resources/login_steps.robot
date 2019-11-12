*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
#### Setup e Teardown
Abrir navegador
    Open Browser    http://ninjaplus-web:5000/login     chrome
    Set Selenium Implicit Wait  10
    Maximize Browser Window

Fechar navegador
    Close Browser

#### Steps
Fazendo login com "${email}" e senha "${pass}"
    Input Text      id:emailId                          ${email}
    Input Text      id:passId                           ${pass}
    Click Button    id:login

Devo ver o meu nome "${username}" na área logada
    Wait Until Element Contains     css:.user .info span        ${username}

Devo ver a seguinte mensagem de alerta "${expect_message}"
    Wait Until Element Contains     css:.alert      ${expect_message}