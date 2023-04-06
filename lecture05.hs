factorials_help :: Integer -> Integer -> [Integer]
factorials_help i f_i = f_i :(factorials_help (i + 1) (f_i * (i + 1)))

factorials :: [Integer]
factorials = factorials_help 0 1

elemAt 0 (h:_) = h
elemAt i (_:t) = elemAt (i - 1) t

naturals_from_n n = n:(naturals_from_n (n + 1))
naturals = naturals_from_n 1

-- leniwa ewaluacja
-- elemAt 2 naturals
-- elemAt 2 (naturals_from_n 0)
-- elemAt 2 (0:(naturals_from_n 1))
-- elemAt 1 (naturals_from_n 1)
-- elemAt 1 (1:(naturals_from_n 2))
-- elemAt 0 (naturals_from_n 2)
-- elemAt 0 (2:(naturals_from_n 3))
-- 2
-- leniwa ewaluacja

-- scisla ewaluacja
-- elemAt 2 naturals
-- elemAt 2 (naturals_from_n 0)
-- elemAt 2 (0:(naturals_from_n 1))
-- elemAt 2 (0:1:(naturals_from_n 2))
-- scisla ewaluacja

-- h:t === (:) h t 

-- funkcje z modulu Prelude
-- repeat :: a -> [a] -- take 10 $ repeat 3

-- cycle :: [a] -> [a] -- take 3 $ cycle [1, 2, 3]

-- iterate :: (a -> a) -> a -> [a] - odpowiednik petli pewnej
-- x : f(x) : f(f(x)) : ...

-- [[a]] - lista dwuwymiarowa
matrix_from_x :: Int -> Int -> a -> [[a]] -- matrix_from_x 3 4 544

-- matrix_from_x m n x = 
--     let 
--         row = row_from_x n x
--     in 
--         row_from_x m row

matrix_from_x m n x = row_from_x m (row_from_x n x)

row_from_x :: Int -> a -> [a] -- row_from_x 3 123
row_from_x 0 _ = []
row_from_x i x = x:(row_from_x (i - 1) x)

-- :t (+)

-- infix 7 % ?
(%) :: Integral a => a -> a -> a
m % n = mod m n

first_letter :: String -> Char
first_letter (h:t) = h

type Matrix = [[Int]]
matrixSum :: Matrix -> Int
matrixSum m = sum $ map sum m -- matrixSum [[1, 2, 3], [5, 6, 7]]

data Season = Spring | Summer | Autumn | Winter deriving Show

nextSeason :: Season -> Season
nextSeason Spring = Summer
nextSeason Summer = Autumn
nextSeason Autumn = Winter
nextSeason Winter = Spring

data Shape = Circle Double | Square Double | Rectangle Double Double deriving Show

area :: Shape -> Double
area (Circle r) = pi * r * r
area (Square a) = a * a 
area (Rectangle a b) = a * b -- area $ Rectangle 4 5 || area (Rectangle 4 5)

-- Rectangle 4.5 3.5
-- map Circle [1, 2, 3, 4]
-- zipWith Rectangle ...