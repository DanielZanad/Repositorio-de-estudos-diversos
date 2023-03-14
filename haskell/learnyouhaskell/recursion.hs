-- RECURSION 
{-
    A recursão é na verdade uma forma de definir funções nas quais a função é aplicada dentro de sua própria definição.

    Recursao em Haskell é extremamente importante pois diferente de linguagens impertativas, voce faz computacoes em haskell declarando oque alguma coisa 'é' inves de dizer 'como chegar la'

    Agora vamos definir uma funcao recursiva que vai retornar o maior elemento em uma lista
    Primeiro vamos colocar o caso base onde a funcao nao chama ela mesma(O caso mais simples)
-}
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Maximum of empty list" -- Defindo caso base onde é vazio
maximum' [x] = x -- Definindo o caso base onde é somente um elemento na lista
maximum' (x:xs) -- Caso normal aonde tem uma lista grande, pegando a head e separando do tail
    | x > maxTail = x -- Vendo se o head e maior que o tail
    | otherwise = maxTail -- Se o maximo da tail é maior, então é o maximo da tail
    where maxTail = maximum' xs
-- Outra forma de escrever a mesma funcao so utilizando a funcao max que pega dois numero e retorna o maio entre eles


maximum2' :: (Ord a) => [a] -> a
maximum2' [] = error "maximum of empty list"
maximum2' [x] = x
maximum2' (x:xs) = max x (maximum' xs)

-- Agora vamos Implementar outra funcao rercursiva, o `replicate`. `replicate` pega um `Int` e outro elemento e retorna uma lista que tem varias repeticoes desse elemento de acordo com `Int`.
-- Por exemplo ` replicate 5 3 ` => `[5,5,5]`.
-- O caso base para isso seria uma condicao 0 ou menor,

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x : replicate' (n-1) x


-- Agora vamos implmentar o `take`. que pega uma certa quantidade de numberos de uma lista.
-- Por exemplo `take 3 [5,4,3,2,1]` vai retorna `[5,4,3]`. Se nos tentarmo pegar 0 da lista, nos teremos uma lista vazia
-- tambem se nos tentarmos pegar alguma coisa de uma lista vazia tambem teremos uma lista vazia
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0 = []
take' _ []   = []
take' n (x:xs) = x : take' (n-1) xs

-- Agora vamos fazer a funcao `reverse` que simplemente reverte uma lista
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]


-- Funcao zip que pega duas lista e 'zipa' elas juntas `zip [1,2,3] [2,3]` retorna `[(1,2), (2,3)]`, por causa ele trunca a maior lista combinando com o tamanho da menor

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

-- Fazendo a funcao `elem` que retorna True caso o elemento esteja presente na lista e False caso n
elem' :: (Eq a) => a -> [a] -> Bool 
elem' a [] = False
elem' a (x:xs)
    | a == x = True 
    | otherwise  = a `elem'` xs


-- Implementando quicksort

{-
    So, the type signature is going to be quicksort :: (Ord a) => [a] -> [a]. 
    No surprises there. The edge condition? Empty list, as is expected. 
    A sorted empty list is an empty list. Now here comes the main algorithm: a sorted list is a list that has all the values smaller than (or equal to) the head of the list in front (and those values are sorted), then comes the head of the list in the middle and then come all the values that are bigger than the head (they're also sorted). 
    Notice that we said sorted two times in this definition, so we'll probably have to make the recursive call twice! 
    Also notice that we defined it using the verb is to define the algorithm instead of saying do this, do that, then do that .... That's the beauty of functional programming! 
    How are we going to filter the list so that we get only the elements smaller than the head of our list and only elements that are bigger? List comprehensions. 
    So, let's dive in and define this function.
-}

quicksort :: (Ord a) => [a] -> [a]  
quicksort [] = []  
quicksort (x:xs) =   
    let smallerSorted = quicksort [a | a <- xs, a <= x]  
        biggerSorted = quicksort [a | a <- xs, a > x]  
    in  smallerSorted ++ [x] ++ biggerSorted  




