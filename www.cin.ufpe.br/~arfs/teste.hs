answer :: Int
answer = 42

greater :: Bool
greater = (answer > 71)

yes :: Bool
yes = True

fat :: Int -> Int
fat 0 = 1
fat n = n*fat(n-1)

all4Equal :: Int -> Int -> Int -> Int -> Bool
all4Equal a b c d = (a==b && b==c && c==d)

sales :: Int -> Int
sales 0 = 10
sales 1 = 5
sales 2 = 9
sales 3 = 11
sales 4 = 5

salesEqualTo :: Int -> Int -> Int
salesEqualTo s 0 
	       |s == sales 0 = 1  
	       | otherwise = 0
salesEqualTo s n
	       | s == sales n = 1 + salesEqualTo s (n-1)
	       |otherwise = salesEqualTo s (n-1)


double :: [Int] -> [Int]
double [] = []
double (a:x) = (2*a):double x

member :: [Int] -> Int -> Bool
member [] _ = False
member (a:x) e
	| a == e = True
	| otherwise = member x e


ins :: Int -> [Int] -> [Int]
ins e [] = e:[]
ins e (a:x)
	| e < a = e : a: x
	| otherwise = a : ins e x




sort :: [Int] -> [Int]
sort [] = []
sort (a:x) = ins a (sort x)

getWord :: String -> String
getWord "" = ""
getWord (a:x)
        | a /= ' ' = a:getWord x
        | otherwise = ""
        
dropWord :: String -> String
dropWord "" = ""
dropWord (a:x)
         | a /= ' ' = dropWord x
         | otherwise = x
         
dropSpace :: String  -> String
dropSpace "" = ""
dropSpace (a:x)
          | a == ' ' = dropSpace x
          | otherwise = a:dropSpace x
          
type Word = String
splitWords :: String -> [Word]
splitWords "" = []
splitWords str = getWord (stri):splitWords (dropWord (stri))
                 where stri = dropSpace str

isCrescent :: (Int -> Int) -> Int -> Bool
isCrescent f 0 = True
isCrescent f n = (f n >= f (n-1)) && isCrescent f (n-1)

test :: Int -> Int
test n
     | n == 2 = 0
     | otherwise = n

--aula dia 17/03/09

--getLine 0 w = []
--getLine n [] = []
--getLine n (w:ws)
--	| length w <= n = w : getLine (n - length w) ws
--	| otherwise     = []


--splitLines n [] = []
--splitLines n ws = getLine n ws : splitLines n (dropLine n ws)

pega :: Int -> [t] -> [t]
pega 0 _ = []
pega n (a:x) = a : pega (n-1) x

derruba :: Int -> [t] -> [t]
derruba 0 l = l
derruba n (a:x) = derruba (n-1) x


pegaEnquanto :: (t->Bool) -> [t] -> [t]
pegaEnquanto f [] = []
pegaEnquanto f (a:x)
		|  f a = a:pegaEnquanto f x
		| otherwise = []

--derrubaEnquanto :: (t->Bool) -> [t] -> [t]
--derrubaEnquanto p (a:X)
--		| p a = derrubaEnquanto p x
--		| otherwise = a:x
