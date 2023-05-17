import System.IO
import System.IO.Error
import System.Environment

getHandle :: IO Handle
getHandle = do 
    args <- getArgs
    openFile (args !! 0) ReadMode

printFile :: IO () -- wykonuje akcje ale nic nie zwraca
printFile = do 
    args <- getArgs
    if length args == 0 then
        putStrLn "No arguments"
    else
        do
            handle <- openFile (args !! 0) ReadMode
            contents <- hGetContents handle
            putStr contents

-- errorHandler :: IOError -> IO ()
-- errorHandler _ = do
--     putStrLn "Error opening the file."

errorHandler :: IOError -> IO ()
errorHandler e = do
    if isDoesNotExistError e then 
        putStrLn "Plik nie istnieje"
    else 
        if isPermissionError e then
            putStrLn "Brak dostepu"
        else
            putStrLn "Inny dziwny blad"


-- errorHandler :: IOError -> IO Handle
-- errorHandler _ = do
--     putStrLn "Error opening the file."
--     return () -- return () => IO () [void haskelowy]

-- getHandleWithErrors :: IO Handle
-- getHandleWithErrors = 
--     catchIOError getHandle errorHandler

printFileWithErrors :: IO ()
printFileWithErrors = do
    catchIOError printFile errorHandler

-- main = do
--     -- handle <- getHandle
--     handle <- getHandleWithErrors
--     contents <- hGetContents handle
--     putStr contents 

main = printFileWithErrors

