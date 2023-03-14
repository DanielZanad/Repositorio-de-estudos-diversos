-- Calcula recursivamente a potencia de 2
-- nao é recursão em cauda (precisa multiplicar)
-- chamada recursiva por 2 (2 * potencia2 (n-1))

potencia2 :: Int -> Int 
potencia2 n
    | n == 0 = 1
    | otherwise = 2 * potencia2 (n-1)


-- tambem calcula recursivamente a potencia de 2
-- A recursao é em cauda, pois a chamada recursiva
-- é pura, ou seja, nao precisa de calculo adicional
potencia2Cauda :: Int -> Int -> Int 
potencia2Cauda n acumulado
    | n == 0  = acumulado
    | otherwise = potencia2Cauda (n-1) (2*acumulado)

-- Fatorial em cauda
{-
fatorial :: Int -> Int 
fatorial n 
    | n == 0 = 1
    | n > 0  = n * fatorial (n-1)
-}

fatorial :: Int -> Int -> Int
fatorial n resultado
    | n == 0 = resultado
    | otherwise = fatorial(n-1) (n * resultado) 