square :: Float -> Float
square x = x * x

delta :: (Float, Float, Float) -> Float -- Definicao uncurried
delta (a,b,c) = sqrt (square b - 4 * a * c)

bhaskara :: Float -> Float -> Float -> (Float,Float) -- Definicao curried
bhaskara a b c
    | delta < 0 = error "Nao existem raizes reais"
    | delta == 0 = (r1,r1)
    | otherwise = (r1, r2)
    where delta = b^2 - 4 * a * c 
          r1 = (-b + sqrt delta) / (2 * a)
          r2 = (-b - sqrt delta) / (2 * a)


bhaskara' :: Float -> Float -> Float -> (Float, Float)
bhaskara' a b c = 
  let delta = b^2 - 4 * a * c
      r1 = (-b + sqrt delta) / (2 * a)
      r2 = (-b - sqrt delta) / (2 * a)
  in (r1, r2)


{-# LANGUAGE #-}