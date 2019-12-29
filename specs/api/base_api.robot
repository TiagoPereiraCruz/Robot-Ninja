*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     ../../resources/lib/db.py

*** Variables ***
${BASE_URL}     http://ninjaplus-api:3000

*** Keywords ***
Get User
    [Arguments]         ${USER_ID}              ${EMAIL}                         ${PASSWORD}

    ${token}=           Get Token               ${EMAIL}                         ${PASSWORD}
    create session      nplus                   ${BASE_URL}
    &{headers}=         create dictionary       Content-Type=application/json    Authorization=${token}  

    ${response}=        get request             nplus   /user/${USER_ID}         headers=${headers}
    log                 ${response.text}
    [Return]            ${response}

Get Token
    [Arguments]         ${EMAIL}                ${PASSWORD}

    create session      nplus                   ${BASE_URL}
    &{body}=            create dictionary       email=${EMAIL}  password=${PASSWORD}
    &{headers}=         create dictionary       Content-Type=application/json

    ${response}=        post request            nplus   /auth   data=${body}    headers=${headers}
    log                 ${response.text}
    ${token}            convert to string       JWT ${response.json()['token']}
    [Return]            ${token}

Get Id
    [Arguments]         ${EMAIL}                ${PASSWORD}

    create session      nplus                   ${BASE_URL}
    &{body}=            create dictionary       email=${EMAIL}  password=${PASSWORD}
    &{headers}=         create dictionary       Content-Type=application/json

    ${response}=        post request            nplus   /auth   data=${body}    headers=${headers}
    log                 ${response.text}
    ${user_id}          convert to string       ${response.json()['userId']}
    [Return]            ${user_id}

Post user Return Id
    [Arguments]         ${body}
    create session      nplus                   ${BASE_URL}
    &{headers}=         create dictionary       Content-Type=application/json

    ${response}=        post request            nplus   /user   data=${body}    headers=${headers}
    log                 ${response.text}
    ${USER_ID}          convert to string       ${response.json()['id']}
    [Return]            ${USER_ID}

Delete User
    [Arguments]         ${USER_ID}              ${email}             ${password}

    ${token}=           Get Token               ${email}             ${password}
    create session      nplus                   ${BASE_URL}
    &{headers}=         create dictionary       Content-Type=application/json   Authorization=${token}  

    ${response}=        delete request          nplus   /user/${USER_ID}    headers=${headers}
    log                 ${response.text}
    [Return]            ${response}

Post user
    [Arguments]         ${body}
    create session      nplus                   ${BASE_URL}
    &{headers}=         create dictionary       Content-Type=application/json

    ${response}=        post request            nplus   /user   data=${body}    headers=${headers}
    log                 ${response.text}
    [Return]            ${response}

Create a new user               
    [Arguments]                 ${EMAIL}                ${FULL_NAME}             ${PASSWORD}
    remove user by email        ${EMAIL}
    &{body}=                    create dictionary       full_name=${FULL_NAME}   email=${EMAIL}   password=${PASSWORD}

    ${response}=                post user               ${body}
    ${code}=                    convert to string       ${response.status_code}
    should be equal             ${code}                 200