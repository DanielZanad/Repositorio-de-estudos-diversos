{-
    Para verificar o tipo da expressao da para usar :t
    exemplos: 
        
        'a' :: Char  
        ghci> :t True  
        True :: Bool  
        ghci> :t "HELLO!"  
        ghci> :t (True, 'a')  
        (True, 'a') :: (Bool, Char)  
        ghci> :t 4 == 5  
        4 == 5 :: Bool  
-}

-- :t em uma expressao printa a expressao seguida por :: e o seu tipo
-- :: é lido como "Tipo de"

-- Funcao tambem possuem tipos
removeNonUppercase :: [Char] -> [Char] -- => Tipo da funcao 
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   
{-
    removeNonUppercase has a type of [Char] -> [Char], meaning that it maps from a string to a string. 
    That's because it takes one string as a parameter and returns another as a result. 
    The [Char] type is synonymous with String so it's clearer if we write removeNonUppercase :: String -> String. 
    We didn't have to give this function a type declaration because
-}
-- No caso acima ele recebe uma lista de caracteres [char] e nos retorna [char], mas e se queremos receber mais de um argumento

-- Declaracao de funcao que recebe mais de um argumento
addThree :: Int -> Int -> Int -> Int  
addThree x y z = x + y + z  


-- Os parametros sao separados com o `->` e na a nenhuma distincao entre o parametros e o tipo de retorno
-- O tipo de retorno sempre vai se o ultimo tipo declarado
-- Para checar o tipos de uma funcao podemos usar o `:t` pois funcao sao expressoes tambem


--          TIPOS
{-
    INT stands for integer. 
    It's used for whole numbers. 
    7 can be an Int but 7.2 cannot. 
    Int is bounded, which means that it has a minimum and a maximum value. 
    Usually on 32-bit machines the maximum possible Int is 2147483647 and the minimum is -2147483648.

    INTEGER stands for, er … also integer. 
    The main difference is that it's not bounded so it can be used to represent really really big numbers. 
    I mean like really big. Int, however, is more efficient.
-}
factorial :: Integer -> Integer 
factorial n = product [1..n]
-- factorial 50 =>
{-30414093201713378043612608166064768844377641568960512000000000000-}

{-
    FLOAT is a real floating point with single precision.


    DOUBLE is a real floating point with double the precision!

    BOOL is a boolean type. It can have only two values: True and False.

    CHAR represents a character. It's denoted by single quotes. A list of characters is a string.

    TUPLES are types but they are dependent on their length as well as the types of their components, so there is theoretically an infinite number of tuple types, 

-}

  