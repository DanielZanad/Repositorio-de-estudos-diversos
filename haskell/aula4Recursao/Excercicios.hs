{-
1) Escreava uma funcao recursiva que recebe como parametros dois numeros
inteiros positivos, x e n, e retorne o resultado de x*n, realizando
soma sucessivas

5*4 = 5 + 5 + 5 + 5 = 4 + 4 + 4 + 4 + 4 

-} 

func :: Int -> Int -> Int 
func a b
    | b == 0 = 0
    | otherwise = a + func a (b-1)

-- ==

multRec :: Int -> Int -> Int 
multRec x n
    | x == 1 = n
    | x > 1 = n + multRec(x-1) n

{-

2) Escreva uma funcao recursiva para o calculo do mdc
de dois numeros inteiros 

-}
mdc :: Int -> Int -> Int
mdc = lcm

