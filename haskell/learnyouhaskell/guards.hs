{-
    GUARDAS

    Enquanto Patterns e um caminho para estar tendo certeza que o valor combina de alguma forma e desconstruindo isso.
    Guardas são uma forma de testar se alguma propriedade de um valor(Ou varios valores) se sao verdadeiros os falsos.
    Isso parece com condicao de if e é bastante similar a isso, a coisa é que guardas são bem mais legiveis quando se tem varias condicoes e 'Conversam' bem com os Patterns

-}

-- Fazendo uma funcao de IMC com Guardas
{-
    bmiTell :: (RealFloat a) => a -> String
    bmiTell bmi
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"

    Guardas sao indicados por pipes ` | ` que seguem o nome de uma função e seus parâmetros.
    Normalmente sao identados um pouco para direita e alinhados.
    Um Guarda é basicamente um expressão boolean. Se for `True`. Entao a funcao correspondente é usada
    Se for `False` e vai para a proxima condicao e assim por diante

    Isso é bastante parecido que o Condicoes If Else em linguagens imperativas. So que melhor para ser lido

    A ultima condicao dos Guardas é `otherwise`. `otherwise` pode ser definido `otherwise = True` e pega tudo.
    Sendo bastante similar as Patterns, Sendo em patterns verificando se o input se encaixa ao padrao, em Guardas e checando um condicao booleana.
    Se todos os guardas forem `False` ele sempre cai no `otherwise`, se n colocamos o `otherwise`. a avaliação cai no próximo Pattern. É assim que os Pattern e os Guards funcionam bem juntos. Se nenhum Guard ou Pattern adequado for encontrado, um erro será gerado.

-}

-- É claro nos podemos usar Guards com funcoes que recebem quantos parametros nos queremos
{-
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise                 = "You're a whale, congratulations!"
    -- Observer que n tem um `=` Logo depois do nome e parametros da funcao, e antes do primeiros Guard
-}

-- Vamos criar nossa versao de `max` que recebe dois parametros e retorna qual numero foi o maior
max' :: (Ord a) => a -> a -> a
max' a b
  | a > b = a
  | otherwise = b -- Nos podemos escrever guardas em uma linha, porem n é recomendado pq torna menos legivel
  {-
      max' :: (Ord a) => a -> a -> a
      max' a b | a > b = a | otherwise = b
  -}

-- Criando nossa ver da funcao `compare` que compara dois elementos da typeclass Ord e retorna um Ordering sendo `GT, EQ, LT` => Greater Than, Equal, Lesser Than
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a > b = GT
  | a == b = EQ
  | otherwise = LT

-- ghci> 3 `myCompare` 2  =>
{-GT-}
-- Note: Not only can we call functions as infix with backticks, we can also define them using backticks. Sometimes it's easier to read that way.

-- Usando where para definir algum nome ou funcao dentro de outra definir com o objetivo de diminuir a repeticao de codigo
{-
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2  -- Aqui esta a definicao de bmi, ao inves de repetir weight / height ^ 2 tres vezes
-}

-- Podemos deixar ainda mais resumido definindo mas nome com where
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
  | bmi <= skinny = "You're underweight, you emo, you!"
  | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= fat = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where
    bmi = weight / height ^ 2
    skinny = 18.5
    normal = 25.0
    fat = 30.0

-- Os nome definidos aqui só estao visiveis para essa funcao
-- Importante notar que é preciso indentar de maneira compreesivel para que o 'haskell' n fique confuso quando for ler
-- Podemos tambem usar Pattern match no where, rescreevendo a parte where de cima ficaria
{-
    where bmi = weight / height ^ 2
    (skinny, normal, fat) = (18.5, 25.0, 30.0)
-}

-- Criando uma funcao bem trivial onde pega o primeiro nome e o ultimo e retorna a primeira letra do primeiro nome e a primeira letra do segundo nome
initials :: String -> String -> [Char]
initials firstName lastName = [f] ++ ". " ++ [l] ++ ". "
  where
    (f : _) = firstName
    (l : _) = lastName

-- Do mesmo jeito que definimos constantes no bloco where, podemos tambem definir funcoes.
-- Vamos fazer uma funcao que pega uma lista par de peso-altura e retorna uma lista de IMCS

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
  where
    bmi weight height = weight / height ^ 2

-- LET IN

-- Bastante similar ao 'Where', onde 'binding' sao construcoes sintaticas que deixam vc bindar variaveis ao fim da funcao, para entao toda funcao ver, incluindo todos os guardas.
-- 'Let' ligacoes deixa vc ligar às variaveis em qualquer lugar das expressoes mas bem localmente para que então eles não cruzam os guards
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
  let sideArea = 2 * pi * r * h -- Defino que cada funcao vai ser
      topArea = pi * r ^ 2 -- Defino que cada funcao vai ser
   in sideArea + 2 * topArea -- Falo como vai ser aplicado

