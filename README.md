# Bytebank web API

Web API em Spring Boot para consumo do App em Flutter do Bytebank

## Funcionalidades

A Web API ofereces as seguintes funcionalidades:

- Listagem e cadastro de transferências;
- Listagem e cadastro de features.

## Como executar

Após clonar o projeto, dentro do diretório raiz, execute a task `bootRun` do Gradle. A primeira execução vai realizar o download de todas dependências necessárias. Ao finalizar, deve indicar que o servidor está rodando na porta 8080.

> O uso do Wrapper é recomendado `gradlew` ou `gradlew.bat` para garantir a compatibilidade.

## Mapeamento de end-points

Para acessar as funcionalidades estão disponibilizados os seguintes end-points:

- `/transferencias`:
  - **GET**: Listagem;

  ```
  // exemplo como resposta
  [
      {
          "id": "60fd9ea4-42d3-43b0-acc9-9e1a8ff81536",
          "valor": 1000,
          "contato": {
              "nome": "Alex",
              "numeroConta": 1000
          },
          "data": "2019-10-11 12:53:24"
      },
      {
          "id": "d4ffafd8-858b-4350-a40f-ed4ef3d66b51",
          "valor": 200,
          "contato": {
              "nome": "gui",
              "numeroConta": 1000
          },
          "data": "2019-10-11 14:11:44"
      }      
  ]
  ```

  - **POST**: Inserção.

  ```
  // exemplo via body
  {
    	"valor" : 1000.0,
    	"contato" : {
    		"nome" : "gui",
    		"numeroConta" : 1000
    	}
  }

  // exemplo como resposta
  {
      "id": "d4ffafd8-858b-4350-a40f-ed4ef3d66b51",
      "valor": 200,
      "contato": {
          "nome": "gui",
          "numeroConta": 1000
      },
      "data": "2019-10-11 14:11:44"
  }
  ```


- `/features`:

  - **GET**: Listagem;

  ```
  // exemplo como resposta
  [
      {
          "nome": "historico",
          "disponivel": true
      },
      {
          "nome": "transferir",
          "disponivel": true
      }
  ]
  ```

  - **POST**: Inserção.

  ```
  // exemplo via body
  {
      "nome": "ajuda"
  }

  // representação como resposta
  {
      "nome": "ajuda",
      "disponivel": false
  }  
  ```
