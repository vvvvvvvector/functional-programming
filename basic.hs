first (a, _, _) = a

-- first (1, 2, 3)
-- 1

second (_, b, _) = b

-- second (1, 2, 3)
-- 2

third (_, _, c) = c

-- second (1, 2, 3)
-- 3

head' [] = error "List is empty"
head' (h:_) = h

-- head [120, 2, 4]
-- 120

empty _ = []

-- empty [1, 2, 3]
-- []

len [] = 0
len (_:t) = 1 + len t

-- len [1, 2, 3, 4]
-- 1 + len [2, 3, 4]
-- 1 + (1 + len [3, 4])
-- 1 + (1 + (1 + len [4]))
-- 1 + (1 + (1 + (1 + len [])))
-- 1 + (1 + (1 + (1 + 0))) -> 0 + 1 + 1 + 1 + 1 = 4

sum' [] = 0
sum' (h:t) = h + sum' t

-- sum [5, 10, 20]
-- 5 + sum [10, 20]
-- 5 + (10 + sum [20])
-- 5 + (10 + (20 + sum[]))
-- 5 + (10 + (20 + 0)) -> 5 + 10 + 20 = 35

add [] new_element = new_element : []
add (h:t) new_element = h : add t new_element

-- add [1, 2, 3] 200
-- 1 : add [2, 3] 200
-- 1 : 2 : add [3] 200
-- 1 : 2 : 3 : add [] 200
-- 1 : 2 : 3 : 200 : [] -> [1, 2, 3, 200]

remove list element = filter (\x -> x /= element) list

remove_first [] _ = []
remove_first (h:t) element = 
    if h == element
        then t
    else 
       h : remove_first t element

-- remove_first [1, 2, 2, 3, 4] 2
-- 1 : remove_first [2, 2, 3, 4] 2
-- ???

elementAtIndex 0 (h:_) = h
elementAtIndex index (h:t) = elementAtIndex (index - 1) t

-- elementAtIndex 2 [20, 40, 70, 120]
-- elementAtIndex 1 [40, 70, 120]
-- elementAtIndex 0 [70, 120]
-- 70

isElementInAList element [] = False
isElementInAList element (h:t) = 
    if h == element
        then True
    else
        isElementInAList element t

-- isElementInAList 10 [1, 2, 3, 10] 10 /= 1
-- isElementInAList 10 [2, 3, 10] 10 /= 2
-- isElementInAList 10 [3, 10] 10 /= 3
-- isElementInAList 10 [10] 10 == 10 -> True

sumOfLists [] [] = []
sumOfLists [] (h:t) = h : sumOfLists [] t
sumOfLists (h:t) list2 = h : sumOfLists t list2

-- sumOfLists [1, 2, 3] [4, 5, 6]
-- 1 : sumOfLists [2, 3] [4, 5, 6]
-- 1 : (2 : sumOfLists [3] [4, 5, 6])
-- 1 : (2 : (3 : sumOfLists [] [4, 5, 6]))
-- 1 : (2 : (3 : (4 : sumOfLists [] [5, 6])))
-- 1 : (2 : (3 : (4 : (5 : sumOfLists [] [6]))))
-- 1 : (2 : (3 : (4 : (5 : (6 sumOfLists [] [])))))
-- 1 : (2 : (3 : (4 : (5 : (6 : [])))))

sumOfLists' [] list2 = list2
sumOfLists' (h:t) list2 = h : sumOfLists' t list2

-- sumOfLists' [1, 2, 3] [7, 8, 9]
-- 1 : sumOfLists' [2, 3] [7, 8, 9]
-- 1 : (2 : sumOfLists' [3] [7, 8, 9])
-- 1 : (2 : (3 : sumOfLists' [] [7, 8, 9]))
-- 1 : (2 : (3 : [7, 8, 9])) -> 1 : 2 : 3 : [7, 8, 9]

intersection list1 list2 = filter (\x -> elem x list1) list2

-- intersection [1, 2, 3, 4] [3, 4, 5, 6]
-- elem 3 [1, 2, 3, 4] True [3]
-- elem 4 [1, 2, 3, 4] True [3, 4]
-- elem 5 [1, 2, 3, 4] False
-- elem 6 [1, 2, 3, 4] False