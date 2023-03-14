true = \f1.(\f2.f1) -> \x.\y.x -> \x y.x
false = \f1.(\f2.f2) -> \x.\y.y -> \x y.y
if = \b x y . b x y
and = \a.b.(a b false)
not = \b.(b false true)
or = \a.b.(a true b)


if true a b = (\b x y -> b x y)  true a b 
        ->    (\x y -> true x y)  a b  
        ->    (\x y -> (\p q.p) x y)  a b  
        ->    (\x y -> (\q.x)  y)  a b         
        ->    (\x y -> x)  a b        
        ->    (\y -> a)  b
        ->    (a)   

=========================================


if false a b = (\b x y -> b x y)  false a b 
        ->     (\x y -> false x y)  a b  
        ->     (\x y -> (\p q.q) x y)  a b  
        ->     (\x y -> (\q.q)  y)  a b         
        ->     (\x y -> y)  a b        
        ->     (\y -> y)  b
        ->     (b)       

=========================================
not = \b.b.(false true)
not true = false 
not false = true

not true =
        \b.(b false true)  true
        true false true
        (\xy.x)  false true
        (\y.false)  true
        (false) 

not false = 
        \b.(b false true)  false
        false false true
        (\xy.y)  false true 
        (\y.y)  true
        (true)



=========================================

and = \a.b.(a b false)

and = if a then b else false
a b | a.b                       
0 0 |  0  
         = 0
0 1 |  0  
--------
1 0 |  0
         = b
1 1 |  1

and false false =
->        \a.b.(a b false)  false false
->        \b.(false b false)  false
->        false false false
->        (\xy.y)  false false
->        (\y.y)  false
->        (false)

and true false =
->        \a.b.(a b false)  true false
->        \b(true b false)  false
->        true false false
->        (\x y.x) false false
->        (\y.false) false
->        (false)

and false true =
->        \a.b.(a b false)  false true
->        \b.(false b false)  true
->        false true false
->        (\xy.y)  true false
->        (\y.y)  false
->        (false)

and true true = \
->        \a.b.(a b false)  true true
->        \b.(true b false)  true
->        true  true false 
->        (\x y.x)  true false
->        (\y.true)  false
->        (true)

=============================================

or = \a.b.(a true b)

or = if a then b else true
a b | a.b                       
0 0 |  0  
         = b
0 1 |  1  
--------
1 0 |  1
         = 1
1 1 |  1

or false false 
        \a.b.(a true b)  false false
        \b.(false true b)  false
        false true false 
        (\xy.y)  true false
        (\y.y)  false
        (false)

or true false
        \a.b.(a true b)  true false
        \b.(true true b)  false
        true true false
        (\xy.x)  true false
        (\y.true)  false
        (true)

or false true 
        \a.b.(a true b)  false true
        \b.(false true b)  true
        false true true
        (\xy.y)  true true
        (\y.y)  true
        (true)

        
or true true
        \a.b.(a true b)  true true
        \b.(true true b)  true
        true true true
        (\xy.x)  true true
        (\y.true)  true
        (true)
=========================================



{-Numero Naturais-}
zero = \fx.x
um = \fx.f x
dois = \fx.f(f x)
tres = \fx.f(f(f x))

inc n = \fx.f (n f x)

inc um = \fx.f (n f x) um
->       \fx.f (um f x)
->       \fx.f ((\fx.f x) f x)
->       \fx.f(f x) = dois


inc (inc 3) = 
        \fx.f ((inc 3) f x)
        \fx.f ((\fx.f (n f x) 3) f x)
        \fx.f ((\fx.f (n f x) 3) f x)
        \fx.f ((\fx.f (3 f x)) f x)
        \fx.f ((\x.f (3 f x)) x)
        \fx.f ((f (\fx.f(f(f x)) f x)))
        \fx.f ((f (\x.f(f(f x))x)))
        \fx.f(f(f(f(f x)))) = 5
