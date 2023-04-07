-- Task 1
secondAndFourthCond :: Int -> [(Int, Double)] -> Bool
secondAndFourthCond _ [] = True
secondAndFourthCond size (h:t) = 
    if (fst h) < 0 || ((fst h) + 1) > size || (snd h) == 0.0  then
        False
    else
        secondAndFourthCond size t

thirdCond :: [(Int, Double)] -> Int -> Bool
thirdCond [] _ = True
thirdCond (h:t) prevKey = 
    if (fst h) <= prevKey then
        False
    else 
        thirdCond t (fst h)


checkMap :: (Int, [(Int, Double)]) -> Bool
checkMap (size, list) = (size > 0) && (secondAndFourthCond size list) && (thirdCond (tail list) (fst (head list)))
-- Task 1

-- Task 2
listToMapHelper :: [Double] -> Int -> [(Int, Double)] -> (Int, [(Int, Double)])
listToMapHelper [] index result = (index, result) 
listToMapHelper (h:t) index result =
    if h /= 0.0 then
        listToMapHelper t (index + 1) (result ++ [(index, h)])
    else 
        listToMapHelper t (index + 1) result


listToMap :: [Double] -> (Int, [(Int, Double)])
listToMap list = listToMapHelper list 0 []
-- Task 2

-- Task 3 | (20, [(4, 1.5), (10, -5.6), (11, 1.0), (18, 4.7)])
mapToListHelper :: Int -> Int -> [(Int, Double)] -> [Double] -> [Double]
mapToListHelper counter size [] result = result ++ replicate (size - counter) 0
mapToListHelper counter size ((key, value):t) result = 
    if counter == key then
        mapToListHelper (counter + 1) size t (result ++ [value])
    else 
        mapToListHelper (counter + 1) size ((key, value):t) (result ++ [0])

mapToList :: (Int, [(Int, Double)]) -> [Double]
mapToList (size, list) = mapToListHelper 0 size list []
-- Task 3

-- Task 4
elemAtList :: [Double] -> Int -> Double
elemAtList [] _ = 0.0
elemAtList (h:_) 0 = h
elemAtList (_:t) index = elemAtList t (index - 1)
-- Task 4

-- Task 5 (?) index == 0, 1, 2, ... || index == 4, 10, 11, 18, ...
elemAtMapHelper :: [(Int, Double)] -> Int -> Double
elemAtMapHelper [] _ = 0.0
elemAtMapHelper (h:_) 0 = snd h
elemAtMapHelper (_:t) index = elemAtMapHelper t (index - 1)

elemAtMap :: (Int, [(Int, Double)]) -> Int -> Double
elemAtMap (first, second) index = elemAtMapHelper second index
-- Task 5 (?)