*** Settings ***

Library        SeleniumLibrary    
Library        OperatingSystem
Library        String
Library        Process
Library        REST


*** Variables ***

${browser}          chrome
${SiteCocoBambu}    https://app.cocobambu.com/delivery

*** Keywords ***

Abrir o navegador
    Open Browser                     ${SiteCocoBambu}    ${browser}
    Maximize Browser Window

Fechar o navegador
    Set Screenshot Directory         path=TestCase\Screenshot
    Capture Page Screenshot
    Close Browser

Tela de login do site
    Go To    ${SiteCocoBambu}
    Wait Until Element Is Visible    //div[@class='ng-tns-c101-0 nav-button ng-star-inserted'][contains(.,'Perfil')]
    Click Element                    //div[@class='ng-tns-c101-0 nav-button ng-star-inserted'][contains(.,'Perfil')]
    Wait Until Element Is Visible    //div[@class='option-item clickable'][contains(.,'Entrar')]
    Click Element                    //div[@class='option-item clickable'][contains(.,'Entrar')]
    Wait Until Element Contains      //p[contains(.,'Seja bem-vindo ao melhor restaurante do Brasil!')]    Seja bem-vindo ao melhor restaurante do Brasil!

Preencher campo 1
    [Arguments]    ${Locator}    ${Texto}
    Wait Until Element Is Visible    //input[@placeholder='${Locator}']
    Input Text                       //input[@placeholder='${Locator}']    ${Texto}
   
Preencher campo 2
    [Arguments]    ${Locator}    ${Texto}
    Wait Until Element Is Visible    //form[@id='formRegisterUser']//input[@name='${Locator}']
    Input Text                       //form[@id='formRegisterUser']//input[@name='${Locator}']    ${Texto}