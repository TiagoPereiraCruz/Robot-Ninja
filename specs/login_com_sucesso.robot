*** Settings ***
Documentation  O usuário informa suas credenciais de acesso e submete o formulário de login
Resource  ../resources/login_steps.robot

Test Setup      Abrir navegador
Test Teardown   Fechar navegador

*** Test Cases ***
Login com sucesso
  Fazendo Login com "tiago@ninjaplus.com" e senha "pwd123"
  Devo ver o meu nome "Tiago" na área logada
