*** Settings ***
Resource        ../tests/LoginCocoBambu_Test.robot
Resource        ../common/Common.robot

Library         SeleniumLibrary
Library         Easter
Library         FakerLibrary


*** Variables ***
# Elements
${E-mailPrincipal}                luzia123456@gmail.com  
${E-mailInválido}                 teste@teste.com
${SenhaPrincipal}                 Abc@1234
${SenhaInválida}                  Abc@1234567
${MensagemE-mailObrigatório}      E-mail é obrigatório.
${MensagemSenhaObrigatória}       Senha é obrigatória.
${MensagemSenhaE-mailInválido}    E-mail ou senha inválidos.
${MensagemCódigoEnviado}          CÓDIGO ENVIADO
${Autenticação}                   Autenticação

# Locator
${CampoE-mailEntrar}              //input[@placeholder='E-mail']
${CampoSenhaClicar}               //input[@placeholder='Senha']
${CampoSenhaEntrar}               //input[@name='password']  
${CampoSenhaAberta}               //input[@name='password'][@type='text']  
${ExibeSenha}                     //img[@src='/assets/icons/eye-active-hide.svg']/parent::div
${BotãoEntrar}                    //button[contains(.,'ENTRAR')]
${ElementoCódigoEnviado}          //h1[contains(.,'CÓDIGO ENVIADO')]
${BotãoFechar}                    //button[contains(.,'FECHAR')]

*** Keywords ***

# CT 001: E-mail em branco:
Dado que o usuário está na tela de login do site
    Tela de login do site
Quando clica no campo “E-mail” para preenchimento
    Wait Until Element Is Visible    ${CampoE-mailEntrar} 
    Click Element                    ${CampoE-mailEntrar} 
E não preenche o campo "E-mail"
    Click Element                    ${CampoSenhaClicar} 
Então o sistema apresenta a mensagem “E-mail é obrigatório.” na tela
    Wait Until Page Contains         ${MensagemE-mailObrigatório}
    Page Should Contain              ${MensagemE-mailObrigatório}


# CT 002: Senha em branco:
# Dado que o usuário está na tela de login do site
Quando clica no campo “Senha” para preenchimento
    Wait Until Element Is Visible    ${CampoSenhaClicar}
    Click Element                    ${CampoSenhaClicar}
E não preenche o campo "Senha"
    Click Element                    ${CampoE-mailEntrar}
Então o sistema apresenta a mensagem “Senha é obrigatória.” na tela
    Wait Until Page Contains         ${MensagemSenhaObrigatória} 
    Page Should Contain              ${MensagemSenhaObrigatória} 
     

# CT 003: E-mail inválido:
# Dado que o usuário está na tela de login do site
E preenche o campo “E-mail” com um email inválido
    Wait Until Element Is Visible    ${CampoE-mailEntrar}
    Input Text                       ${CampoE-mailEntrar}    ${E-mailInválido}
E preenche o campo “Senha”
    Wait Until Element Is Visible    ${CampoSenhaClicar} 
    Input Text                       ${CampoSenhaClicar}    ${SenhaPrincipal}
Quando clica no botão “ENTRAR”
    Wait Until Element Is Visible    ${BotãoEntrar} 
    Click Element                    ${BotãoEntrar} 
Então o sistema apresenta a mensagem “E-mail ou senha inválidos.” na tela
    Wait Until Page Contains         ${MensagemSenhaE-mailInválido}
    Page Should Contain              ${MensagemSenhaE-mailInválido}
 

# CT 004: Senha inválido:
# Dado que o usuário está na tela de login do site
E preenche o campo “Senha” com uma senha inválida
    Wait Until Element Is Visible    ${CampoSenhaClicar}
    Input Text                       ${CampoSenhaClicar}    ${SenhaInválida}
E preenche o campo “E-mail”
    Wait Until Element Is Visible    ${CampoE-mailEntrar} 
    Input Text                       ${CampoE-mailEntrar}    ${E-mailPrincipal}
# Quando clica no botão “ENTRAR”
# Então o sistema apresenta a mensagem “E-mail ou senha inválidos.” na tela


# CT 005: Visualizar senha oculta:
# Dado que o usuário está na tela de login do site
Quando preenche o campo “Senha” com uma senha qualquer
    Wait Until Element Is Visible    ${CampoSenhaEntrar}
    InpuT Text                       ${CampoSenhaEntrar}    ${SenhaInválida}
E clica no objeto “VISUALIZAR SENHA OCULTA”
    Click Element                    ${ExibeSenha}
 Então o sistema apresenta a senha que estava ocultada pelo sistema
    Page Should Contain Element      ${CampoSenhaAberta}
    Capture Element Screenshot       ${CampoSenhaAberta}


# CT 006: E-mail e senha corretos, login correto:
# Dado que o usuário está na tela de login do site
E preenche o campo “E-mail” com um email válido
    Preencher campo 1                E-mail    ${E-mailPrincipal}
    Sleep    2
E preenche o campo “Senha” com uma senha válida
    Preencher campo 1                Senha    ${SenhaPrincipal}
    Sleep    2
# Quando clica no botão “ENTRAR”
Então o sistema apresenta em tela a mensagem “CÓDIGO ENVIADO, O seu CÓDIGO foi enviado para o E-MAIL informado. Caso não encontre na caixa de entrada, verifique na caixa de SPAM e marque em CONFIAR para receber novos e-mails Coco Bambu.”
    Wait Until Element Is Visible    ${ElementoCódigoEnviado}
    Page Should Contain              ${MensagemCódigoEnviado}
    Click Element                    ${BotãoFechar}
E direciona o usuário a tela de autenticação
    Page Should Contain              ${Autenticação} 
   



 