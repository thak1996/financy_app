# Financy App

Um aplicativo de finanças construído com Flutter, utilizando o padrão BLoC/Cubit para gerenciamento de estado, Firebase para autenticação e Cloud Functions, e Hasura para a API GraphQL.

## Visão Geral da Arquitetura

- **Gerenciamento de Estado**: Padrão BLoC/Cubit, onde cada tela possui seus próprios arquivos `controller`, `state` e `page`.
- **Backend**: Firebase (Autenticação, Cloud Functions) e Hasura (API GraphQL).
- **Tratamento de Erros**: Utiliza o pacote `result_dart` para um tratamento de sucesso/falha claro e previsível nos serviços.
- **Navegação**: Um `AppScaffold` central com um `PageView` gerencia as telas principais da aplicação.

## Pré-requisitos

- SDK do Flutter (versão 3.x.x ou superior)
- Node.js (para as Firebase Functions)
- Firebase CLI (`npm install -g firebase-tools`)
- Um editor como VS Code ou Android Studio

## Configuração do Projeto

Siga estes passos para configurar o ambiente de desenvolvimento.

### 1. Configuração do Firebase

1.  **Crie um Projeto Firebase**: Vá para o [Firebase Console](https://console.firebase.google.com/) e crie um novo projeto.

2.  **Configuração do Android**:

    - Adicione um aplicativo Android ao seu projeto Firebase.
    - Use `com.example.financy_app` como o nome do pacote (conforme definido em `android/app/build.gradle.kts`).
    - Baixe o arquivo `google-services.json` gerado.
    - **Coloque o arquivo `google-services.json` no diretório `android/app/`**.

3.  **Habilitar Autenticação**:
    - No Firebase Console, vá para `Authentication` -> `Sign-in method`.
    - Habilite o provedor `Email/Password`.

### 2. Configuração do Hasura

Este projeto utiliza o Hasura para sua API GraphQL.

1.  Crie um projeto no [Hasura Cloud](https://cloud.hasura.io/).
2.  Após o projeto estar em execução, vá para o painel do projeto para encontrar seu **endpoint da API GraphQL** e seu **Admin Secret**. Você precisará deles para o próximo passo.

### 3. Configuração das Firebase Functions

A lógica de backend, como gatilhos de registro de usuário, reside no diretório `functions/`.

1.  **Instalar Dependências**:

    ```bash
    cd functions
    npm install
    ```

2.  **Configurar Variáveis de Ambiente**: As funções precisam se conectar à sua instância do Hasura. Defina-as como configurações de ambiente do Firebase. **Substitua os placeholders com suas credenciais reais do Hasura.**

    ```bash
    firebase functions:config:set hasura.graphql_endpoint="SEU_ENDPOINT_HASURA_GRAPHQL" hasura.admin_secret="SEU_ADMIN_SECRET_HASURA"
    ```

    _Exemplo:_
    `firebase functions:config:set hasura.graphql_endpoint="https://meu-projeto.hasura.app/v1/graphql" hasura.admin_secret="chavemuitosecreta"`

3.  **Fazer Deploy das Funções**: Após definir a configuração, faça o deploy das funções para o Firebase.

    ```bash
    firebase deploy --only functions
    ```

4.  **Executar Funções Localmente (Opcional)**: Para testar as funções localmente, você pode usar o Firebase Emulator Suite.
    - Crie um arquivo `.env` dentro do diretório `functions` com as mesmas chaves para teste local.
    - Execute o emulador:
    ```bash
    firebase emulators:start
    ```

## Executando a Aplicação Flutter

1.  **Obter Dependências**:

    ```bash
    flutter clean
    flutter pub get
    ```

2.  **Executar o Aplicativo**:
    ```bash
    flutter run
    ```

## Estrutura do Projeto

- `lib/app/data`: Contém models, repositórios e serviços (camada de dados).
- `lib/app/page`: Contém todas as telas da UI, organizadas por funcionalidade.
- `lib/app/shared`: Contém widgets, constantes, temas e utilitários compartilhados.
- `functions/`: Contém o código de backend em Node.js para
