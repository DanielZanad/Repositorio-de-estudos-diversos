areaheron :: Float -> Float -> Float -> Float
-- Criando a funcao que vai calcular a areaheron
-- Repare que o s ainda nao esta definido
areaheron a b c  = sqrt (s * (s-a) * (s-b) * (s-c))
    -- Agora vai ser definido o s com o where 
    where
        s = (a+b+c) / 2
        -- Aqui poderia definir ainda mai termos (quantos for necessario)


-- Alguns outros exemplos com where

funcao :: Int -> Int -> Int 
funcao x y | x <= 10 = x + a
           | otherwise = x - a
    where
        a = (y + 1) ^ 2 

outraFunc :: Int -> Int 
outraFunc y = 3 + func y + func a + func b
    where
        func x = x + 7 * c  -- Define outra funcao local
        a = 3 * c           -- Define vaor com expressoes
        b = func 2          -- Define valor com chamada a funcao
        c = 10              -- Define valor fixo
