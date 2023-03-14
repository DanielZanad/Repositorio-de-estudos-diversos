{-
    Pattern Matching consiste em especificar padrões aos quais alguns dados devem estar em conformidade e, em seguida, verificar se isso ocorre e desconstruir os dados de acordo com esses padrões.

-}

-- Quando estamos definindo funcoes, podemos definir as funcoes separados do corpo com diferente padroes.
-- Isso nos leva para um codigo arrumado e simples de se ler.
-- Você pode combinar padrões em qualquer tipo de dados
lucky ::(Integral a) => a -> String 

lucky 7 = "Lucky Number Seven!!"
lucky x = "Sorry, you're out of luck, pal!"
{-
    Quando vc chama `lucky`. os padroes sao checados do topo para baixo e quando corresponde a um padrao. a funcao correspondente vai ser usada
    Isso poderia ser escrito com um if:
        lucky x = if x == 7 then "Lucky Number Seven!!" else "Sorry, you're out of luck, pal!"


    Mas e se queremos que a funcao que fale os numeros de 1 a 5 e fale "Not between 1 and 5" para qualquer outro numero
-}
sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5"  


{-
    Lembra da funcao fatorial que foi escrita antes(talves no arquivo de tipos) foi definada desse jeito
    factorial :: Integer -> Integer
    factorial n = product [1..n]

    Podemos definir de forma recursiva, da maneira que matematicamente foi definida.
    Comecamos dizendo que o fatorial de 1 é 0, em seguida, afirmamos que o fatorial de qualquer número inteiro positivo é aquele número inteiro multiplicado pelo fatorial de seu predecessor. Veja como isso parece traduzido em termos de Haskell.
-}

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1){- Esse é primeira vez que é definida uma funcao recursiva, oque 
esta acontencendo aqui é se tetarmos o fatorial de 3, ele vai tentar computar `3 factorial 2`. E
depois fatorial de 2 é `2 * factorial 1`, ate agora nos temos `3 * (2* factorial 1)`. factorial 1 é `
1 * factorial 0`, entao temos `3 * (2 * (1 factorial 0))`. Agora que vem o truque, nos definimos o fatorial de 0 para ser 1 e por isso encontra o padrao antes de cair na definicao mais generica, e retorna somente .
Assim ficando `3 * (2 * (1 * 1))`
-}

-- O Pattern Matching pode tambem falhar. Se nos defininmos uma funcao asssim
--charName :: Char -> String  
--charName 'a' = "Albert"  
--charName 'b' = "Broseph"  
--charName 'c' = "Cecil" -- Aqui da para inserir algo diferente do que esta no padrao assim dando um erro no compilador

{-
    Pattern matching pode ser usado tambem em tuplas, se nos queremos fazer uma funcao que pega dois vetores em um espaco 2D(Que estao na forma de pares) e adicionalos em dois vetores,
    nos adicionamos o componente x deles seperados e entao o componentes y deles tambem separados.
-}
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
-- addVectors a b = (fst a + fst b, snd a + snd b) -- isso funciona com tuplas mas n com triplas, para isso teremos que criar a funcao para retornar um valor da tripla
 
first :: (a, b, c) -> a  
first (x, _, _) = x 

second :: (a, b, c) -> b  
second (_, y, _) = y  
  
third :: (a, b, c) -> c  
third (_, _, z) = z 
-- O `_` Siginifica a mesma coisa que em compreesao, ou seja n nos importartamos com o que aquela parte vai ser pois n vai ser usado

-- O que lembra que podemos usar pattern match em lista de compreesao
xs :: [(Integer, Integer)]
xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]  
--[a+b | (a,b) <- xs]  
{-[4,7,6,8,11,4]-}
-- Se o pattern match falhar ele vai pro proximo 


{-
    Lista sozinhas podem tambem ser usadas no pattern matching. Voce pode combinar com uma lista vazia `[]` or qualquer padrao que envolve `:` e uma lista vazia.
    Mas desde [1,2,3] é so um 'Acucar sintatico' para 1:2:3:[], voce pode tambem usar o padrao formal.
    Um padrao como `x:xs` irá vincular o topo da lista a x e o resto a xs, mesmo se houver apenas um elemento, então xs acaba sendo uma lista vazia.

    Nota: O padrão `x: xs` é muito usado, especialmente com funções recursivas. Mas os padrões que têm `:` neles só correspondem a listas de comprimento 1 ou mais.
-}

