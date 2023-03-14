{-
    Typeclass é um tipo de interface que define alguns comportanmentos, se um tipo é parte de uma tipeclass
    isso significa que suporta e implementa o comportamento da typeclass
-}

-- Verificando a assinatura de funcao == 
-- :t (==) =>
{-(==) :: (Eq a) => a -> a -> Bool -} -- Tudo que esta antes do => no resultado é uma class contraint, podemos ler a declaracao do tipo assim: A funcao de igualdade pega 2 valores que sao do mesmo tipo e retorna um bool, esse dois valores precisam ser membros da classe Eq(isso é a class constraint)

-- Outras explicacoes e typeclasse estao no discord

