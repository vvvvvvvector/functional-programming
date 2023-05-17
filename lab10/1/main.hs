-- Improved lab09 program

-- map strToIntMaybe $ words "1 2 3 4\n5 6 7 8\n8 9 10\n"
-- elem Nothing (map strToIntMaybe $ words "1 2 3 4\n5 6 7 8\n8 9 10\n")
-- fromJust (Just x) = x
-- map fromJust $ map strToIntMaybe $ words "1 2 3 4\n5 6 7 8\n8 9 10\n"
-- map (fromJust . strToIntMaybe) $ words "1 2 3 4\n5 6 7 8\n8 9 10\n"
-- sum $ map fromJust $ map strToIntMaybe $ words "1 2 3 4\n5 6 7 8\n8 9 10\n"

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

fromJust :: Maybe a -> a
fromJust (Just x) = x

processContents :: String -> Maybe String
processContents contents = 
    let 
        listMaybeInts = map strToIntMaybe $ words contents
    in
        if elem Nothing listMaybeInts then
            Nothing
        else
            Just (show $ sum $ map fromJust listMaybeInts)

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
                    Just contents -> do
                        case processContents contents of
                            Nothing -> putStrLn "Plik zawiera nie tylko liczby calkowite"
                            (Just result) -> 
                                catchIOError (writeFile fileOut result) (\_ -> putStrLn "Brak mozliwosci otwarcia pliku do zapisu")

                return ()