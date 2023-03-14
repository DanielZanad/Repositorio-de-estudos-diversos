module Teste where
maiorQue :: Int -> Int -> Bool
maiorQue x y =  x > y

u :: Int 
u = 7
 
 -- Listas
dobroLista :: [Int] -> [Int]
dobroLista xs = [2 * x | x<-xs]

lista :: [Int]
lista = [2*x+1 | x <- [0 .. 10], x /= 5]

-- Tuplas

foo :: Char -> Int -> (Int, String)
foo x y = (y+9, x:[x])
