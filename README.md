# Bytebank web API

Web API em Spring Boot para consumo do App em Flutter do Bytebank

## Funcionalidades

A Web API oferece as seguintes funcionalidades:

- Listagem e cadastro de transferências;
- Listagem, cadastro e atualização de features.

## Como executar

Após clonar o projeto, dentro do diretório raiz, execute a task `bootRun` do Gradle. A primeira execução vai realizar o download de todas dependências necessárias.

> O uso do Wrapper é recomendado `gradlew` ou `gradlew.bat` para garantir a compatibilidade.

Também é possível executar o projeto via arquivo jar gerado pela task `build` que é armazenado no diretório **build/libs/nome-do-arquivo.jar**. Para executar basta usar o seguinte comando:

```
java -jar nome-do-arquivo.jar
```

> A build do projeto foi feita com base no Java 8, portanto, é recomendado usar o Java 8 para que tudo funcione como esperado.

## Modificando properties de inicialização

Por padrão o Spring Boot vai rodar a aplicação na porta `8080` e vai exigir a senha para criar transferências com o valor `1000`.

Caso queria modificar ambos valores, edite os valores das propriedades:


```
server:
  port: ${port:8081}
user:
  password: ${password:2000}
```

Na amostra acima, durante a execução a aplicação vai operar na porta `8081` e a senha para as transações será `2000`.

## Modificando propridades durante a execução

Também é possível modificar as propridades via command line durante a execução.

### Via task `bootRun` do Gradle

Com o Gradle você pode alterar os valores das properties por meio do comando `-args`:

```
./gradlew bootRun --args='--server.port=8081 --user.password=2000'
```

### Via arquivo jar gerado

Caso execute pelo arquivo jar,

```
java -jar nome-do-arquivo.jar --server.port=8081 --user.password=2000
```

## Mapeamento de end-points

Para acessar as funcionalidades foram disponibilizados os seguintes end-points:

- `/transferencias`:
  - **GET**: Listagem:
    - O resultado é ordenado pela data e hora da criação em ordem crescente.

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

  - **POST**: Inserção:
    - Para salvar a transação é necessário o envio do *header* `senha` conforme o valor configurado na aplicação:
      - Caso não seja enviado, é retornado `400 BAD REQUEST`;
      - Caso falhar na autenticação `401 UNAUTHORIZED`.
    - Não é possível alterar a transação, caso haja a tentativa é retornado `409 CONFLICT`.

  ```
  // exemplo via body
  {
    	"valor": 1000.0,
    	"contato": {
    		"nome": "gui",
    		"numeroConta": 1000
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

  - **GET**: Listagem de todas as features cadastradas.

  ```
  // exemplo como resposta
  [
      {
          "id" : 1
      },
      {
          "id" : 2
      }
  ]
  ```

  - **POST**: Inserção:
    - É necessário enviar o `id` via corpo da requisição. Essa mesma abordagem permite alterar a feature.

  ```
  // exemplo via body
  {
      "id": 3
  }

  // representação como resposta
  {
      "id": 3
  }  
  ```
  
  Por padrão, todas as features adicionadas estão indisponíveis, para torná-las disponíveis, envie o argumento `disponivel` com valor `true` no corpo da requisição durante o cadastro ou atualização:
  
    ```
    // exemplo via body
    {
        "id": 4,
        "disponivel": true
    }
  
    // representação como resposta
    {
        "id": 4
    }  
    ```

- `/features/disponiveis`:
  - **GET**: listagem de todas as features cadastradas que estão com status disponível.

  ```
  // exemplo como resposta
  [
      {
          "id": 1
      },
      {
          "id": 2
      },
      {
          "id": 4
      }
  ]
  ```
