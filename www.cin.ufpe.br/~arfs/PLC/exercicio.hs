square :: Int -> Int
square x = x * x

allEqual :: Eq a => a -> a -> a -> Bool
allEqual m n p = m == n && n == p

maxi :: Ord a => a -> a -> a
maxi m n
    | m > n     = m
    | otherwise = n

fat::Int->Int
fat 0 = 1
fat n = n*(fat(n-1))

fat2::Int->Int
fat2 n
    |n==0 = 1
    |otherwise = n*(fat2(n-1))

all4Equal::Int->Int->Int->Int->Bool
all4Equal a b c d = a==b && c==d && b == d

all4Equal2::Int->Int->Int->Int->Bool
all4Equal2 a b c d = (allEqual a b c) && c==d

