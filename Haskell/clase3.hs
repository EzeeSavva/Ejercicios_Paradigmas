import Foreign.C (CWchar)
siguiente :: Int -> Int
siguiente x = x + 1

doble :: Int -> Int
doble unNumero = unNumero * 2

--dobleDelSiguiente :: Int -> Int
--dobleDelSiguiente numero = (doble . siguiente) numero

dobleDelSiguiente :: Int -> Int
dobleDelSiguiente = doble . siguiente
--doble (siguiente 3) => doble 4 => 8

cuadrado :: Int -> Int
cuadrado x = x * x

siguienteDobleCuadrado :: Int -> Int
siguienteDobleCuadrado = cuadrado . doble . siguiente
--El (siguiente 3) => doble 4 => cuadrado 8 == 64
--Va de la ultima funcion, hacia la izquierda <---

colonia :: [String]
colonia = ["Feli", "Pepe"]

--Funcion lambda
--(\x->x)

--Para agregar un elemento a la lista se suele usar :
-- es decir... 2 : [1,2,3]
--               | los dos puntos crean una nueva lista, con el elemento cabeza, en este caso, el 2, y devuelve una lista nueva -- [2,1,2,3] en donde el 2 es la cabeza y 
--                  la lista [1,2,3] es la cola, esto se identifica tambien con las funciones head, y tail, que son cabeza y cola. 

-- ++ sirve para concatenar dos cadenas.Applicative

-- Las tuplas son tipos de datos que pueden tener mas tipos de datos.

-- funciones de las tuplas : fst y snd ( que devuelve el primer elemento o el segundo elemento de la lista).

data Elemento = Elemento String String Int deriving (Eq,Show)
hidrogeno = Elemento "Hidrogeno" "H" 1
oxigeno = Elemento "Oxigeno" "O " 8


data Compuesto = Compuesto String [(Elemento, Int)]


-- Pattern matching--
esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal unaLetra = False

nombre :: Elemento -> String
nombre (Elemento unNombre _ _) = unNombre

--Definir constructores
data Grupo = Metal | NoMetal | GasNoble | Halogeno deriving (Eq, Show)

--Guardas
absoluto :: (Ord a, Num a) => a -> a
absoluto numero
    |numero >= 0 = numero
    |otherwise = -numero
-- para correrlo, se le parsea el numero negativo con (), es decir absoluto (-1), de lo contrario no funciona.

--Casos recursivos
factorial :: (Ord a, Num a) => a -> a
factorial n
    |n == 0  = 1 --- caso base
    |n > 0   = n * factorial(n-1) ---- caso recursivo

factorial2 :: (Eq a, Num a) => a -> a
factorial2 0 = 1   -- Caso base
factorial2 n = n * factorial2 (n - 1)  -- Recursión

--Aplicacion parcial


sumar :: Int -> Int -> Int
sumar x y = x + y

--sumar5 :: Int -> Int
--sumar5 x = sumar 5 x -- ACA LAS X SE PUEDEN BORRAR PQ ESTAN AL FINAL, ES DECIR, COMO SI FUERA ALGO MATEMATICO, LOS CANCELO DIVIDIENDO AMBOS LADOS X


{-Hacete mini desafíos de 5-10 minutos como:

doble x = x * 2

esPar x = mod x 2 == 0

sumarLista xs = foldr (+) 0 xs

soloPares xs = filter even xs

Esto te fuerza a practicar sintaxis de definiciones, funciones de orden superior y lambdas.-}

esPar :: Int -> Bool
esPar x = mod x 2 == 0
