*** Settings ***
Resource    ./base_api.robot

*** Variables ***
# Data Test
${FULL_NAME}    Peter Parker
${EMAIL}        peter@parker.com
${PASSWORD}     pwd123

*** Test Cases ***
Test: Update user
    Create a new user   ${EMAIL}                ${FULL_NAME}                        ${PASSWORD}
    ${token}=           Get Token               ${EMAIL}                            ${PASSWORD}
    ${user_id}=         Get Id                  ${EMAIL}                            ${PASSWORD}

    &{body}=            create dictionary       full_name=Eddie Brock               email=${EMAIL}      password=${PASSWORD}
    &{headers}=         create dictionary       Content-Type=application/json       Authorization=${token} 

    ${response}=        put request             nplus       /user/${USER_ID}        data=${body}        headers=${headers}
    ${code}=            convert to string       ${response.status_code}
    should be equal     ${code}                 200
    ${response}=        Get user                ${USER_ID}                          ${EMAIL}            ${PASSWORD}
    dictionary should contain value             ${response.json()}                  Eddie Brock