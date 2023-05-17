data BTree a = Empty | Node (BTree a) a (BTree a) deriving Show

instance Functor BTree where
    fmap _ Empty = Empty
    fmap f (Node left x right) = 
        Node (fmap f left) (f x) (fmap f right)

data A t = A t

instance (Show t) => Show (A t) where
    Show (A x) = "(" ++ (Show x) ++ ")"