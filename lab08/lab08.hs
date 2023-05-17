-- words "abc 123 hello"
-- unwords 
-- lines / unlines 

-- import qualified Data.Char [toUpper]
-- import qualified Data.Char as C

-- import System.IO
-- let handle = openFile "bst.hs" ReadMode

-- ####################1#####################
-- import System.IO

-- main = do 
--     handle <- openFile "basic.hs" ReadMode
--     contents <- hGetContents handle
--     putStr contents
--     hClose handle
-- ####################1#####################

-- ####################2#####################
-- import System.IO

-- main = do 
--     -- hSetBuffering stdout NoBuffering
--     putStr "Podaj nazwe pliku: "
--     hFlush stdout
--     fileName <- getLine -- example: ./../basic.hs
--     handle <- openFile fileName ReadMode
--     contents <- hGetContents handle
--     putStr contents
--     hClose handle
-- ####################2#####################

-- ####################3#####################
-- import System.IO

-- getInt :: IO Int
-- getInt = do
--     line <- getLine
--     return (read line)

-- main = do
--     hSetBuffering stdout NoBuffering
--     putStr "First number: "
--     first <- getInt
--     putStr "Second number: "
--     second <- getInt
--     putStrLn $ "Sum: " ++ (show (first + second))
-- ####################3#####################

-- ####################4#####################
-- import System.IO

-- getInt :: IO Int
-- getInt = do
--     line <- getLine
--     return (read line) 

-- getPositiveInt :: IO (Maybe Int)
-- getPositiveInt = do
--     line <- getLine

--     -- number <- return (read line)

--     let number = (read line)
    
--     if number < 0 then 
--         return Nothing
--     else 
--         return (Just number)

-- addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
-- addMaybe Nothing _ = Nothing
-- addMaybe _ Nothing = Nothing
-- addMaybe (Just a) (Just b) = Just (a + b)

-- main = do
--     hSetBuffering stdout NoBuffering

--     putStr "First number: "
--     first <- getPositiveInt
    
--     putStr "Second number: "
--     second <- getPositiveInt

--     case (addMaybe first second) of 
--         Nothing -> putStrLn "err: negative number"
--         Just c -> putStrLn $ "first + second = " ++ (show c)
-- ####################4#####################

-- ####################5#####################
-- import System.IO
-- import Data.Char

-- getInt :: IO Int
-- getInt = do
--     line <- getLine
--     return (read line) 

-- getPositiveInt :: IO (Maybe Int)
-- getPositiveInt = do
--     line <- getLine

--     -- number <- return (read line)

--     let number = (read line)
    
--     if number < 0 then 
--         return Nothing
--     else 
--         return (Just number)

-- getPositiveInt' :: IO (Maybe Int)
-- getPositiveInt' = do 
--     line <- getLine
--     if isNumberStr line then
--         return (Just (read line))
--     else
--         return Nothing

-- isNumberStr :: String -> Bool
-- isNumberStr s =
--     if s == "" then
--         False
--     else 
--         all isDigit s

-- addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
-- addMaybe Nothing _ = Nothing
-- addMaybe _ Nothing = Nothing
-- addMaybe (Just a) (Just b) = Just (a + b)

-- main = do
--     hSetBuffering stdout NoBuffering

--     putStr "First number: "
--     first <- getPositiveInt'
    
--     putStr "Second number: "
--     second <- getPositiveInt'

--     case (addMaybe first second) of 
--         Nothing -> putStrLn "err: wrong number value"
--         Just c -> putStrLn $ "first + second = " ++ (show c)
-- ####################5#####################

-- ####################6#####################
import System.IO
import Data.Char
import System.Environment

getInt :: IO Int
getInt = do
    line <- getLine
    return (read line) 

getPositiveInt :: IO (Maybe Int)
getPositiveInt = do
    line <- getLine

    -- number <- return (read line)

    let number = (read line)
    
    if number < 0 then 
        return Nothing
    else 
        return (Just number)

getPositiveInt' :: IO (Maybe Int)
getPositiveInt' = do 
    line <- getLine
    if isNumberStr line then
        return (Just (read line))
    else
        return Nothing

isNumberStr :: String -> Bool
isNumberStr s =
    if s == "" then
        False
    else 
        all isDigit s

addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe Nothing _ = Nothing
addMaybe _ Nothing = Nothing
addMaybe (Just a) (Just b) = Just (a + b)

main = do
    args <- getArgs
    let filename = (args !! 0)
    handle <- openFile filename ReadMode
    contents <- hGetContents handle
    let s = sum $ map read (words contents)
    hClose handle
    putStrLn $ show s
-- ####################6#####################