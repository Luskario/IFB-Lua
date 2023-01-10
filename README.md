# Lua

    Alunos(as): Andressa Nunes, Arthur Carlos Neuhauss
          Jackson Yuri, Lucas Rodrigues Vasconcelos
    Curso: ABI - Ciência da Computação
    Matéria: Paradigmas de Programação

## Tecnologias utilizadas
1. **Lua:** Linguagem de Programação.
2. **Love2d** Engine de jogos

## Método utilizado: 


## Lista de atividades com uma provável data de entrega 


Andressa - Introdução;
Andressa - Características;
Lucas - Plataforma de desenvolvimento e execução;
Lucas - Exemplos de código das principais características (com explicação);
Jacksson - Paradigma associado (indicar qual paradigma pertence - justificando);
Jacksson - Legibilidade;
Jacksson - Confiabilidade;
Arthur - Custo;
Andressa - Onde se utiliza/indicado para quê;
Arthur - Mercado de trabalho;
Arthur - Associação com nos cursos de Bacharelado e/ou Licenciatura em Computação (Justificar se é relevante ser vista no curso? );
Lucas - Desenvolver uma aplicação que demonstre as características da linguagem.


## Asteroids - Resumo do Código

- O Projeto em questão foi desenvolvido utilizando do motor gráfico (Engine) Love2d na linguagem lua, que compreende o clássico jogo “Asteroids”, neste o usuário dispõe do teclado para controlar uma nave e disparar contra os asteroides que vão surgindo no espaço. O objetivo principal do jogo é acumular a maior quantidade de pontos possível e evitar que sua nave seja destruída pelos asteroides.
- O jogo é construído utilizando-se dos paradigmas de Programação Orientada a Objeto e Programação Orientada a Eventos, por Lua ser uma linguagem multiparadigmas permitindo fácil implementação.
- As funções no arquivo main.lua rodam todo o jogo, sendo elas a love.load(), que inicia as variáveis e carrega os objetos iniciais; love.update() que atualiza constantemente e observa os eventos do jogo; e a função love.draw() que imprime os objetos e os eventos em em tela.
- Os arquivos nave.lua contem o nosso objeto “Nave” com suas definições e configurações assim como seus métodos e suas funcionalidades que o usuário irá utilizar no decorrer do jogo.
- O arquivo space.lua contem o nosso objeto “Space” que possuirá as definições do ambiente do jogo, como dimensões de tela e o espaço útil de jogo; além de ser responsável pelos eventos que por ele serão provocados, como o controle dos asteroides e  gerador (”spwaner”) de asteroides.

## Executando o Programa
- Para o Ubuntu basta abrir a pasta “/exe” presente no projeto, e rodar o arquivo “asteroids_ubuntu”.
- Para o Windows 10 basta abrir a pasta “/exe” presente no projeto e descompactar o arquivo “asteroids_windows.zip”, posteriormente acessar a pasta descompactada e rodar o arquivo “asteroids_windows.exe".
