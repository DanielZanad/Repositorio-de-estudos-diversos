{-
    Funcoes em Haskell podem receber funcoes como parametros e retorna funcoes.
    A funcao que faz qualquer uma dessas coisas é chamada de `higher order function`. 
    `Higher order functions` nao sao somente parte da experiencia do Haskell, mas bastante de dessa experiencia.
    Acontece que se vc quer definir calculos computacionais por definindo oque algo `é` inves de definir etapas que mudam o estado e talvez loops entao, `higher order functions` sao idispensaveis.
    É uma maneira muito poderosa de resolver problemas pensando sobre programas
    
-}

-- Curried functions
{-
    Uma funcao oficialmente so recebe um parametro, entao como é possivel fazer um funcao que receber varios parametros. Todas as funcoes que receber mais de um parametro são `curried functions`. E o que isso quer dizer?
    
-}


multThree :: Num a => a -> (a -> (a -> a))
multThree x y z = x * y * z 





{-
Entao o que acontece quando nos fazemos `multThree 3 5 9 or ((multThree 3) 5) 9`? Primeiro, 3 é aplicado para multThre,
por causa que estão separados por um espaço. Que cria uma função que pega um parametro e retorna uma função.
Então 5 é aplicado a isso, que cria a função que vai pegar o parametro e multiplicar isso por 15. 
9 é aplicado para essa funcao e o resultado é 135. Lembre-se que o tipo da funcao pode se escrever assim
`multThree :: (Num a) => a -> (a -> (a -> a))`. A coisa antes de `->` é o parametro que a funcao pega e a coisa de depois é a o que é retornado.
Entao a funcao pega `a` e retorna a funcao do tipo `(Num a) => a -> (a -> a)`, similar, essa funcao pega um `a` e retorna uma funcao do tipo `(Num a) => a -> a` e essa funcao finalmente pega `a` e retorna `a`
-}
multTwoWithNine :: Integer -> Integer -> Integer
multTwoWithNine = multThree 9 
-- multTwoWithNine 2 3  => 54

multWithEighteen = multTwoWithNine 2 
-- multWithEighteen 10  => 180
{-Ao chamar funções com poucos parâmetros, por assim dizer, estamos criando novas funções rapidamente.



E se quiséssemos criar uma função que pega um número e o compara a 100? Poderíamos fazer algo assim:
compareWithHundred :: (Ord a, Num a) => a -> Ordering
compareWithHundred x = compare 100 x  

-- Se chamamos essa funcao com 99, vai retornar GT. Coisa simples. Note que x esta no dois lados da equacao.
Agora vamos pensar sombre oque `compare 100` retorna. isso retorna a funcao que pega um numero e compara com 100 
-}
compareWithHundred :: (Num a, Ord a) => a -> Ordering  
compareWithHundred = compare 100  
{-
O tipo de declaracao continua o mesmo, por que `compare 100` retorna a funcao. `Compare` tem o tipo de:
`(Ord a) => a -> (a -> Ordering)` e chamando isso com 100 retona: `(Num a, Ord a) => a -> Ordering`. 
A `class constraint` adicional aparece por cause que `100` é tambem parte de `Num typeclass`. 
-}




{-
Com funcoes `infix` pode tambem ser aplicada parcialmente usando `sections`. 
`To section an infix function`, simplesmente coloque () e somente coloque o parametro de um lado.
Isso cria uma funcao que recebe um parametro e aplica para o lado que esta sem o 'operante'
-}
divideByTen :: (Floating a) => a -> a  
divideByTen = (/10) 
--  divideByTen 200 => 10 -- pois é equivalente a fazer 200 / 10, sendo `(/10) 200`


{-

-- Funcoes podem receber funcoes como parametros e retornar funcoes
-- Para ilustrar isso vamos fazer uma funcao que pega uma funcao e entao aplica duas vezes a alguma coisa:


applyTwice :: (a -> a) -> a -> a  
applyTwice f x = f (f x)

Primeiro de tudo note a declaracao de tipo. Antes, nos nao precisamos dos () porque o `->` é naturalmente `right-associative`. De qualquer maneira, aqui, os () são mandatorios.
Eles indicam que o primeiro parametro é uma funcao que pega alguma coisa e retorna essa mesma coisa, o segundo parametro é alguma coisa do mesmo tipo e o valor de retorno é tambem do mesmo tipo.
Vamos dizer que essa funcao leva 2 parametros e retorna uma coisa. O primeiro parametro é uma funcao(do tipo `a -> a`) e o segundo e o mesmo `a`

o Corpo da funcao é bastante simples. Nos somente usamos o parametro `f` como funcao, e aplicamos a `x` separando eles com um espaco e entao aplicando o resultado para `f` novamente, alguns exemplos:

ghci> applyTwice (+3) 10  
16  
ghci> applyTwice (++ " HAHA") "HEY"  
"HEY HAHA HAHA"  
ghci> applyTwice ("HAHA " ++) "HEY"  
"HAHA HAHA HEY"  
ghci> applyTwice (multThree 2 2) 9  
144  
ghci> applyTwice (3:) [1]  
[3,3,1]  


-} 


-- Vamos criar uma funcao chamada `zipWith'`.
-- Que pega uma funcao e duas lista e entao junta as duas lista aplicando a a funcao entre o correspondentes elementos
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys 