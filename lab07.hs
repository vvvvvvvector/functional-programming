-- (Node (Node Empty 3 Empty) 5 (Node Empty 7 Empty))

data BTree a = Empty | Node (BTree a) a (BTree a) deriving (Show)

search :: Ord a => a -> (BTree a) -> Bool
search _ Empty = False
search el (Node left x right)
    | el == x   = True
    | el > x    = search el right
    | el < x    = search el left

insert :: Ord a => a -> (BTree a) -> BTree a
insert newEl Empty = Node Empty newEl Empty
insert newEl (Node left x right)
    | newEl == x   = (Node left x right)
    | newEl < x    = (Node (insert newEl left) x right)
    | newEl > x    = (Node left x (insert newEl right))

sumElements :: Num a => (BTree a) -> a
sumElements Empty = 0
sumElements (Node left x right) = x + (sumElements left) + (sumElements right)

findMax :: (BTree a) -> (Maybe a)
findMax Empty = Nothing
findMax (Node _ x Empty) = Just x
findMax (Node _ _ right) = findMax right

findMin :: (BTree a) -> (Maybe a)
findMin Empty = Nothing
findMin (Node Empty x _) = Just x
findMin (Node left _ _) = findMin left

-- list2tree . reverse ~ (\x -> helper (reverse x))
helper :: Ord a => [a] -> (BTree a)
helper [] = Empty
helper (h:t) = insert h (helper t)

-- list2tree x = helper . reverse ???

-- dla BTree -> sorted list
inOrder :: (BTree a) -> [a]
inOrder Empty = []
inOrder (Node left x right) = (inOrder left) ++ [x] ++ (inOrder right)