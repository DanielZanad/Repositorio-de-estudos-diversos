

-- Primeiro programa em haskell
-- Criando uma funcao "polinomio" com a expressao lambda a λx. (x**2 + 10x + 2):
polinomio :: Int -> Int  -- Funcao chamada polinomio que recebe um int e retorna um int
polinomio x = x * x + 10 * x  + 2

-- Cacula o quadrado de um inteiro
--  Em expressao lambda λx.x*x
quadrado :: Int -> Int
resultado = quadrado 2
quadrado n = n * n


-- soma de dois numeros float
-- Em Expressao λx.(x + λy.(y)) 2 4 => λxy.x+y
soma :: Float -> Float -> Float -- => vai receber um valor float, depois
-- outro float e o resultado ou seja, o ultimo tipo vai ser o retorno
soma a b = a + b


-- Triplica o valor que for passado como parametro
-- Em expressao λx.x*3
triplica :: Int -> Int
triplica var = var * 3

-- Exercicios
--1) Escreva uma funcao para o calculo da area de um circulo de raio r (A = pi * r * r)
raio :: Float  -> Float 
raio r = 3.14 * r * r 



