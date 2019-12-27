*** Settings ***
Resource    ./base.robot
Library     ../../lib/db.py

*** Variables ***
# Data Test
${Title}        Resident Evil
${Status}       Disponível
${Year}         2002
${ReleaseDate}  01/12/2002
@{Cast}         Milla Jovovich      Ali Larter      Ian Glen        Shawn Roberts
${Plot}         Alice tem a missão de desativar a rainha vermelha na colmeia porque alguém jogou um vírus e deu ruim

*** Keywords ***
#### Steps
Dado que estou logado com credenciais válidas
    Input Text      ${INPUT_EMAIL}                    tiago@ninjaplus.com
    Input Text      ${INPUT_PASS}                     pwd123
    Click Button    ${BUTTON_SUBMIT}

Quando eu faço o cadastro de um novo filme
    Remove Movie By Title               ${Title}
    Click Button                        ${BUTTON_ADD}
    Input Text                          ${INPUT_TITLE}      ${Title}
    Click Element                       ${DROP_STATUS}
    Wait Until Element Is Visible       ${OPTION_AVAILABLE}
    Click Element                       ${OPTION_AVAILABLE}
    Input Text                          ${INPUT_YEAR}       ${Year}
    Input Text                          ${INPUT_RDATE}      ${ReleaseDate}
    : FOR       ${item}     IN          @{Cast}
    \           Input Text              ${INPUT_CAST}       ${item}
    \           Press Keys              ${INPUT_CAST}       TAB
    \           Log                     ${item}
    Input Text                          ${TEXT_PLOT}        ${Plot}
    Click Button                        ${BUTTON_SAVE}

Então este filme deve ser exibido na lista
    Wait Until Element Contains         ${TABLE_ITEM}       ${Title}