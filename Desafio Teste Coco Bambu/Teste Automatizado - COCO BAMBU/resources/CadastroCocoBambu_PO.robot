*** Settings ***
Resource        ../tests/CadastroCocoBambu_Test.robot
Resource        ../common/Common.robot

Library         SeleniumLibrary
Library         Easter
Library         FakerLibrary

*** Variables ***
# Elements
${Nome}                               João
${Email}                              luiz.com
${Senha}                              Coco@2023
${ConfirmarSenha}                     Coco@2023
${SenhaValidação01}                   aaa
${SenhaValidação02}                   aaa123 
${SenhaValidação03}                   Aaa123 
${SenhaValidação04}                   Aaaaa@
${MensagemCampoNome01}                Nome completo obrigatório.
${MensagemCampoNome02}                Digite seu nome completo.
${MensagemCampoE-mail01}              E-mail é obrigatório.
${MensagemCampoE-mail02}              E-mail inválido.
${MensagemCampoSenha01}               Senha é obrigatória.
${MensagemCampoSenha02}               Senha deve conter no mínimo 6 caracteres.
${MensagemCampoSenha03}               Sua senha deve conter no mínimo 1 caractere maiúsculo.
${MensagemCampoSenha04}               Sua senha deve conter no mínimo 1 caractere especial.
${MensagemCampoSenha05}               Sua senha deve conter no mínimo 1 número.
${MensagemCampoConfirmarSenha01}      Confirmação de senha é obrigatória.
${MensagemCampoConfirmarSenha02}      As senhas inseridas são diferentes.
${MensagemCampoSelecioneSeuEstado}    Estado é obrigatório.
${TelaPolíticaDePrivacidade}          POLÍTICA DE PRIVACIDADE
${Autenticação}                       Autenticação

# Locators
${BotãoCadastre-se}                   //span[@class='link'][contains(.,'Cadastre-se')]
${SelecioneSeuEstado}                 //ion-select[@formcontrolname='regionId']
${EstadoSelecionado}                  //button[contains(.,'Alagoas')]
${SelecionarMensagem01}               //ion-label[contains(text(),'Desejo receber notificações personalizadas.')]
${ClicarSelecionarMensagem01}         //ion-checkbox[@formcontrolname='customNotification']
${SelecionarMensagem02}               //ion-label[contains(text(),' Ao clicar em ')]
${ClicarSelecionarMensagem02}         //ion-checkbox[@formcontrolname='termsAndConditions']
${BotãoAceitar}                       //button[@type='undefined'][contains(.,'ACEITAR')]
${BotãoCadastrar}                     //button[contains(.,'CADASTRAR')]
${ElementoCódigoEnviado}              //h1[contains(.,'CÓDIGO ENVIADO')]
${BotãoFechar}                        //button[@type='undefined'][contains(.,'FECHAR')]
${ClicarCampoNome}                    //register-popup//input[@name='name']
${ClicarCampoE-mail}                  //form[@id='formRegisterUser']//input[@name='username']
${ClicarCampoSenhaLogin}              //input[@name='password']  
${ClicarCampoSenha}                   //form[@id='formRegisterUser']//input[@name='password']
${ClicarCampoConfirmarSenha}          //input[contains(@name,'confirmPassword')]
${SelecioneSeuEstadoCancelar}         //button[@type='button'][contains(.,'Cancel')]
${VoltarPolíticaDeDados}              //img[contains(@class,'ng-star-inserted')]

*** Keywords ***

# CT 001: Cadastro validado:  
Dado que o usuário está na tela de cadastro do site
    Tela de login do site
    Wait Until Element Is Visible        ${BotãoCadastre-se}
    Click Element                        ${BotãoCadastre-se}
E preenche o campo “Nome completo”
    ${Nome}         FakerLibrary.First Name
    ${Sobrenome}    FakerLibrary.Last Name
    Preencher campo 1                    Nome completo    ${Nome} ${Sobrenome}       
E preenche o campo “E-mail” Na Tela de Cadastro
    ${EmailData}    FakerLibrary.Free Email
    Preencher campo 2                    username    ${EmailData}
E preenche o campo “Senha” Na Tela de Cadastro
    Preencher campo 2                    password    ${Senha}
E preenche o campo “Confirmar senha”
    Preencher campo 1                    Confirmar senha    ${ConfirmarSenha}
E seleciona a opção no campo “Selecione seu estado”
    Wait Until Element Is Visible        ${SelecioneSeuEstado}
    Click Element                        ${SelecioneSeuEstado}
    Wait Until Element Is Visible        ${EstadoSelecionado}
    Click Element                        ${EstadoSelecionado}
    Wait Until Element Is Not Visible    ${EstadoSelecionado}
E seleciona a opção após ler a mensagem “Desejo receber notificações personalizadas”
    Page Should Contain Element          ${SelecionarMensagem01}
    Capture Element Screenshot           ${SelecionarMensagem01}
    Click Element                        ${ClicarSelecionarMensagem01}
    Sleep    3
