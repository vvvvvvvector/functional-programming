data Shape = Circle Double | Square Double | Rectangle Double Double deriving Show

-- :t Show

-- data Date = Date Int Int Int deriving Show

-- year :: Date -> Int
-- year (Date _ _ y) = y

-- month :: Date -> Int
-- month (Date _ m _) = m

-- day :: Date -> Int
-- day (Date d _ _) = d

data Date = Date { 
    day :: Int, 
    month :: Int, 
    year :: Int
} deriving (Show)

-- year (Date 12 05 2018)

data Person = Person {
    firstName :: String,
    lastName :: String,
    birthday :: Date
} deriving Show

-- let birthdayYear = birthday . year; birthdayYear (Person ...)

data Pair a b = Pair a b deriving Show 

first :: Pair a b -> a
first (Pair el _) = el

second :: Pair a b -> b
second (Pair _ el) = el

-- data Maybe a = Nothing | Just a

-- head' :: [a] -> Maybe a
-- head' [] = Nothing
-- head' (h:_) = Just h

-- Cons polaczenie dwoch elementow w pare - Cons 1 (Cons 2 (Cons 3 Null)) ~ [1, 2, 3]
data List a = Null | Cons a (List a) deriving Show

head' :: List a -> a -- head' (Cons 1 (Cons 2 (Cons 3 Null)))
head' (Cons h _) = h

tail' :: List a -> List a -- tail' (Cons 1 (Cons 2 (Cons 3 Null)))
tail' (Cons _ t) = t

length' :: List a -> Int
length' Null = 0
length' (Cons _ t) = 1 + length' t

-- Node (Node Leaf 3 Leaf) 5 (Leaf)
data BST a = Leaf | Node (BST a) a (BST a) deriving (Show, Eq, Read, Ord) 

-- Eq: (Node Leaf 3 Leaf) == Leaf -> False
-- Eq: (Node Leaf 3 Leaf) == (Node Leaf 3 Leaf) -> True

-- (Node Leaf 5 Leaf) > (Node Leaf 3 Leaf) -> True

-- read "(Node Leaf 5 Leaf)" :: BST Int - konwersja napisu na wartosci

-- elemBST 3 $ Node (Node Leaf 3 (Node Leaf 4 Leaf)) 5 (Leaf) -> True
elemBST :: Ord a => a -> BST a -> Bool
elemBST _ Leaf = False
elemBST el (Node left x right) 
    | el == x     = True
    | el < x      = elemBST el left 
    | el > x      = elemBST el right

heightBST :: BST a -> Int
heightBST Leaf = 0
heightBST (Node left _ right) = 1 + max (heightBST left)  (heightBST right)

-- Num, Ord, Eq, Show, Read

-- show 5 -> "5"
-- (read "123") :: Double -> 123.0

class Add a where 
    add :: a -> a -> a
    sub :: a -> a -> a
    zero :: a 
    neg :: a -> a
    neg x = sub zero x

data vector2D a = vector2D a a deriving (Show)

instance Num a => Add (vector2D a) where
    zero = vector2D 0 0 
    add (vector2D x1 y1) (vector2D x2 y2) = (vector2D (x1 + x2) (y1 + y2))
    sub (vector2D x1 y1) (vector2D x2 y2) = (vector2D (x1 - x2) (y1 - y2))



