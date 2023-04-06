empty _ = False
-- empty' = []

-- odd_numbers x = mod x 2 == 1

odd_numbers = odd --set of odd numbers

even_numbers = even --set of even numbers

contains s = s
contains' s el = elem s el

-- remove_first _ [] = []
-- remove_first el (h:t) = if el == h then t else h : (remove_first el t)

-- funkcja ktora prejmuje 1 argument - el
-- add set element = \x -> contains set x || element == x
-- add s x el = s el || x == el --zbior, to co dodajemy
-- add' s el = el (remove_first el s)

-- remove s x el = s el && x /= el
-- remove' = remove_first

-- sum' s1 s2 = \el -> s1 el || s2 el
-- sum' s1 s2 el = (s1 el) || (s2 el) --(sum' odd_numbers even_numbers) 6

intersection s1 s2 el = s1 el && s2 el

difference s1 s2 el = s1 el && not (s2 el)

-- complement s el = not (s el)
complement s = not . s

-- elem el list - sprawdza czy element jest w liscie
list_to_predicate xs el = elem el xs

remove_duplicates [] = []
remove_duplicates (h:t) = h : (filter (/= h)) (remove_duplicates t)

sum'' s1 s2 = remove_duplicates (s1 ++ s2)

intersection' s1 s2 = filter (\x -> elem x s1) s2

difference' s1 s2 = filter (\el -> not (elem el s2)) s1