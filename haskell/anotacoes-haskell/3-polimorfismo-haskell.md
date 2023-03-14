# Polimorfismo

- 1) forma de Polimorfismo é a ideia que a mesma informação pode ter mais de 1 tipo ex:

```haskell
1 :: Int -- 1 Tem o Tipo Int
1 :: Integer -- 1 Tem o Tipo Integer
1 :: Double -- 1 Tem o Tipo Double
```

- 2) Usar o mesmo simbolos para serem interpretados com diferentes tipos.(Sobrecarga)

```haskell
+ :: Int -> Int -> Int
+ :: Double -> Double -> Double
```

-3) Um tipo pode se usado no lugar do outro(subTipo) como por exemplo:

```text
x: pai <- y:filho (O pai é a superclasse ou seja ela pode ser usada no lugar do filho)

se temos uma funcao que `f:pai->int` isso `fx` pode ser substituido por `fy`.

Resumindo um tipo pode tomar o lugar do outro, mas o outro nao pode assumir o lugar nesse exemplo o `pai` pode assumir o lugar do `filho` mas n o `filho` pode assumir o lugar do `pai`
```

## Polimorfismo parametrico

- Regra da abstracao no nivel dos tipos `Σ |- (\α.e): ∀α.t` para ser verdade `Σ, α |- e:t`

- Regra de aplicacao `Σ |- (e t): t'[t/α]` para ser verdade `Σ |- e: ∀α.t`
