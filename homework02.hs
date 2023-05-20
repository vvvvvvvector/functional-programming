-- map (\(x, y) -> (x + 1, y)) [(0,0), (1,0)]

-- logToConsole $ showBoard $ Board (Position 0 0) R [(1,1)]

-- showBoard $ Board (Position 0 0) R [(1, 1)]

-- rows $ Board (Position 0 0) U [(1, 1)]

-- showRow (Board (Position 0 0) U [(1, 1)]) 5

-- showField (Board (Position 0 0) U [(1, 1)]) (Position 10 5)

-- logToConsole $ showBoard (makeStep (Board (Position 0 0) R []))

-- logToConsole $ showBoard $ changeDirection (Board (Position 0 0) R []) 'n'

-- logToConsole (showBoard $ runCommand (Board (Position 0 0) R []) "mfff")

logToConsole :: String -> IO ()
logToConsole board = putStr board

data Position = Position Int Int deriving Show

data Direction = L | R | U | D deriving (Show, Eq)

returnSign :: Direction -> String
returnSign direction
    | direction == L  = "<"
    | direction == R  = ">"
    | direction == U  = "^"
    | direction == D  = "v"

data Board = Board Position Direction [(Int, Int)] deriving Show

loopHelper start end x result =
    if start == end then
        result
    else 
        loopHelper (start + 1) end x (result ++ [[(i, start) | i <- [(-10 + x)..(10 + x)]]])

loop :: Int -> Int -> [[(Int, Int)]]
loop x y = loopHelper (-5 + y) (6 + y) x []

checkIsMarked :: [(Int, Int)] -> (Int, Int) -> Maybe (Int, Int)
checkIsMarked [] _ = Nothing
checkIsMarked ((x, y):t) (a, b) =
    if x == a && y == b then
        Just (a, b)
    else 
        checkIsMarked t (a, b)

createRowHelper :: [(Int, Int)] -> Int -> Int -> Direction -> [(Int, Int)] -> String -> String
createRowHelper [] _ _ _ _ result = result ++ "\n"
createRowHelper ((x, y):t) playerX playerY direction markedCells result = 
    if playerX == x && playerY == y then
        createRowHelper t playerX playerY direction markedCells (result ++ (returnSign direction))
    else 
        if (checkIsMarked markedCells (x, y)) /= Nothing then
                createRowHelper t playerX playerY direction markedCells (result ++ ".")
        else
            if x >= 0 && y >= 0 then 
                createRowHelper t playerX playerY direction markedCells (result ++ "#")
            else 
                createRowHelper t playerX playerY direction markedCells (result ++ "~")

createRow :: [(Int, Int)] -> Int -> Int -> Direction -> [(Int, Int)] -> String
createRow tuplesRow x y direction markedCells = createRowHelper tuplesRow x y direction markedCells ""

showBoardHelper :: [[(Int, Int)]] -> Int -> Int -> Direction -> [(Int, Int)] -> String -> String
showBoardHelper [] _ _ _ _ result = result
showBoardHelper (h:t) x y direction markedCells result = showBoardHelper t x y direction markedCells (result ++ (createRow h x y direction markedCells))

showBoard :: Board -> String
showBoard (Board (Position x y) direction markedCells) = showBoardHelper (loop x y) x y direction markedCells ""

rows :: Board -> [String]
rows board = lines $ showBoard board

showRow :: Board -> Int -> String
showRow board index = (rows board) !! index

showField :: Board -> Position -> Char
showField board (Position x y) = (showRow board y) !! x

-- shiftMarkedCells :: [(Int, Int)] -> ((Int, Int) -> (Int, Int)) -> [(Int, Int)]
-- shiftMarkedCells markedCells func = map func markedCells

makeStep :: Board -> Board
makeStep (Board (Position x y) direction markedCells)
    | direction == R = (Board (Position (x + 1) y) direction markedCells)
    | direction == L = (Board (Position (x - 1) y) direction markedCells)
    | direction == U = (Board (Position x (y - 1)) direction markedCells)
    | direction == D = (Board (Position x (y + 1)) direction markedCells)

changeDirection :: Board -> Char -> Board
changeDirection (Board (Position x y) direction markedCells) newDirection
    | newDirection == 'n' = (Board (Position x y) U markedCells)
    | newDirection == 's' = (Board (Position x y) D markedCells)
    | newDirection == 'w' = (Board (Position x y) L markedCells)
    | newDirection == 'e' = (Board (Position x y) R markedCells)

markCell :: Board -> Board
markCell (Board (Position x y) direction markedCells) = 
    if x >= 0 && y >= 0 then 
        (Board (Position x y) direction (markedCells ++ [(x, y)]))
    else 
        (Board (Position x y) direction markedCells)

runCommand :: Board -> String -> Board
runCommand board [] = board
runCommand board (h:t)
    | h == 'f'  = runCommand (makeStep board) t
    | h == 'n'  = runCommand (changeDirection board h) t
    | h == 's'  = runCommand (changeDirection board h) t
    | h == 'w'  = runCommand (changeDirection board h) t
    | h == 'e'  = runCommand (changeDirection board h) t
    | h == 'm'  = runCommand (markCell board) t
    | otherwise = runCommand board t

boardGetPosition :: Board -> String
boardGetPosition (Board (Position x y) direction markedCells) = "(" ++ show x ++ ", " ++ show y ++ ")\n"

start :: IO ()
start = gameLoop (Board (Position 0 0) R [])

gameLoop :: Board -> IO ()
gameLoop board = do
    logToConsole $ boardGetPosition board
    logToConsole $ showBoard board

    commands <- getLine
    
    let newBoard = runCommand board commands

    if commands == "q" then 
        logToConsole $ showBoard newBoard
    else 
        gameLoop newBoard