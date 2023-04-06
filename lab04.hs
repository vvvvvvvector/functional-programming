-- Sortowanie przez wstawianie

-- insertAtIndex list element 0 = element : list
-- insertAtIndex (h:t) element index = h : insertAtIndex t element (index - 1)

insert el [] = [el]
insert el (h:t) = 
    if el <= h then 
        el : h : t
    else 
        h : insert el t 

insertionSort [] = []
insertionSort (h:t) = insert h $ insertionSort t

-- Operacje na slownikach

first (a, _) = a
second (_, b) = b

exists :: Eq a => a -> [(a, b)] -> Bool
exists _ [] = False
exists key (h:t) =
    if first h == key then
        True
    else 
        exists key t

getValue :: Eq a => a -> [(a, b)] -> b
getValue _ [] = error "There are no element with that key"
getValue key (h:t) = 
    if first h == key then
        second h
    else 
        getValue key t

setValue :: Eq a => a -> b -> [(a, b)] -> [(a, b)]
setValue key value [] = [(key, value)]
setValue key value (h:t) = 
    if first h == key then
        (first h, value) : t
    else 
        (first h, second h) : setValue key value t

-- -> front
-- <- back
-- kolejka; koniec kolejki jest poczatkiem listy...

emptyQueue :: ([a], [a])
emptyQueue = ([], [])

push :: a -> ([a], [a]) -> ([a],[a])
push element (front, back) = (front, element:back)

pop :: ([a], [a]) -> (([a], [a]), a) -- pop ([1, 2, 3], [4, 6, 5])
pop (h:t, back) = ((t:b), h) -- pop ([], [1, 2, 4])
pop ([], h:t) = pop (reverse (h:t), [])