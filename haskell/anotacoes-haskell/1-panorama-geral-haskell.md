# Panorama geral da linguagem haskell

## Aplicação parcial (partial aplication)

- Quando se tem uma funcao que recebe mais de um argumento como por exemplo,
``
add = \x -> \y x + y.
`` Podemos gerar uma nova função aplicando parcialmente os argumentos como por exemplo ...

```haskell

add = \x -> \y -> x + y
add2 = add 2

-- Agora a função add2 é como se estivese => add2 (\y -> 2 + y) aplicando add2.

add2 4 -- isso vai dar 6


```

- A principal ideia de uma aplicação parcial é pegar funções extremamentes generica e criando funcões mais especializadas

----

## Fazer rodar um arquivo no interpretador ghci

- Criando um arquivo com nome ``demo.hs``

```haskell
    square :: Float -> Float
    square x = x * x

    delta :: (Float, Float, Float) -> Float
    delta (a,b,c) = sqrt (square b - 4 * a * c)
```

- Agora basta entrar no interpretador e escrever:

```bash
    Prelude> :l demo.hs
```

- Agora o arquivo ``demo.hs`` vai estar sendo carregado dentro da sessao do ``ghci``, sendo possivel usar funções salvas dentro do arquivo.

```bash
    *Main> square 2
    4.0
    *Main> delta (3,5,2)
    1.0
    *Main> :show modules
    Main             ( demo.hs interpreted)
```

----

## Condicionais em haskell

- Uma condicional em haskell é composta por if (expressao) then (primeiro valor a retornar) else (segundo valor a retornar), importante lembrar que o else em haskell é `necessario` pois o if else é tem que necessariamente produzir um valor

```haskell
    signal x = if x >= 0 then 1 else (-1)
```