-- Se vc quiser vincular os 3 primeiros elementos para variaveis e o resto da lista para outra variavel,
-- voce pode usar algo como ` x:y:z:zs`. Isso vai somente vincular com listas que tem tres elementos ou mais

-- Agora que ja conhecemos o pattern match com listas, vamos fazer nossa propria implmentacao da funcao `head`
head' :: [a] -> a  
head' [] = error "Can't call head on an empty list, dummy!"  
head' (x:_) = x -- Pega o primeiro elemento e retorna, o resto da lista e ignorado
{-
    ghci> head' [4,5,6]  
    4  
    ghci> head' "Hello"  
    'H'

    Agradável! Observe que se você deseja vincular a várias variáveis ​​(mesmo se uma delas for apenas _ e não vincular de fato), nos temos que colocar em volta parenteses.
    Tambem note que a funcao `error` que nos usamos. Pega uma stringse gera um erro de `runtime`

-}


-- Vamos fazer uma funcao 'trivial' que nos fala o primeiro elemnto de uma list
tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y 
{-
    This function is safe because it takes care of the empty list, a singleton list, a list with two elements and a list with more than two elements. Note that (x:[]) and (x:y:[]) could be rewriten as [x] and [x,y] (because its syntatic sugar, we don't need the parentheses). We can't rewrite (x:y:_) with square brackets because it matches any list of length 2 or more.
-}


-- Nos ja escrevemos a funcao length usando compreesao, agora vamos usar recursao
length' :: (Num b) => [a] -> b
length' [] = 0 -- Se for uma lista vazia retona 0
length' (_:xs) = 1 + length' xs -- Ignora o primeiro elemento da lista e pega o resto e passa para proxima chamada de length' 
-- Quando chegar em uma lista vazia vai cair no pattern de `length' [] = 0` 
{-
    EXPLICACAO MAIS ELABORADA EM INGLES
    Let's see what happens if we call length' on "ham". First, it will check if it's an empty list.
         Because it isn't, it falls through to the second pattern. 
         It matches on the second pattern and there it says that the length is 1 + length' "am", because we broke it into a head and a tail and discarded the head. O-kay. 
         The length' of "am" is, similarly, 1 + length' "m". So right now we have 1 + (1 + length' "m"). length' "m" is 1 + length' "" (could also be written as 1 + length' []). And we've defined length' [] to be 0. 
         So in the end we have 1 + (1 + (1 + 0)).
-}

-- Vamos implementar a funcao `Sum` nos sabemos que sum de uma lista vazia é 0. 
-- Nos escrevos isso no pattern. E tambem sabemos que a soma de uma lista é a soma da `Head` mais a soma do resto da lista
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs -- Isso é parecido com a explicação da funcao recursiva de length porem aqui nos usamos o primeiro elemento na chamada da funcao no caso recursivo


{-
    Também existe uma coisa chamada de padrões. Essas são uma forma prática de quebrar algo de acordo com um padrão e vinculá-lo a nomes, mantendo uma referência para a coisa toda.
    Voce faz isso colocando o nome e `@` na frente do patter. por exemplo. O pattern `xs@(x:y:ys)`. 
    Esse pattern vai combinar exatamente com a mesma coisa de  `x:y:ys` mas vc pode facilmente pega a lista inteira atraves de `xs` em vez de repetir `x:y:ys` no corpo da funcao novamente. 
    Aqui um exemplo
-}

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]  
--ghci> capital "Dracula"  =>
{-"The first letter of Dracula is D"-}

  



{-
    



    3 Chamada referente a biggerSorted da chamada 2
    x = 9
    retorn [9]

    2 Chamada referente a smallerSorted da 1 chamada
    x = 5
    quicksort [1,2,2,3] ++ [5] ++ [9]
    smallerSorted = [1,2,2,3]
    2 retorna [1,1,2,3,5,9]

    


    1 chamada
    quicksort [5,3,9,1,2,2]







--}










