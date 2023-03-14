import Data.Char

-- Escreva uma funcao que informa se um dado numero é par com guardas
par :: Int -> Bool
par a
    | even a = True
    | otherwise = False


-- Escreva uma funcao que informa se um dado numero é par com if e else
par2 :: Int -> Bool
--par2 a = if mod a 2 == 0 then True else False
par2 = even

-- Escreva uma funcao em Haskell que recebe um caractere como parametro e verifica se ele é
-- maiusculo ou minusculo
charcase :: Char -> String
charcase ch
    | isAsciiLower ch = "Minusculo"
    | isAsciiUpper ch = "Maiusculo"
    | otherwise = "Desconhecido"
-- | ch >= 'a' && ch <= 'z' = "Minusculo"
--    | ch >= 'A' && ch <= 'Z' = "Mausculo"
--    | otherwise = "Desconhecido"

{-
    3) Escreava uma funcao que receba 3 parametros: a, b e c.
        - Se a igual a 0 deve ser calculado a expressao: b ** 2 + 3 * c
        - Se a igual a 1, deve ser calculado a expressao: b *c**2 - 3 *c
        - se a igual a 2, deve ser calculado a expresao: 3 * c - b ** 2
        - Para outros valores de a, deve retornar zero
-} 
calc :: Int -> Int -> Int -> Int 

calc a b c  | a == 0 = b ^ 2 + 3 * c
            | a == 1 =  2 * c ^ 2 - 3 * c
            | a == 2 = 3 * c - b ^ 2
            | otherwise = 0 
        
    
