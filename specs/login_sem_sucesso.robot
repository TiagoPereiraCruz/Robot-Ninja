*** Settings ***
Documentation   O usuário informa suas credenciais incorretas e é notificado com uma mensagem de alerta
Resource        ../resources/login_steps.robot
Test Template   Logando com credenciais inválidas devo ver uma mensagem de alerta

# DDT (Data Driven Testing)

Test Setup      Abrir navegador
Test Teardown   Fechar navegador

*** Test Cases ***
Senha inválida              papito@ninjaplus.com        asdfgh      Usuário e/ou senha inválidos
Usuario nao cadastrado      ${EMPTY}                    123456      Usuário e/ou senha inválidos