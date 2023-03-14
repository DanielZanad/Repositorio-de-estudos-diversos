{-
    De uma maneira tuplas sao parecidas com listas - tuplas guardam varios valores em um unico valor
    entretanto temos algumas diferencas fundamentais - uma lista de numeros é uma lista de numero, e 
    é esse tipo e n importa se tem um unico numero ou uma quantidade infinita de numeros, tuplas entretanto
    sao usadas quando sabemos exatamente a quantidade de valores que queremos combinar e seus tipos
    Elas sao criadas a partir de () e os componentes separados por ,

    Outra diferenca chave e que tuplas n sao homogenias, diferente de listas 

    Think about how we'd represent a two-dimensional vector in Haskell. One way would be to use a list. That would kind of work. So what if we wanted to put a couple of vectors in a list to represent points of a shape on a two-dimensional plane? We could do something like [[1,2],[8,11],[4,5]]. The problem with that method is that we could also do stuff like [[1,2],[8,11,5],[4,5]], which Haskell has no problem with since it's still a list of lists with numbers but it kind of doesn't make sense. But a tuple of size two (also called a pair) is its own type, which means that a list can't have a couple of pairs in it and then a triple (a tuple of size three), so let's use that instead. Instead of surrounding the vectors with square brackets, we use parentheses: [(1,2),(8,11),(4,5)]. What if we tried to make a shape like [(1,2),(8,11,5),(4,5)]? Well, we'd get this error:

        Couldn't match expected type `(t, t1)'  
        against inferred type `(t2, t3, t4)'  
        In the expression: (8, 11, 5)  
        In the expression: [(1, 2), (8, 11, 5), (4, 5)]  
        In the definition of `it': it = [(1, 2), (8, 11, 5), (4, 5)]  

-}

-- Criando uma tupla
-- ("Christopher", "Walken", 55) => isso é valido

-- criando uma lista de tupla
tupla = [(1,2) , (4,5)] -- Uma tupla precisa seguir as regras de criacao ou seja precisa necessariamente
-- tem nesse caso (Int, Int)

-- Funcao fst que pega um pair e retorna o primeiro component
-- => fst (8,10) =>
{-8-}
-- Funcao snd pega um par e retorna o segundo component
-- => snd (8,10) 
{-10-} 

-- Note: these functions operate only on pairs. They won't work on triples, 4-tuples, 5-tuples, etc. We'll go over extracting data from tuples in different ways a bit later.

-- funcao Zip
-- Essa funcao pega duas listas e 'Zipa' elas juntas em um unica lista combinando elementos em pares
-- => zip [1,2,3,4,5] [5,5,5,5,5]  =>
{-[(1,5),(2,5),(3,5),(4,5),(5,5)]-}
-- => zip [1 .. 5] ["one", "two", "three", "four", "five"]  =>
{-[(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]  -}

-- Caso a primeira lista seja maior que a segunda o zip ele vai ate onde da 
-- => zip [5,3,2,6,2,7,2,5,4,6,6] ["im","a","turtle"] =>
{-[(5,"im"),(3,"a"),(2,"turtle")]  -}
