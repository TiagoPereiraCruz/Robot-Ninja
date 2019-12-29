*** Settings ***
Resource    ./base_api.robot

*** Variables ***
# Data Test
${EMAIL}        darth@vader.com
${PASSWORD}     pwd123

*** Test Cases ***
Test: Unique Id
    remove user by email        darth@vader.com
    &{user}=                    create dictionary       full_name=Darth Vader   email=${EMAIL}   password=${PASSWORD}
    ${user_id}=                 Post user Return Id     ${user}

    ${response}=                Delete User             ${user_id}      ${EMAIL}                ${PASSWORD}
    ${code}=                    convert to string       ${response.status_code}
    should be equal             ${code}                 204
    
Test: User not found
    ${response}=                Delete User             9999        tiago@ninjaplus.com     pwd123
    ${code}=                    convert to string       ${response.status_code}
    should be equal             ${code}                 404