E seleciona a opção após ler a mensagem “Ao clicar em cadastrar você concorda com nossos termos e condições de uso.”
    Page Should Contain Element          ${SelecionarMensagem02}
    Capture Element Screenshot           ${SelecionarMensagem02}
    Click Element                        ${ClicarSelecionarMensagem02}
    Sleep    3
    Page Should Contain                  ${TelaPolíticaDePrivacidade}
    Wait Until Element Is Visible        ${BotãoAceitar}
    Click Element                        ${BotãoAceitar}
    Sleep    3
Quando clica no botão “CADASTRAR”
    Wait Until Element Is Visible        ${BotãoCadastrar}
    Click Element                        ${BotãoCadastrar}
Então o sistema apresenta a mensagem “CÓDIGO ENVIADO, O seu CÓDIGO foi enviado para o E-MAIL informado. Caso não encontre na caixa de entrada, verifique na caixa de SPAM e marque em CONFIAR para receber novos e-mails Coco Bambu.” confirmando o cadastro
    Wait Until Element Is Visible        ${ElementoCódigoEnviado} 
    Wait Until Element Is Visible        ${BotãoFechar}
    Click Element                        ${BotãoFechar}
E direciona o usuário para a tela de autenticação
    Page Should Contain                  ${Autenticação} 



# CT 002: Validar campo “Nome completo”;
# STEP 001: Validar campo obrigatório “Nome completo”: 
# Dado que o usuário está na tela de cadastro do site
Quando clica no campo “Nome completo” para preenchimento
    Wait Until Element Is Visible        ${ClicarCampoNome}
    Sleep  0.5
    Click Element                        ${ClicarCampoNome}
E não preenche o campo "Nome completo"
    Click Element                        ${ClicarCampoE-mail}
Então o sistema apresenta a mensagem “Nome completo obrigatório.” na tela
    Wait Until Page Contains             ${MensagemCampoNome01}
    Page Should Contain                  ${MensagemCampoNome01}

# STEP 002: Validar sobrenome no campo “Nome completo”:  
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “Nome completo” para preenchimento
E preenche apenas com o primeiro nome
    Input Text                           ${ClicarCampoNome}    ${Nome}
Então o sistema apresenta a mensagem “Digite seu nome completo.” na tela
    Wait Until Page Contains             ${MensagemCampoNome02}
    Page Should Contain                  ${MensagemCampoNome02}


# CT 003: Validar campo “E-mail”;
# STEP 001: Validar campo obrigatório “E-mail”:
# Dado que o usuário está na tela de cadastro do site
Quando clica no campo “E-mail” para preenchimento
    Wait Until Element Is Visible        ${ClicarCampoE-mail}
    Sleep  0.5
    Click Element                        ${ClicarCampoE-mail}
E não o preenche o campo “E-mail”
    Click Element                        ${ClicarCampoNome}
Então o sistema apresenta a mensagem “E-mail é obrigatório.” na tela
    Wait Until Page Contains             ${MensagemCampoE-mail01}
    Page Should Contain                  ${MensagemCampoE-mail01}

# STEP 002: Validar padrão de email no campo “E-mail”:
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “E-mail” para preenchimento
E preenche o campo fora do padrão de email
    Input Text                           ${ClicarCampoE-mail}    ${Email}
Então o sistema apresenta a mensagem “E-mail inválido.” na tela
    Wait Until Page Contains             ${MensagemCampoE-mail02}
    Page Should Contain                  ${MensagemCampoE-mail02}


# CT 004: Validar campo “Senha”;
# STEP 001: Validar campo obrigatório “Senha”:
# Dado que o usuário está na tela de cadastro do site
Quando clica no campo “Senha” para preenchimento
    Wait Until Element Is Visible        ${ClicarCampoSenha}
    Sleep  0.5
    Click Element                        ${ClicarCampoSenha}
E não o preenche o campo “Senha”
    Click Element                        ${ClicarCampoNome}
Então o sistema apresenta a mensagem “Senha é obrigatória.” na tela
    Wait Until Page Contains             ${MensagemCampoSenha01}
    Page Should Contain                  ${MensagemCampoSenha01}

# STEP 002: Validar padrão de senha no campo “Senha - Senha deve conter no mínimo 6 caracteres.”:
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “Senha” para preenchimento 
#     Click Element                        ${ClicarCampoSenha}
E preenche o campo fora do padrão “Senha deve conter no mínimo 6 caracteres.”
    Input Text                           ${ClicarCampoSenha}    ${SenhaValidação01}
Então o sistema apresenta a mensagem “Senha deve conter no mínimo 6 caracteres.” na tela
    Wait Until Page Contains             ${MensagemCampoSenha02}
    Page Should Contain                  ${MensagemCampoSenha02}

