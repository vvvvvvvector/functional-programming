import System.IO

-- withFile (wszystko co robimy na pliku robimy w tej funkcji?)
-- :t withFile

main = do
    withFile "data.txt" ReadMode (\hIn -> 
        withFile "results.txt" WriteMode (\hOut -> do
            contents <- hGetContents hIn
            hPutStr hOut contents))