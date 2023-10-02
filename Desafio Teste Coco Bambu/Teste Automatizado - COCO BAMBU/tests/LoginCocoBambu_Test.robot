*** Settings ***
Resource            ../resources/LoginCocoBambu_PO.robot
Resource            ../common/Common.robot

Library              SeleniumLibrary

Test Setup           Abrir o navegador
Test Teardown        Fechar o navegador


*** Variables ***

*** Test Cases ***

CT 001: E-mail em branco:
    [Documentation]
    [Tags]    login  
    Dado que o usuário está na tela de login do site
    Quando clica no campo “E-mail” para preenchimento
    E não preenche o campo "E-mail"
    Então o sistema apresenta a mensagem “E-mail é obrigatório.” na tela
    
CT 002: Senha em branco:
    [Documentation]
    [Tags]    login
    Dado que o usuário está na tela de login do site
    Quando clica no campo “Senha” para preenchimento
    E não preenche o campo "Senha"
    Então o sistema apresenta a mensagem “Senha é obrigatória.” na tela

CT 003: E-mail inválido:
    [Documentation]
    [Tags]    login
    Dado que o usuário está na tela de login do site
    E preenche o campo “E-mail” com um email inválido
    E preenche o campo “Senha”
    Quando clica no botão “ENTRAR”
    Então o sistema apresenta a mensagem “E-mail ou senha inválidos.” na tela

CT 004: Senha inválido:
    [Documentation]
    [Tags]    login
    Dado que o usuário está na tela de login do site
    E preenche o campo “Senha” com uma senha inválida
    E preenche o campo “E-mail”
    Quando clica no botão “ENTRAR”
    Então o sistema apresenta a mensagem “E-mail ou senha inválidos.” na tela

CT 005: Visualizar senha oculta:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de login do site 
    Quando preenche o campo “Senha” com uma senha qualquer
    E clica no objeto “VISUALIZAR SENHA OCULTA” 
    Então o sistema apresenta a senha que estava ocultada pelo sistema
    
CT 006: E-mail e senha corretos, login correto:
    [Documentation]
    [Tags]    login
    Dado que o usuário está na tela de login do site    
    E preenche o campo “E-mail” com um email válido
    E preenche o campo “Senha” com uma senha válida
    Quando clica no botão “ENTRAR”
    Então o sistema apresenta em tela a mensagem “CÓDIGO ENVIADO, O seu CÓDIGO foi enviado para o E-MAIL informado. Caso não encontre na caixa de entrada, verifique na caixa de SPAM e marque em CONFIAR para receber novos e-mails Coco Bambu.”
    E direciona o usuário a tela de autenticação



