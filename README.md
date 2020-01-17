# Desafio Blumpa

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/0a34d26bfa72bbf1eb07)

Desafio técnico para a vaga de backend na Blumpa.

## Requisitos

- Ruby 2.6.3
- Rails 6.0.2
- Redis

## Como rodar usando o docker?

Para rodar desta forma é necessário instalar o _Docker_ e o _Docker Compose_ em sua máquina. Após instado, siga os passos descritos abaixo:

1. Configure as variáveis de ambiente (.env) na raiz do projeto conforme abaixo:

```bash
REDIS_URL=redis://redis:6379/1
```

2. Inicialize o _compose_ usando:

```bash
  docker-compose up
```

Obs.: No primeiro uso é normal demorar, pois é feito o download das imagens (ruby 2.6.3 e redis) e o container é configurado.

3. Para parar a execução da API, pressione CTRL+C ou CTRL+D.

4. Para rodar os testes use:

```bash
  docker-compose run --rm blumpa-api bundle exec rspec
```

## Como rodar sem o docker?

1. Instale o RVM

```

https://rvm.io/rvm/install

```

2. Instale a versão do Ruby necessária

```bash
  rvm install 2.6.3
```

3. Sete como padrão a versão recém-instalada

```bash
  rvm --default use 2.6.3
```

4. Verifique a versão do Ruby usando:

```bash
  ruby -v
```

Saída esperada:

```bash
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
```

5. Instale o Redis.

6. Configure as variáveis de ambiente (.env) na raiz do projeto conforme abaixo:

```bash
REDIS_URL=redis://127.0.0.1:6379/1
```

7. Instale as _gems_ necessárias usando o _bundle_

```
bundle
```

ou

```
bundle install
```

8. Inicialize a API utilizando o comando

```
  foreman start
```

9. Para rodar os testes utilize:

```
  bundle exec rspec
```

## Endpoints

Os _endpoints_ desta API estão documentados abaixo.

#### Obter data de estreia do personagem no seriado

**URL**

- /api/v1/characters/:id

**Método HTTP:**

- GET

**Parâmetros de URL:**

- **id(inteiro)**: código do personagem a ser exibido.

**Parâmetros no cabeçalho**

Nenhum

**Respostas**

Código: 200
Conteúdo de retorno: Data de estreia do personagem (plain text)

Código: 404 Não encontrado
Motivo: Não existe tal código.

Código: 422 Unprocessable Entity
Motivo: Contém parâmetros inválidos, no caso, o `:id` não é inteiro.

**Exemplo de chamada**

```bash
curl localhost:3000/api/v1/characters/2
```

Resultado:
`December 2, 2013`

## Observações

- A API utiliza consultas externas a API Ricky and Morty (https://rickandmortyapi.com/documentation), portanto, o Redis foi utilizado como mecanismo de _cache_ dos dados;
- Nos testes com o RSpec, utilizou-se a _gem_ `webmock` (https://github.com/bblimke/webmock) para fazer o `mock` das requisições HTTP aos recursos externos.
