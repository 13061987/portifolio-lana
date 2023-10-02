*** Settings ***
Resource        ../tests/RecuperarSenhaCocoBambu_Test.robot
Resource        ../common/Common.robot

Library         SeleniumLibrary
Library         Easter
Library         FakerLibrary


*** Variables ***
# Elements
${EmailRecuerarSenha}        luzia123456@gmail.com 
${MensagemRecuperarSenha}    Nós te enviamos por e-mail as instruções para redefinição de sua senha, se existir uma conta com o e-mail que você forneceu. Você receberá a mensagem em breve.
${MensagemTelaLogin}         Seja bem-vindo ao melhor restaurante do Brasil!

# Locator
${BotãoResetar}              //span[@class='link'][contains(.,'Resetar senha')]
${CampoRecuperarEmail}       //input[contains(@type,'email')]
${BotãoRecuperar}            //span[contains(.,'Recuperar')]
${BotãoCancelar}             //span[contains(.,'Cancelar')]

*** Keywords ***

# SUÍTE 03 - Resetar Senha;
# CT 001: Recuperar senha:   
Dado que o usuário está na tela de recuperar senha do site
    Tela de login do site
    Wait Until Element Is Visible    ${BotãoResetar}
    Click Element                    ${BotãoResetar}
Quando preenche o campo “E-mail” com um e-mail já cadastrado
    Wait Until Element Is Visible    ${CampoRecuperarEmail}
    Input Text                       ${CampoRecuperarEmail}    ${EmailRecuerarSenha}    
E clica no botão “RECUPERAR”
    Click Element                    ${BotãoRecuperar}
Então o sistema apresenta em tela a mensagem “Nós te enviamos por e-mail as instruções para redefinição de sua senha, se existir uma conta com o e-mail que você forneceu. Você receberá a mensagem em breve.”, confirmando a ação
    Wait Until Page Contains         ${MensagemRecuperarSenha}
    Page Should Contain              ${MensagemRecuperarSenha}

    
# # CT 002: Cancelar recuperação de senha:
# Dado que o usuário está na tela de recuperar senha do site
# Quando preenche o campo “E-mail” com um e-mail já cadastrado
E clica no botão “CANCELAR”
    Click Element                    ${BotãoCancelar}
Então o sistema cancela a ação retornando a tela de login
    Wait Until Page Contains         ${MensagemTelaLogin}
    Page Should Contain              ${MensagemTelaLogin}


