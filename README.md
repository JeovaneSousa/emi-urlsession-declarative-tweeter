# emi-learning-task-12.3
Explorando o Mundo iOS - Learning Task 12.3

## Implementando o fluxo de criação de tuíts

Chegou o momento do desafio da seção. Nessa atividade a ideia é que você construa um projeto baseado na App do Twitter. A ideia é termos o fluxo de navegação abaixo implementado e consumindo a Tuítr API. Não só as habilidades das últimas duas seções serão importantes nesse desafio. Você vai precisar colocar tudo em jogo, além de precisar buscar soluções para alguns comportamentos de alguns componentes necessários. 🚀

* Abaixo você confere a imagem que ilustra o fluxo de navegação esperado ao fim do desafio:

    ![Imagem com a especificação alvo para o desafio, com a navegacão da tela com a lista de tuíts para a tela de criação de novo tuít](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt3-especificacao-alvo.jpg?raw=true)

* Nas imagens abaixo você confere o detalhamento das propriedades do design e comportamento para o desafio:

    1. Especificações de dimensionamento e espaçamento para os componentes do design:

        ![Imagem com a especificação de design para o desafio, com os padrões de valores de dimensionamento e espaçamento para os componentes](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt3-especificacao-de-design-1.jpg?raw=true)

    1. Propriedades de design dos componentes da tela com a lista de tuíts:

        ![Imagem com a especificação de design para o desafio, com as propriedades de design dos componentes da tela com a lista de tuíts](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt3-especificacao-de-design-2.jpg?raw=true)

    1. Propriedades de design dos componentes da tela de criação de um novo tuít:

        ![Imagem com a especificação de design para o desafio, com as propriedades de design dos componentes da tela de criação de novo tuít](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt3-especificacao-de-design-3.jpg?raw=true)

    1. Comportamento esperado da tela de criação de um novo tuít:

        ![Imagem com a especificação do comportamento, com as propriedades de design que se alteram de acordo com os estados da funcionalidade](https://raw.githubusercontent.com/zup-academy/materiais-publicos-treinamentos/main/explorando-o-mundo-ios/imagens/urlsession-post-lt3-especificacao-de-design-4.jpg?raw=true)

Os endpoints que deverão ser consumidos na atividade são: (i) https://tuitr-api.herokuapp.com/api/feed que retorna uma lista com todos os os posts para o feed de um usuário logado através de um _GET Request_; e (ii) https://tuitr-api.herokuapp.com/api/post enviando o conteúdo do Post criado e que retorna o novo Post através de um _POST Request_. Todo o código de criação da _View_, _Controllers_, Modelos e consumo desta API fica por sua conta 😎.

> Nota: Todo o trabalho se dá pelo consumo de uma API construída internamente para simular o contexto da app do twitter. Nem todos os dados podem ser verídicos. Por razões de infraestrutura, é esperado que alguns requests tenham seu tempo de resposta aumentado, já que algumas vezes o serviço precisará ser inicializado devido a indisponibilidade por tempo de inatividade. Os recursos também são limitados, então, faça um uso consciente durante sua atividade para evitar indisponilibidade prolongada. Você pode consultar a documentação da API através do link https://tuitr-api.herokuapp.com/swagger-ui/index.html, ou mesmo o projeto da API desenvolvido em Java em https://github.com/rafael-rollo/tuitr-api. Rodar o projeto localmente também pode ser uma boa opção em tempo de desenvolvimento. ✌🏻
