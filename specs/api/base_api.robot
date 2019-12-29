*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     ../../resources/lib/db.py

*** Variables ***
# Data Test
${BASE_URL}     http://ninjaplus-api:3000
${EMAIL}        tiago@ninjaplus.com
${PASSWORD}     pwd123
${USER_ID}      1   

*** Keywords ***
Get User
    [Arguments]                         ${USER_ID}

    ${token}=                           Get Token
    create session                      nplus                  ${BASE_URL}
    &{headers}=                         create dictionary      Content-Type=application/json   Authorization=${token}  

    ${response}=                        get request            nplus   /user/${USER_ID}    headers=${headers}
    log                                 ${response.text}
    [Return]                            ${response}

Get Token
    create session                      nplus                   ${BASE_URL}
    &{body}=                            create dictionary       email=${EMAIL}  password=${PASSWORD}
    &{headers}=                         create dictionary       Content-Type=application/json

    ${response}=                        post request            nplus   /auth   data=${body}    headers=${headers}
    log                                 ${response.text}
    ${token}                            convert to string       JWT ${response.json()['token']}
    [Return]                            ${token}

Post user Return Id
    [Arguments]                         ${body}
    create session                      nplus                   ${BASE_URL}
    &{headers}=                         create dictionary       Content-Type=application/json

    ${response}=                        post request            nplus   /user   data=${body}    headers=${headers}
    log                                 ${response.text}
    ${USER_ID}                          convert to string       ${response.json()['id']}
    [Return]                            ${USER_ID}

Delete User
    [Arguments]                         ${USER_ID}

    ${token}=                           Get Token
    create session                      nplus                   ${BASE_URL}
    &{headers}=                         create dictionary       Content-Type=application/json   Authorization=${token}  

    ${response}=                        delete request          nplus   /user/${USER_ID}    headers=${headers}
    log                                 ${response.text}
    [Return]                            ${response}

Post user
    [Arguments]                         ${body}
    create session                      nplus                   ${BASE_URL}
    &{headers}=                         create dictionary       Content-Type=application/json

    ${response}=                        post request            nplus   /user   data=${body}    headers=${headers}
    log                                 ${response.text}
    [Return]                            ${response}