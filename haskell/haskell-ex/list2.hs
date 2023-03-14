-- Funcao multiplicar, que recebe dois valores inteiros e retorna o produto do primeiro pelo segundo
multiplicar :: Int -> Int -> Int
--multiplicar = \x -> \y -> y * x
multiplicar x y = x * y

-- Funcao cumprimentar, que recebe um nome e retornar "A Linguagem preferida de nome é Haskell" (Considere o operador de concatenacao ++)
cumprimentar :: [Char]  -> [Char]
cumprimentar nome = "Linguagem preferida de nome é " ++ nome

-- Funcao velocidade, que recebe uma distancia em km e a quantidade de horas que ela levou para ser percorrida, ambos do tipo Double, e retorna a String  "Isso equivale a {x} km por hora"
velocidade :: Double -> Double -> String
velocidade km h = "Isso equivale a " ++ show(km/h) ++ "km por hora"

-- Funcao mult7 n que retorne True caso a entrada seja multiplo de 7 e false caso contrario
mult7 :: Int -> Bool
mult7 n = mod n 7 == 0

-- Funcao SomaEhMult7, que recebe um dois valores inteiros e retorna se a soma e multipla de 7
somaEhMult7 :: Int -> Int -> Bool  
somaEhMult7 x y = mult7 (x + y)

-- Faca uma funcao estaNoIntervalo a b c que recebe tres inteiros e decida se a esta contido no intervalo fechado entre o b e c. Assuma que b < c sempre
estaNoIntervalo :: Int -> Int -> Int -> Bool 
estaNoIntervalo a b c = a >= b && a <= c



-- Faca uma funcao todosNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se todos os numeros da primeira lista estao no intervalo descrito pelo segundo e terceiro argumento.
todosNoIntervalo :: [Int] -> Int -> Int -> Bool 
todosNoIntervalo []     y z = True
todosNoIntervalo (x:xs) y z =  estaNoIntervalo x y z && todosNoIntervalo xs y z


-- Similarmente, faca uma funcao algumNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se pelo menos um dos numeros da primeira lista esta no intervalo pelo segundo e terceiro argumento
algumNoIntervalo :: [Int] -> Int -> Int -> Bool
algumNoIntervalo [] y z = False
algumNoIntervalo (x:xs) y z = estaNoIntervalo x y z || algumNoIntervalo xs y z  


-- Faca uma funcao ehPerfeito n que determine se um numero é perfeito
divisores :: Int -> [Int]
divisores n = [d | d <- [1..n - 1], n `rem` d == 0]


ehPerfeito :: Int -> Bool 
ehPerfeito n =
  | mod n