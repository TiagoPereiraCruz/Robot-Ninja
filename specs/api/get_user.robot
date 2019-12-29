*** Settings ***
Resource    ./base_api.robot

*** Test Cases ***
Test: Unique Id
    ${response}=                        Get user                ${USER_ID}
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 200
    dictionary should contain value     ${response.json()}      Tiago
    dictionary should contain value     ${response.json()}      tiago@ninjaplus.com

Test: User not found
    ${response}=                        Get user                9999
    ${code}=                            convert to string       ${response.status_code}
    should be equal                     ${code}                 404

# MINHA SOLUÇÃO!

# Test: Unique Id
    # # get token
    # &{body}=            create dictionary       email=${EMAIL}   password=${PASSWORD}

    # ${response}=        post user               ${body}
    # ${token}=           convert to string       JWT ${response.json().get("token")}

    # # get the user
    # create session      nplus                   http://ninjaplus-api:3000
    # &{headers}=         create dictionary       Content-Type=application/json       Authorization=${token}

    # ${response}=        get request             nplus   /user/$${user_id}                 headers=${headers}
    # log                 ${response.text}
    # ${user}=            convert to string       ${response.text}
    # log to console      ${user}

# Post user
#     [Arguments]                         ${body}
#     create session                      nplus                   http://ninjaplus-api:3000
#     &{headers}=                         create dictionary       Content-Type=application/json

#     ${response}=                        post request            nplus   /auth   data=${body}    headers=${headers}
#     log                                 ${response.text}
#     [Return]                            ${response}
