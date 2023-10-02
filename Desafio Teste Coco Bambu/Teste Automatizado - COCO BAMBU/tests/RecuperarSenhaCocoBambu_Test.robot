*** Settings ***
Resource            ../resources/RecuperarSenhaCocoBambu_PO.robot
Resource            ../common/Common.robot

Library              SeleniumLibrary

Test Setup           Abrir o navegador
Test Teardown        Fechar o navegador


*** Variables ***



*** Test Cases ***

# SUÍTE 03 - Resetar Senha;
CT 001: Recuperar senha:
    [Documentation]
    [Tags]    resetar   
    Dado que o usuário está na tela de recuperar senha do site
    Quando preenche o campo “E-mail” com um e-mail já cadastrado
    E clica no botão “RECUPERAR”
    Então o sistema apresenta em tela a mensagem “Nós te enviamos por e-mail as instruções para redefinição de sua senha, se existir uma conta com o e-mail que você forneceu. Você receberá a mensagem em breve.”, confirmando a ação

CT 002: Cancelar recuperação de senha:
    [Documentation]
    [Tags]    resetar
    Dado que o usuário está na tela de recuperar senha do site
    Quando preenche o campo “E-mail” com um e-mail já cadastrado
    E clica no botão “CANCELAR”
    Então o sistema cancela a ação retornando a tela de login
    
