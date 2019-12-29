*** Settings ***
Resource    ./base_api.robot

*** Variables ***
# Data Test
${FULL_NAME}     Bruce Wayne
${EMAIL}        bruce@wayne.com
${PASSWORD}     pwd123

*** Test Cases ***
Test: Create a new user
    remove user by email                ${EMAIL}
    # &{body}=                            create dictionary       full_name=${FULL_NAME}   email=${EMAIL}   password=${PASSWORD}
    ${body}=                            get file                ${EXECDIR}/resources/json/post_200.json

    ${response}=                        post user               ${body}
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 200

Test: Name required
    &{body}=                            create dictionary       full_name=${EMPTY}   email=${EMPTY}   password=${PASSWORD}
   
    ${response}=                        post user               ${body}
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 412
    dictionary should contain value     ${response.json()}      Validation notEmpty on full_name failed 

Test: Email required
    &{body}=                            create dictionary       full_name=${FULL_NAME}   email=${EMPTY}   password=${PASSWORD}
   
    ${response}=                        post user               ${body}
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 412
    dictionary should contain value     ${response.json()}      Validation notEmpty on email failed    

Test: Password required
    &{body}=                            create dictionary       full_name=${FULL_NAME}   email=${EMAIL}   password=${EMPTY}
   
    ${response}=                        post user               ${body}
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 412
    dictionary should contain value     ${response.json()}      Validation notEmpty on password failed