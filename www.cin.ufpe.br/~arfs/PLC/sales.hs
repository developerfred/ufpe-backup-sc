sales :: Int -> Int
sales 0 = 5
sales 1 = 7
sales 2 = 10
sales 3 = 9
sales 4 = 15
sales 5 = 4
sales 6 = 3
sales 7 = 8

totalSales::Int->Int
totalSales x
          | x == 0 = sales 0
          | otherwise = sales x + totalSales (x - 1)

maxSales::Int->Int
maxSales n
       |n == 0 = sales n
       |otherwise = max (sales n) (maxSales (n - 1))

howManyWeeks::Int->Int->Int
howManyWeeks v s
             |v == sales s howManyWeeks v (s-1)
             |otherwise =
