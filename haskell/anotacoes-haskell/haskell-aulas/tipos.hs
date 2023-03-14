{-# LANGUAGE FlexibleInstances #-}

-- Tipos Soma ou enumeracao taguida
data T = T1 | T2 deriving (Show)
data Fruta = Banana | Maca

-- Tipos produto ou registro ou trupla ou (n)tuplas
data U = U1 T T deriving (Show)
data Vitamina = Vitamina Fruta Fruta Fruta

-- Tipos Parametricos
data M a = Nothing' | Just' a
  deriving (Show)
data E a b = Left' a | Right' b 
  deriving (Show)
data Tuple a b = MkTuple a b 
  deriving (Show)-- MkTuple -> construtor e `a` e `b` são variaveis

-- Phantom type
data N a = N Int Char 


-- Declarar uma classe (constraint)
class Equal a where 
  equal :: a -> a -> Bool 

-- Implementar a classe para o Tipo T
instance Equal T where
  equal T1 T1 = True 
  equal T2 T2 = True 
  equal _ _ = False 


f2 :: (Equal a) => a -> a -> Bool 
f2 t1 t2 = equal t1 t2

f1 :: Num p => T -> p
f1 T1 = 1
f1 T2 = 0


first :: Tuple a b -> a 
first (MkTuple x _) = x 

second :: Tuple a b -> b
second (MkTuple _ y ) = y



-- Tipos recursivos
data List a = Nil | Cons a (List a)
-- data [a] = [] | a:[a]    (:) = Cons
  deriving (Show)

data BinaryTree a = Leaf 
                  | Node a (BinaryTree a) (BinaryTree a)
                  deriving (Show)



-- Instancia Num para funcoes
instance Num (Int -> Int)  where
  --  (+) :: (Int -> Int) -> (Int -> Int) (Int -> Int)
  f1 + f2 = \x -> (f1 x) + (f2 x)
  f1 - f2 = \x -> (f1 x) - (f2 x)
  f1 * f2 = \x -> (f1 x) * (f2 x)
  negate f = \x -> negate $ f x
  abs f = \x -> abs $ f x
  signum f = \x -> signum $ f x
  fromInteger i = \x -> fromInteger i 
  

f3 :: Int -> Int 
f3 x = x * x

g :: Int -> Int 
g x = 10*x+5

p :: Int -> Int -> Int 
p = \x -> \y -> x * y 


{-
Faça um programa que em apertar o botão, liga um pisca pisca com dois leds, sendo um vermelho e o outro azul, com intervalo de tempo de 500m







-}











