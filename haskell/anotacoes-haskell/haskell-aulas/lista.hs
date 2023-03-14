--data List a = Nil | Cons a (List a)
--data [a] = [] | a:[a]

-- Triads
triads :: Int -> [(Int, Int, Int)]
triads n = [(x, y, z) | x <- [1 .. n], y <- [1 .. n], z <- [1 .. n], (x ^ 2 + y ^ 2) == z ^ 2]

triads' :: [(Int, Int, Int)]
triads' = [(x, y, z) | x <- [1 ..], y <- [1 ..], z <- [1 ..], (x ^ 2 + y ^ 2) == z ^ 2]

map' :: (t -> a) -> [t] -> [a]
map' f xs = [f x | x <- xs]

filter' :: (a -> Bool) -> [a] -> [a]
filter' p xs = [x | x <- xs, p x]

reduce' :: (a -> a -> a) -> [a] -> a
reduce' f [x] = x
reduce' f (x : xs) = f x (reduce' f xs)

is_prime :: Int -> Bool
is_prime 1 = False
is_prime 2 = True
is_prime n
  | (length [x | x <- [2 .. n -1], mod n x == 0]) > 0 = False
  | otherwise = True

concat' :: [[a]] -> [a]
concat' xss = [x | xs <- xss, x <- xs]

null' :: [a] -> Bool
null' [] = True
null' _ = False

--data Maybe a = Just a | Nothing
head' :: [a] -> Maybe a
head' (x : _) = Just x
head' [] = Nothing

tail' :: [a] -> [a]
tail' (_ : xs) = xs

last' :: [a] -> a
last' [x] = x
last' (x : xs) = last' xs
last' _ = undefined
