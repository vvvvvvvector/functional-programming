-- 1
-- helper_func n result =
--     if n <= 1 then 
--         result
--     else 
--         helper_func (n - 1) (result * n)

-- recursion n = helper_func n 1 
-- 1

-- 2
-- helper_func (h:t) result =
--     if t == [] then
--         result + h
--     else 
--         helper_func t (h + result)

-- list_sum li = helper_func li 0
-- 2

-- 3
-- helper_func k index result =
--     if k < index then
--         result
--     else 
--         helper_func k (index + 1) (result + index)

-- my_sum k = helper_func k 1 0 
-- 3

-- 4
-- helper_func k result =
--     if k == 0 then
--         result
--     else 
--         helper_func (k - 1) (result + k)

-- my_sum k = helper_func k 0
-- 4

-- 5
-- helper_func (h:t) length =
--     if t == [] then
--         length + 1
--     else 
--         helper_func t (1 + length)

helper_func [] length = length
helper_func (_:t) length = helper_func t (1 + length)

list_length list = helper_func list 0
-- 5 