{-
Isso poderia ser feito com where
    cylinder :: (RealFloat a) => a -> a -> a
    cylinder r h = sideArea + 2 * topArea
    where   sideArea = 2 * pi * r * h
            topArea = pi * r ^ 2
-}
-- A formula é `let <bindings> in <expression>`
{-
    Os nome definido na parte `let` sao acessaveis para expressoao depois da parte in.
    Como pode ver tambem poderiamos deinir com `where`. observe que os nomes estao alinhados em uma unica coluna.
    Mas qual é a diferenca entre os dois? por agora parace que o `let` coloca os `bindings` primeiro
    e depois em a expressao que vai usalas enquanto where faz o contrario

    A diferenca é que `let` `bindings` sao empressoes por si só. `where` `bindings` são somente construcoes sintaticas. Lembre-se que com nos fizemos a condicao if, foi explicado que as condicoes if e else é uma expressao que vc pode enfiá-lo em quaser todo lugar =>
=====================================================================================
        ghci> [if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" else "Bar"]
        ["Woo", "Bar"]
        ghci> 4 * (if 10 > 5 then 10 else 0) + 2
        42
====================================================================
    Voce tambem pode fazer com `let` =>
        ghci> 4 * (let a = 9 in a + 1) + 2
        42
    =======================================================================
    `let` Tambem pode ser introduzido a funcoes em um escopo local
    ghci> [let square x = x * x in (square 5, square 3, square 2)]
    [(25,9,4)]
    =====================================================================
    Se nos queremos `bind` varias variaveis em uma unica linha, nos obviamente nao podemos alinha em colunas.
    E por isso que nos devemos separa por ponto e virgula =>
    ghci> (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
    (6000000,"Hey there!")

    ================================================================
    Voce nao precias necessariamente colocar o ponto e virgula depois da ultima `binding` se se vc quiser
    Como foi dito antes, voce pode `Pattern match` com `let bindings`
    ghci> (let (a,b,c) = (1,2,3) in a+b+c) * 100
    600
    ============================================================

    -- Voce pode colocar `let bindings` dentro de lista em compreesao. vamso reescrever o exemplo de IMC
    calculando listas de peso-altura em pares para usar o `let` dentro da lista de compreesao ao inves de
    uma funcao auxiliar com where

    calcBmis :: (RealFloat a) => [(a, a)] -> [a]
    calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]  -- Foi incluido o `let` na lista de compreesao a onde se colocaria o predicado, some que ele nao filtra a lista somente `binda` os nomes
    Os nomes definidos em um `let` dentro de uma lista de compreesao sao visiveis para funcao de output (A parte antes do |)  e todos os predicados e seções que vêm depois da `binding`.
    Desse jeito podemos fazer que retorne somente peso de pessoas gordas

    calcBmis :: (RealFloat a) => [(a, a)] -> [a]
    calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]
    Nao podemos usar o `bmi` nome em `(w,h) <- xs` parte porque é definido antes da ligação let.

    Nos omitimos a parte `in` do `let` binding quando usamos eles em lista de compreesao porque a visibilidade dos nomes ja foram predefinidas

    Se `let` bindings sao tao boas, pq nao usamos eles o tempo todo inves de `where` bindigs?
    Bem desde que `let` bindings sao expressoes e são bastante locais em seu escopo, eles não podem ser usados ​​por guards
-}

-- CASE EXPRESSIONS
-- Case expressoes, sao, expressoes baseadas em uma valor de uma vairiavel, igual a swtich cases
{-
    Esse dois blocos de coigos fazem a mesma coisa

    head' :: [a] -> a
    head' [] = error "No head for empty lists!"
    head' (x:_) = x

    head' :: [a] -> a
    head' xs = case xs of [] -> error "No head for empty lists!"
                       (x:_) -> x

    Sintaxe do `case expressions`
    case expression of pattern -> result
                pattern -> result
                pattern -> result
                ...
-}

-- `Expression` é combinada com os padroes. O `Pattern Matching` age e da maneira que é esperado: o primeiro padrao que cobina a expressao é usada

-- Equanto `Pattern Matching` em funcoes de parametros pode ser usado somente quando definindo funcoes,
-- `case expressions` pode ser usadas em qualaquer lugar, por exemplo
describeList :: [a] -> String
describeList xs =
  "The list is " ++ case xs of
    [] -> "empty"
    [x] -> "a singleton list"
    xs -> "A longer list"

-- Sao bastante uteis para `Pattern Matching` com alguma coisa no meio de uma expressao. Por que `pattern matching` em uma definicao de funcao é acucar sintatico para `case expressions`. Poderiamos definir assim
describeList' :: [a] -> String
describeList' xs = "The list is" ++ what xs
  where
    what [] = "empty"
    what [x] = "A singleton list"
    what xs = "A longer list"
