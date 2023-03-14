fib :: Int -> Int 
fib x 
    | x == 0 = 1
    | x == 1 = 1
    | otherwise = fib(x-1) + fib(x-2)

fiboCauda :: Int -> Int -> Int -> Int 
fiboCauda n a1 a2
    | n == 0 = a1
    | n == 1 = a2
    | otherwise = fiboCauda (n-1) a2 (a1+a2)