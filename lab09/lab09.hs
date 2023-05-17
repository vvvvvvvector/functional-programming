-- Obsluga bledow

-- Text.Read ; ReadMaybe (zwraca Maybe a) ~~ read (zwraca a)

import Text.Read
import System.IO
import System.IO.Error
import System.Environment

-- +++++++++++++++++++++++++++++++++++++++++++++

strToInt :: String -> Integer
strToInt = read

strToIntMaybe :: String -> Maybe Integer
strToIntMaybe = readMaybe

raiseError :: IO ()
raiseError = do
    h <- openFile "niematakiegopliku" ReadMode
    hClose h

handleError :: IOError -> IO ()
handleError _ = putStrLn "Error!"

-- ghci -> catchIOError raiseError handleError

-- +++++++++++++++++++++++++++++++++++++++++++++

-- lines "1 2 3 4\n5 6 7 8\n8 9 10\n"
-- words "1 2 3 4\n5 6 7 8\n8 9 10\n"

processContents :: String -> Maybe String
processContents contents = Nothing

readJustFile :: String -> IO (Maybe String)
readJustFile fileName = do
    contents <- readFile fileName
    return (Just contents)

handleReadContents :: IOError -> IO (Maybe String)
handleReadContents _ = return Nothing

readContentsMaybe :: String -> IO (Maybe String)
readContentsMaybe fileName = do
    catchIOError (readJustFile fileName) handleReadContents
    

main = do
    args <- getArgs

    if (length args) < 2 then
        putStrLn "Brak argumentow"
    else
        let
            fileIn = args !! 0
            fileOut = args !! 1
        in  
            do
                maybeContents <- readContentsMaybe fileIn

                case maybeContents of 
                    Nothing -> putStrLn "Wystapil blad"
                    Just contents -> writeFile fileOut contents

                return ()