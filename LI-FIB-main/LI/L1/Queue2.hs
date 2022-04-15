data Queue a = Queue [a] [a]
     deriving (Show)


create:: Queue a
create = Queue [] []

push:: a -> Queue a -> Queue a
push n (Queue xs ys) = Queue xs (n:ys)

top :: Queue a -> a
-- top (Queue [] []) =
top (Queue [] ys) = head (reverse ys)
top (Queue (x:_) _) = x

pop:: Queue a -> Queue a
pop (Queue [] ys) = Queue (tail (reverse ys)) []
pop (Queue (x:xs) ys) = Queue xs ys

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue _ _) = False

aux :: Queue a -> [a]
aux (Queue [] []) = []
aux (Queue xs ys) = xs ++ reverse ys

instance Eq a => Eq (Queue a) where
    --(Queue xs1 ys1) == (Queue xs2 ys2) = aux (Queue xs1 ys1) == aux (Queue xs2 ys2)
    (Queue xs1 ys1) == (Queue xs2 ys2) = xs1 ++ reverse ys1 == xs2 ++ reverse ys2
