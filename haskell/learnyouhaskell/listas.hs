import Data.Binary (Binary(putList))
{-      Listas
    -> uma lista precisa ser do mesmo tipo
-}
lostNumbers = [4,8,15,16,23,42] -- Criando uma lista simples,
  

matriz = [[23,4,3,2], [4,5,43,5]]-- Criando uma lista que contem outras duas listas
-- Nao pode criar uma lista com diferente tipos => [[3,4,3,2], ["teste", "teste1"]]

b = [[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]] -- Criando uma lista que contem varias outras listas


-- Para gerar listas com elementos pre definidos
c = [1..10]


-- Compreesao em haskell
{-
    If you've ever taken a course in mathematics, you've probably run into set comprehensions. They're normally used for building more specific sets out of general sets. A basic comprehension for a set that contains the first ten even natural numbers is set notation. The part before the pipe is called the output function, x is the variable, N is the input set and x <= 10 is the predicate. That means that the set contains the doubles of all natural numbers that satisfy the predicate.

    If we wanted to write that in Haskell, we could do something like take 10 [2,4..]. But what if we didn't want doubles of the first 10 natural numbers but some kind of more complex function applied on them? We could use a list comprehension for that. List comprehensions are very similar to set comprehensions. We'll stick to getting the first 10 even numbers for now. The list comprehension we could use is [x*2 | x <- [1..10]]. x is drawn from [1..10] and for every element in [1..10] (which we have bound to x), we get that element, only doubled. Here's that comprehension in action.

-}

-- Exemplo de criacao de uma compreesao
x = [x * 2 | x <- [1..10]] -- Isso faz x "Receber" cada valor dentro da lista que é passado depois de <-
{-[2,4,6,8,10,12,14,16,18,20] -}


-- Agora vamos adicionar um condicao (ou predicado) para compreesao -> o predicado vai por ultimo separado po uma virgula
y = [x*2 | x <- [1..10], x * 2 >= 12]-- Isso faz x "Receber" cada valor dentro da lista que é passado depois de <-, pore ele passa pela condicao primeiro sendo true e adicionado a lista se for false o elemento e "Jogado" fora da nova lista
{-[12,14,16,18,20]-}

-- COMPREESAO USANDO IF THEN E ELSE
-- Agora uma compreesao que vai trocar cada numero impar por maior que 10 com "BANG!" e a cada numero impar menor que 10 com "BOOM!" se o numero n for impar e "jogado" para fora da lista 

boomBangs :: Integral a => [a] -> [[Char]]
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
-- Executando boomBangs [7..13]  
{-["BOOM!","BOOM!","BANG!","BANG!"]-}


-- Escrevendo uma versao da funcao Length como Length2
length xs = sum [1 | _ <- xs] -- O _ siginifica que n precisamos se importar com o que a lista vai ser representada dentro da compreesao, entao ao inves de escrever um nome de variavel que nunca iremos usar podemos escrever _ no lugar, essa funcao subistitui cada elemento da lista com 1 e entao soma 
-- length [1..10]
{-10-}

-- Lembrando que strings sao considerados lista, ou seja podemos usa-las na compreesao 
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']] -- Uma funcao que pega a string e remove todos os caracteres maiusculos
-- removeNonUppercase "Hahaha! Ahahaha!" 
{-"HA"-}


