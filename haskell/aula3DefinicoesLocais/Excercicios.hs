{-
    1) Escreva uma funcao em Haskell que retorna a quantidade de raizes reais distintas de uma
    de uma equacao do segundo grau(assumindo que o coeficiente do termo de grau dois nunca seja igual a zero). 
    A equcao é:
        ax^2 + bx + c = 0
    E o discriminante, geralmente conhecido como "delta", é dado por:
        delta = b^2 - 4*a*c       
-}
equacao2 :: Float -> Float -> Float -> Int 
equacao2 a b c | delta > 0 = 2
               | delta == 0 = 1
               | otherwise = 0
    where
        delta = b^2 - 4*a*c

{-
areaheron :: Float -> Float -> Float -> Float
areaheron a b c  = sqrt (s * (s-a) * (s-b) * (s-c))
    where
        s = (a+b+c) / 2
-}

areaheron :: Float -> Float -> Float -> Float
areaheron a b c = 
    let s = (a+b+c) / 2
    in sqrt (s * (s-a) * (s-b) * (s-c))


    {-=let a = (y + 1) ^ 2
    in  | x <= 10 x + a
        | otherwise = x - a
-}



{-
outraFunc :: Int -> Int 
outraFunc y = 3 + func y + func a + func b
    where
        func x = x + 7 * c  -- Define outra funcao local
        a = 3 * c           -- Define vaor com expressoes
        b = func 2          -- Define valor com chamada a funcao
        c = 10              -- Define valor fixo
-}

outraFunc :: Int -> Int 
outraFunc y = 
    let func x = x + 7 * c;
        a = 3 * c;
        b = func 2;
        c = 10;
    in 3 + func y + func a + func b