*** Settings ***
Documentation  O usuário informa suas credenciais de acesso e submete o formulário de login
Resource  ../resources/login_steps.robot

Test Setup      Abrir navegador
Test Teardown   Fechar navegador

*** Test Cases ***
Login com sucesso
  Fazendo Login com "tiago@ninjaplus.com" e senha "pwd123"
  Devo ver o meu nome "Tiago" na área logada

Email deve ser requerido
  Fazendo Login com "" e senha "pwd123"
  Devo ver a seguinte mensagem de alerta "Opps. Cadê o email?"

Senha deve ser requerida
  Fazendo Login com "tiago@ninjaplus.com" e senha ""
  Devo ver a seguinte mensagem de alerta "Opps. Cadê a senha?"
