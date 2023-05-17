-- :t return 5 - monada

-- return 5 :: Maybe Int

-- return 5 :: [Int]

-- :t (>>=) - nie mozemy wyciagnac, mozemy przetwarzac wartosc

-- Div (Val 1) (Val 2) => 1 / 2
-- Div (Div (Val 4) (Val 5)) (Val 2) => (4 / 5) / 2
-- Div (Div (Val 41) (Val 5)) (Val 2)

data Expr = Val Int | Div Expr Expr deriving (Show)

eval :: Expr -> Int
eval (Val n) = n
eval (Div x y) = div (eval x) (eval y)

safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv x y = Just (div x y)

eval' :: Expr -> Maybe Int
eval' (Val n) = Just n
eval' (Div x y) = 
    case (eval' x) of 
        Nothing -> Nothing
        Just m -> case (eval' y) of 
            Nothing -> Nothing
            Just n -> safediv m n

-- Just 5 >>= (\x -> Just (x + 1))

-- Just n >>= f = f n - pseudokod
-- Nothing >>= _ = Nothing

-- notacja do -> ?jakby jezyk imperatywny w haskellu? -> imperatywna notacja dla HOF -> oszustwo

-- eval' ~ eval'' ~ eval'''

eval'' :: Expr -> Maybe Int
eval'' (Val n) = Just n
eval'' (Div x y) = 
    do 
        m <- eval'' x -- pod m podsawiamy wartosc...
        n <- eval'' y -- pod n podsawiamy wartosc...
        safediv m n 

eval''' :: Expr -> Maybe Int
eval''' (Val n) = Just n
eval''' (Div x y) =
    (eval''' x) >>= (\m -> (eval''' y) >>= (\n -> safediv m n))

-- getChar -> zwraca monade

-- f = [getChar, getChar] -- lista akcji IO, a chcemy otrzymac tablice znakow
-- ?chcemy zwrocic napis jako monade?

getTwoChars :: IO [Char]
getTwoChars = do
    a <- getChar -- pod a bedzie zwykly Char, czyli rozpakowalismy Monade IO Char
    b <- getChar -- pod b bedzie zwykly Char, czyli rozpakowalismy Monade IO Char
    return [a, b] -- wartosc opakowana w Monade IO

getTwoChars' :: IO [Char]
getTwoChars' = do
    a <- getChar
    _ <- getChar 
    -- getChar
    b <- getChar
    return [a, b]

-- f :: IO Int
-- f = do
    -- x <- 4 -- nie jest to Monada w ktora ta czworka jest opakowana 
    -- return x

f :: IO Int
f = do
    x <- return 4 -- return opakowuje w Monade; return nie konczy funkcje
    return x -- :t f' IO Int

-- q = f + (return 5) -- nie zadziala, probujemy dodawac monady

q = do 
    x <- f
    return (x + 5)

ignoreLine :: IO () -- odpowiednik void'a
ignoreLine = do
    -- return () - nie powoduje wczesniejszego zakonczenia funkcji
    getLine
    return ()

-- :t putStrLn - pobiera napis, ale nie zwraca nic

-- putStr, putChar
-- putStrLn

-- (read "345") :: Int -> 345

-- readIO
-- (readIO "345") :: (IO Int)

-- readLn
-- readLn :: (IO Int)

-- import System.IO
-- :t stdin
-- :t stdout
-- :t stderr