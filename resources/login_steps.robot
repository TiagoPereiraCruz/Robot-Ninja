*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${DEFAULT_URL}      http://ninjaplus-web:5000/login
${BROWSER}          chrome
${INPUT_EMAIL}      css:input[name=email]
${INPUT_PASS}       css:input[name=password]
${BUTTON_SUBMIT}    id:login
${DIV_ALERT}        css:.alert
${SPAN_USER}        css:.user .info span

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
    Input Text      ${INPUT_EMAIL}                    ${email}
    Input Text      ${INPUT_PASS}                     ${pass}
    Click Button    ${BUTTON_SUBMIT}

Devo ver o meu nome "${username}" na área logada
    Wait Until Element Contains     ${SPAN_USER}      ${username}

Logando com credenciais inválidas devo ver uma mensagem de alerta

    [Arguments]                     ${email}           ${pass}     ${expect_message}

    Input Text                      ${INPUT_EMAIL}     ${email}
    Input Text                      ${INPUT_PASS}      ${pass}
    Click Button                    ${BUTTON_SUBMIT}
    Wait Until Element Contains     ${DIV_ALERT}       ${expect_message}