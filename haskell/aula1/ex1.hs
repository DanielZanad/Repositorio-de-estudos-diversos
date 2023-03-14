-- Exercicios
--1) Escreva uma funcao para o calculo da area de um circulo de raio r (A = pi * r * r)
area :: Float -> Float 
area r = pi * r * r 

--2) Escreva uma funcao para o calculo do perimetro de um circulo de raio r (p = 2 * pi * r)
perimetro :: Float -> Float 
perimetro r = 2 * pi * r

--3) Escreva uma funcao para calcular a hipotenusa h de um triangulo retangulo a partir dos catetos a e b
hipotenusa :: Float -> Float -> Float 
hipotenusa a b = sqrt (a * a + b * b) -- => o () aqui é para precedência

--4) Escreva uma funcao para calcular a diferenca da area de dois circulos de raios r1 e r2
diferenca :: Float -> Float -> Float 
diferenca r1 r2 = abs (area r1 - area r2)