# STEP 003: Validar padrão de senha no campo “Senha - Sua senha deve conter no mínimo 1 caractere maiúsculo.”:
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “Senha” para preenchimento
E preenche o campo fora do padrão “Sua senha deve conter no mínimo 1 caractere maiúsculo.”
    Input Text                           ${ClicarCampoSenha}    ${SenhaValidação02}
Então o sistema apresenta a mensagem “Sua senha deve conter no mínimo 1 caractere maiúsculo.” na tela
    Wait Until Page Contains             ${MensagemCampoSenha03}
    Page Should Contain                  ${MensagemCampoSenha03}

# STEP 004: Validar padrão de senha no campo “Senha - Sua senha deve conter no mínimo 1 caractere especial.”:
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “Senha” para preenchimento
E preenche o campo fora do padrão “Sua senha deve conter no mínimo 1 caractere especial.”
    Input Text                           ${ClicarCampoSenha}    ${SenhaValidação03}
Então o sistema apresenta a mensagem “Sua senha deve conter no mínimo 1 caractere especial.” na tela
    Wait Until Page Contains             ${MensagemCampoSenha04}
    Page Should Contain                  ${MensagemCampoSenha04}

# STEP 005: Validar padrão de senha no campo “Senha - Sua senha deve conter no mínimo 1 número.”:
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “Senha” para preenchimento
E preenche o campo fora do padrão Sua senha deve conter no mínimo 1 número.
    Input Text                           ${ClicarCampoSenha}    ${SenhaValidação04}
Então o sistema apresenta a mensagem “Sua senha deve conter no mínimo 1 número.” na tela
    Wait Until Page Contains             ${MensagemCampoSenha05}
    Page Should Contain                  ${MensagemCampoSenha05}


# CT 005: Validar campo “Confirmar senha”;
# STEP 001: Validar campo obrigatório “Confirmar senha”:
# Dado que o usuário está na tela de cadastro do site
Quando clica no campo “Confirmar senha” para preenchimento
    Wait Until Element Is Visible        ${ClicarCampoConfirmarSenha}
    Click Element                        ${ClicarCampoConfirmarSenha}
    Sleep    3
E não o preenche o campo “Confirmar senha”
    Click Element                        ${ClicarCampoNome}
Então o sistema apresenta a mensagem “Confirmação de senha é obrigatória.” na tela
    Wait Until Page Contains             ${MensagemCampoConfirmarSenha01}
    Page Should Contain                  ${MensagemCampoConfirmarSenha01}
    Wait Until Element Is Visible        ${ClicarCampoConfirmarSenha}

# STEP 002: Validar igualdade da senha no campo “Confirmar senha”:
# Dado que o usuário está na tela de cadastro do site
# Quando clica no campo “Confirmar senha” para preenchimento
E preenche o campo de maneira diferente do campo “Senha” 
    Wait Until Element Is Visible        ${ClicarCampoConfirmarSenha}
    Input Text                           ${ClicarCampoConfirmarSenha}    ${Senha}
Então o sistema apresenta a mensagem “As senhas inseridas são diferentes.” na tela
    Wait Until Page Contains             ${MensagemCampoConfirmarSenha02}
    Page Should Contain                  ${MensagemCampoConfirmarSenha02}


# CT 006: Validar campo obrigatório “Selecione seu Estado”:
# Dado que o usuário está na tela de cadastro do site
Quando clica no campo “Selecione seu Estado.” para seleção
    Wait Until Element Is Visible        ${SelecioneSeuEstado}
    Sleep    2
    Click Element                        ${SelecioneSeuEstado}
    Sleep    1
E não seleciona nenhum Estado apresentado
    Wait Until Element Is Visible        ${SelecioneSeuEstadoCancelar}
    Click Element                        ${SelecioneSeuEstadoCancelar}
    Sleep    1
Então o sistema apresenta a mensagem “Estado é obrigatório.” na tela
    Wait Until Page Contains             ${MensagemCampoSelecioneSeuEstado}
    Page Should Contain                  ${MensagemCampoSelecioneSeuEstado}

# CT 007: Validar a não seleção do campo obrigatório “POLÍTICA DE PRIVACIDADE”:
# Dado que o usuário está na tela de cadastro do site
Quando seleciona a opção após ler a mensagem “Ao clicar em cadastrar você concorda com nossos termos e condições de uso”
    Page Should Contain Element          ${SelecionarMensagem02}
    Wait Until Element Is Visible        ${SelecionarMensagem02}
    Click Element                        ${ClicarSelecionarMensagem02}
    Sleep    3  
E na tela “POLÍTICA DE PRIVACIDADE” clica no ícone “Voltar” no canto superior esquerdo
    Page Should Contain                  ${TelaPolíticaDePrivacidade} 
    Wait Until Element Is Visible        ${VoltarPolíticaDeDados}
    Click Element                        ${VoltarPolíticaDeDados}
Então o sistema não seleciona a opção
    Wait Until Element Is Visible        ${ClicarSelecionarMensagem02}
    Page Should Contain Element          ${ClicarSelecionarMensagem02}



