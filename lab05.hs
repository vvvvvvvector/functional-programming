-- Zadanie 1
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n el = el:replicate' (n - 1) el

matrix :: Int -> Int -> a -> [[a]]
matrix m n el = replicate' m $ replicate' n el
-- Zadanie 1

-- Zadanie 2
identity_row :: Int -> Int -> [Int]
identity_row _ 0 = []
identity_row index size =
    if index == 0
        then 1:(replicate' (size - 1) 0)
    else 
        0:identity_row (index - 1) (size - 1)

-- [identity_row i 5 | i <- [0..4]]

identity_matrix :: Int -> [[Int]]
identity_matrix n = [identity_row i n | i <- [0..n-1]] 
-- Zadanie 2

-- Zadanie 3 Wygeneruj macierz mxn na podstawie funkcji 2arg
generate_matrix :: Int -> Int -> (Int -> Int -> a) -> [[a]]
generate_matrix m n func = [[func row column | column <- [0..(n-1)], row <- [0..(m-1)]]]
-- Zadanie 3 

-- Zadanie 4
set_matrix_element :: [[a]] -> Int -> Int -> [[a]]
set_matrix_element (h:t) 0 n value = (set_row_element h n value):t
set_matrix_element (h:t) m n value = h:(set_matrix_element t (m - 1) n value)

set_row_element :: [a] -> Int -> a -> [a] 
set_row_element (_:t) 0 value = value:t
set_row_element (h:t) n value = h:(set_row_element t (n - 1) value)
-- Zadanie 4
