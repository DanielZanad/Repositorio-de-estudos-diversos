-- Quantos segundos existem em 42 minutos e 42 segundos
ex01 :: Double 
ex01 = 42 * 60 + 42

-- Sabendo que uma milha equivale a 1.61 km, quantas milhas temos em 10km
ex02 :: Double 
ex02 = 10 / 1.61

-- Se voce correr um corrida de 10km em 42 minutos e 42 segundos, quantos segundo voce levou para correr cada milha
ex03 :: Double
ex03 =  ex01 / ex02

-- Na situacao do exercicio anterior, qual a sua velocidade media em milhas por hora
ex04 :: Double
ex04 = 1 / ex03 * 3600

-- Suponha que o preco de venda de livro é 24.95, mas livrarias tem 40% de desconto. O frete custa 3.00 para a primeira copia e 75 centavos para cada copia adicional. Qual é o custo total, para uma livraria, para comprar 60 copias


ex05 :: Double
ex05 = 60 * 24.95 * 0.6 + 3 + 0.75 * 59