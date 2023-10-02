*** Settings ***

Resource             ../resources/CadastroCocoBambu_PO.robot
Resource             ../common/Common.robot


Library              SeleniumLibrary
Library              BuiltIn

Test Setup           Abrir o navegador
Test Teardown        Fechar o navegador


*** Variables ***




*** Test Cases ***

# SUÍTE 02 - Cadastrar Usuário;
CT 001: Cadastro validado
    [Documentation]
    [Tags]    cadastro    
    Dado que o usuário está na tela de cadastro do site
    E preenche o campo “Nome completo”
    E preenche o campo “E-mail” Na Tela de Cadastro 
    E preenche o campo “Senha” Na Tela de Cadastro
    E preenche o campo “Confirmar senha”
    E seleciona a opção no campo “Selecione seu estado”
    E seleciona a opção após ler a mensagem “Desejo receber notificações personalizadas”
    E seleciona a opção após ler a mensagem “Ao clicar em cadastrar você concorda com nossos termos e condições de uso.”
    Quando clica no botão “CADASTRAR” 
    Então o sistema apresenta a mensagem “CÓDIGO ENVIADO, O seu CÓDIGO foi enviado para o E-MAIL informado. Caso não encontre na caixa de entrada, verifique na caixa de SPAM e marque em CONFIAR para receber novos e-mails Coco Bambu.” confirmando o cadastro
    E direciona o usuário para a tela de autenticação

# CT 002: Validar campo “Nome completo”;
STEP 001: Validar campo obrigatório “Nome completo”:
    [Documentation]
    [Tags]    cadastro   
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Nome completo” para preenchimento
    E não preenche o campo "Nome completo"
    Então o sistema apresenta a mensagem “Nome completo obrigatório.” na tela 
   
STEP 002: Validar sobrenome no campo “Nome completo”:
    [Documentation]
    [Tags]    cadastro  
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Nome completo” para preenchimento 
    E preenche apenas com o primeiro nome
    Então o sistema apresenta a mensagem “Digite seu nome completo.” na tela

# CT 003: Validar campo “E-mail”;
STEP 001: Validar campo obrigatório “E-mail”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “E-mail” para preenchimento
    E não o preenche o campo “E-mail”
    Então o sistema apresenta a mensagem “E-mail é obrigatório.” na tela
   
STEP 002: Validar padrão de email no campo “E-mail”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “E-mail” para preenchimento
    E preenche o campo fora do padrão de email
    Então o sistema apresenta a mensagem “E-mail inválido.” na tela

# CT 004: Validar campo “Senha”;
STEP 001: Validar campo obrigatório “Senha”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Senha” para preenchimento
    E não o preenche o campo “Senha”
    Então o sistema apresenta a mensagem “Senha é obrigatória.” na tela
    
STEP 002: Validar padrão de senha no campo “Senha - Senha deve conter no mínimo 6 caracteres.”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Senha” para preenchimento
    E preenche o campo fora do padrão “Senha deve conter no mínimo 6 caracteres.”
    Então o sistema apresenta a mensagem “Senha deve conter no mínimo 6 caracteres.” na tela

STEP 003: Validar padrão de senha no campo “Senha - Sua senha deve conter no mínimo 1 caractere maiúsculo.”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Senha” para preenchimento
    E preenche o campo fora do padrão “Sua senha deve conter no mínimo 1 caractere maiúsculo.”
    Então o sistema apresenta a mensagem “Sua senha deve conter no mínimo 1 caractere maiúsculo.” na tela

STEP 004: Validar padrão de senha no campo “Senha - Sua senha deve conter no mínimo 1 caractere especial.”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Senha” para preenchimento
    E preenche o campo fora do padrão “Sua senha deve conter no mínimo 1 caractere especial.”
    Então o sistema apresenta a mensagem “Sua senha deve conter no mínimo 1 caractere especial.” na tela

STEP 005: Validar padrão de senha no campo “Senha - Sua senha deve conter no mínimo 1 número.”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Senha” para preenchimento
    E preenche o campo fora do padrão Sua senha deve conter no mínimo 1 número.
    Então o sistema apresenta a mensagem “Sua senha deve conter no mínimo 1 número.” na tela

# CT 005: Validar campo “Confirmar senha”;
STEP 001: Validar campo obrigatório “Confirmar senha”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Confirmar senha” para preenchimento
    E não o preenche o campo “Confirmar senha”
    Então o sistema apresenta a mensagem “Confirmação de senha é obrigatória.” na tela

STEP 002: Validar igualdade da senha no campo “Confirmar senha”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Confirmar senha” para preenchimento
    E preenche o campo de maneira diferente do campo “Senha” 
    Então o sistema apresenta a mensagem “As senhas inseridas são diferentes.” na tela

CT 006: Validar campo obrigatório “Selecione seu Estado”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando clica no campo “Selecione seu Estado.” para seleção
    E não seleciona nenhum Estado apresentado
    Então o sistema apresenta a mensagem “Estado é obrigatório.” na tela

CT 007: Validar a não seleção do campo obrigatório “POLÍTICA DE PRIVACIDADE”:
    [Documentation]
    [Tags]    cadastro
    Dado que o usuário está na tela de cadastro do site
    Quando seleciona a opção após ler a mensagem “Ao clicar em cadastrar você concorda com nossos termos e condições de uso”
    E na tela “POLÍTICA DE PRIVACIDADE” clica no ícone “Voltar” no canto superior esquerdo
    Então o sistema não seleciona a opção
    


     
 