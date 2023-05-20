-- lab06 cos podobne

-- rozmiar pola 21x11

-- (0, 0) == (x, y) - 'stan planszy'
-- if '>' i f -> x++
-- if '<' i f -> x--
-- if '^' i f -> y--
-- if 'v' i f -> y++

-- logToConsole $ showBoard $ Board (Position 0 0) R

-- showBoard $ Board (Position 0 0) R

-- rows $ Board (Position 0 0) U

-- showRow (Board (Position 5 (-2)) U) 5

-- showField (Board (Position 5 (-2)) U) (Position 10 5)

-- logToConsole $ showBoard (makeStep (Board (Position 0 0) R))

-- logToConsole (showBoard $ runCommand (Board (Position 0 0) R) "fffffnff")

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

data Board = Board Position Direction deriving Show

loopHelper start end x result =
    if start == end then
        result
    else 
        loopHelper (start + 1) end x (result ++ [[(i, start) | i <- [(-10 + x)..(10 + x)]]])

loop :: Int -> Int -> [[(Int, Int)]]
loop x y = loopHelper (-5 + y) (6 + y) x []

createRowHelper :: [(Int, Int)] -> Int -> Int -> Direction -> String -> String
createRowHelper [] _ _ _ result = result ++ "\n"
createRowHelper ((x, y):t) playerX playerY direction result = 
    if playerX == x && playerY == y then
        createRowHelper t playerX playerY direction (result ++ (returnSign direction))
    else 
        if x >= 0 && y >= 0 then 
            createRowHelper t playerX playerY direction (result ++ "#")
        else
            createRowHelper t playerX playerY direction (result ++ "~")

createRow :: [(Int, Int)] -> Int -> Int -> Direction -> String
createRow tuplesRow x y direction = createRowHelper tuplesRow x y direction ""

showBoardHelper :: [[(Int, Int)]] -> Int -> Int -> Direction -> String -> String
showBoardHelper [] _ _ _ result = result
showBoardHelper (h:t) x y direction result = showBoardHelper t x y direction (result ++ (createRow h x y direction))

showBoard :: Board -> String
showBoard (Board (Position x y) direction) = showBoardHelper (loop x y) x y direction ""

rows :: Board -> [String]
rows board = lines $ showBoard board

showRow :: Board -> Int -> String
showRow board index = (rows board) !! index

showField :: Board -> Position -> Char
showField board (Position x y) = (showRow board y) !! x

makeStep :: Board -> Board
makeStep (Board (Position x y) direction)
    | direction == R = (Board (Position (x + 1) y) direction)
    | direction == L = (Board (Position (x - 1) y) direction)
    | direction == U = (Board (Position x (y - 1)) direction)
    | direction == D = (Board (Position x (y + 1)) direction)

changeDirection :: Board -> Char -> Board
changeDirection (Board (Position x y) direction) newDirection
    | newDirection == 'n' = (Board (Position x y) U)
    | newDirection == 's' = (Board (Position x y) D)
    | newDirection == 'w' = (Board (Position x y) L)
    | newDirection == 'e' = (Board (Position x y) R)

runCommand :: Board -> String -> Board
runCommand board [] = board
runCommand board (h:t)
    | h == 'f'  = runCommand (makeStep board) t
    | h == 'n'  = runCommand (changeDirection board h) t
    | h == 's'  = runCommand (changeDirection board h) t
    | h == 'w'  = runCommand (changeDirection board h) t
    | h == 'e'  = runCommand (changeDirection board h) t
    | otherwise = runCommand board t