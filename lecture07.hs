-- data Fraction = Fraction Integer Integer deriving Show

-- simplify :: Fraction -> Fraction
-- simplify (Fraction a b) = 
--     if a == 0 then
--         Fraction 0 1
--     else 
--         let
--             d gcd a b
--             nom = div a d
--             den = div b d
--         in
--             if den < 0 then
--                 Fraction (-nom) (-den)
--             else 
--                 Fraction nom den

-- instance Num Fraction where
--     (Fraction a b) + (Fraction c d)
--         = simplify (Fraction (a * d + b * c) (b * d))
--     (Fraction a b) * (Fraction c d)
--         = simplify (Fraction (a * c) (b * d))
--     abs f = 
--         let 
--             Fraction a b = simplify f
--         in 
--             Fraction (abs a) b
--     signum f = 
--         let 
--             Fraction a b = simplify f
--         in
--             Fraction (signum a) 1
--     fromInteger n = Fraction n 1
--     negate f = 
--         let 
--             Fraction a b = simplify f
--         in
--             Fraction (-a) b


-- instance Show Fraction where
--     show f =
--         let 
--             (Fraction a b) = simplify f
--         in 
--             (show a) ++ "/" ++ (show b)

-- putStrLn "hello world" -- doesn't pure function

-- :t putStrLn

-- ghc lecture07 -- compile

-- jezyk imperatywny w haskellu

-- getLine - user input

-- :t getLine - zwraca akcje ktora zwraca string

-- IO, Maybe - monady

-- :t return
-- Monada opakowuje, nie mozemy rozpakowac
-- :t (>>=)

-- lista jest monada

-- :t return 5

getName :: String
getName = do
    putStrLn "Imie:"
    imie <- getLine
    return imie

-- showName = "Witaj" ++ getName ++ "!"

-- main = do 
--     putStrLn "Imie:"
--     imie <- getLine
--     putStrLn ("Hello, " ++ imie ++ "!")

main = do 
    imie <- getName
    putStrLn ("Hello, " ++ imie ++ "!")

-- (Just 5) >>= (\x -> Just (show x))

-- (Just 5) >>= (\x -> Just (show x)) >>= (\y -> Just (y ++ "!"))
-- (Just 5) >>= (\x -> Just (show x)) >>= (Just . (++ "!"))
-- Nothing >>= (Just . show) >>= (Just . (++ "!"))

-- [5, 4, 3] >>= (\x -> [x, 10 * x])
--  [5, 4, 3] >>= (\x -> [x, 10 * x]) >>= show