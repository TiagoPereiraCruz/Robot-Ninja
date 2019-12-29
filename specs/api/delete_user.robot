*** Settings ***
Resource    ./base_api.robot

*** Test Cases ***
Test: Unique Id
    remove user by email                darth@vader.com
    &{user}=                            create dictionary       full_name=Darth Vader   email=darth@vader.com   password=${Password}
    ${user_id}=                         Post user Return Id     ${user}

    ${response}=                        Delete User             ${user_id}    
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 204
    
Test: User not found
    ${response}=                        Delete User             9999
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 404