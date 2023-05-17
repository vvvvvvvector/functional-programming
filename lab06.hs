-- take 10 [1..100]

-- inferencja typów (infer? in ts)

take' 0 _ = []
take' _ [] = []
take' n (h:t) = h : (take' (n - 1) t)

myTakeHelper :: Int -> [a] -> [a] -> [a]
myTakeHelper 0 _ result = result
myTakeHelper n (h:t) result = 
    myTakeHelper (n - 1) t (result ++ [h])

myTake :: Int -> [a] -> [a] 
myTake 0 [] = []  
myTake _ [] = []
myTake n list = myTakeHelper n list []

take2d :: Int -> Int -> [[a]] -> [[a]]
take2d rows columns matrix = myTake rows $ map (myTake columns) matrix

-- take 10 $ iterate (\x -> x * x) 2

iterate' :: (a -> a) -> a -> [a]
iterate' function arg = arg : iterate' function (function arg)

-- take 10 $ iterate' (\(x, y) -> (x + 1, y * 2)) (2,3)

fibonacci :: [Integer]
fibonacci = map fst $ iterate' (\(fp, f) -> (f, fp + f)) (0, 1)

factorial :: [Integer]
factorial = map snd $ iterate' (\(index, result) -> (index + 1, (index + 1) * result)) (0, 1)

-- ponizej jest zadanie podobne do PD2

data Direction = East | West deriving Show
data Board = Board Int Direction [Bool] deriving Show

-- part $ run "fffmwffmf" start
part :: Board -> Board 
part (Board n d b) = (Board n d (take 20 b))

start :: Board
start = Board 0 East (repeat False)

mark :: Board -> Board
mark board = board 

forward :: Board -> Board
forward (Board n East b) = (Board (n + 1) East b)
forward (Board n West b) = (Board (n - 1) West b)

east :: Board -> Board
east (Board n _ b) = (Board n East b)

west :: Board -> Board
west (Board n _ b) = (Board n West b)

step :: Char -> Board -> Board
step 'm' board = mark board
step 'f' board = forward board
step 'e' board = east board
step 'w' board = west board

run :: String -> Board -> Board
run [] board = board
run (h:t) board = run t $ step h board
