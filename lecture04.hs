-- len [] = 0
-- len (_:tail) = 1 + len tail

-- len li = len_iter 0 li
-- len_iter acc [] = acc
-- len_iter acc (_:tail) = len_iter (acc+1) tail

-- elem _ [] = False
-- elem a (head:tail) = 
--     if a == head then 
--         True
--     else 
--         elem a tail 

-- elemAt 0 (head:tail) = head
-- elemAt index (head:tail) = elemAt (index-1) tail

-- concat` [] list2 = list2
-- concat` (head:tail) list2 = head:(concat` tail list2)

-- replace 0 new_element (_:tail) = new_element:tail
-- replace index new_element (head:tail) = head:(replace (index - 1) new_element tail)

n = n + 1 -- function without arguments

f x y = x

-- take 10 [1..]
-- take 10 $ concat' [1..] [1, 2, 3, 4, 5]

ones = 1:ones -- nieskonczona lista jedynek (glowa wskazuje na glowe, glowa z 1ka wskazuje na glowe z jedynka)

one_two = 1:2:one_two -- nieskonczona lista [1,2,1,2,1,2, ...] 

naturals_from_n n = n:(naturals_from_n $ n + 1)
naturals = naturals_from_n 1

seq_f_from_n f n = (f:n):seq_f_from_n f (n + 1)
seq_f f = seq_f_from_n f 0

sum_seq a b = a:(sum_seq b (a + b))
fib_seq = sum_seq 0 1 

-- fib_seq` = 0:1:(zipWith (+) fib_seq` $ tail fib_seq`) nie dziala