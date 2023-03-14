# Sistema de tipos em haskell

## O que são tipos

- São estiquetas associadas a valores e expressoes
- Sistema de regras + inferencia de tipos

### Contexto == sigma (Σ)

- Um contexto é uma função que recebe expressoes e mapeia ela em um tipo(etiqueta).

- Regra das variaveis => dato um contexto(Σ) o contexto vai resultar em  `Σ |- x:t` (uma variavel(expressao) `x` tem o tipo `t`) isso vai ser verdade quando `x` com a etiqueta `t` pertencer ao `contexto(Σ)`.

- Regra das constantes => se uma constante `K` tiver o tipo `t` e pertencer ao `contexto(Σ)` toda vez que utilizar o contexto para perguntar o tipo de `K` vai responder `t`

- Regra da abstracao, para quando ver um expressao com `\x -> \y -> x * y` eu quero dar um tipo para essa expressao, pois todas expressoes precisam ter um tipo .
Dado um contexto `abs = Σ |- (\x:t.e) : t -> t'` desde que a seguinte codicao seja verdade `Σ, x:t |- e:t`

- Regra de aplicacao, que a forma que se entrega dados para as expressoes. `app = Σ |- (e1,e2):t'` se `Σ |- e1:t->t'  Σ |- e2:t`

## Criando um tipo

- Para criar um tipo em haskell `data <tipo> = <expres>` Exemplo:

```haskell
Prelude> data T = T1 | T2
Prelude> :t T1
T1 :: T
Prelude> :t T2
T2 :: T
```

- No exemplo acima temos `data T = T1 | T2` sendo T1 e T2 valores, o T é o tipo sendo assim `T1 e T2 tem o tipo T (T1::t), (T2::T)`

- Podemos tambem criar tipos mais complexos, como por exemplo criar um tipo `U` onde ele é composto por elementos do tipo `T`

```haskell
Prelude> data U = U1 T T
Prelude> :t U1 T1 T2
U1 T1 T2 :: U
Prelude> :t U1 T1 T1
U1 T1 T2 :: U
```
