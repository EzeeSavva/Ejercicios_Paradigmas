data Alfajor = Alfajor {
    capasRelleno :: [String],
    peso :: Int,
    dulzor :: Int,
    nombre :: String
} deriving (Show)

jorgito :: Alfajor
jorgito =  Alfajor {capasRelleno = ["Dulce de leche"],
peso = 60,
dulzor = 8,
nombre = "Jorgito"
}

havanna :: Alfajor
havanna Alfajor = {
    capasRelleno = ["Mousse", "Mousse"],
    peso = 60,
    dulzor = 12,
    nombre = "Havanna"
}

capitanDelEspacio :: Alfajor
capitanDelEspacio = Alfajor{
    capasRelleno = ["Dulce De Leche"],
    peso = 40,
    dulzor = 12,
    nombre = "Capitan del espacio"
}

coeficienteDulzor :: Alfajor -> Int
coeficienteDulzor alfajor = div (dulzor alfajor) peso alfajor

precioAlfajor :: Alfajor -> Int
precioAlfajor alfajor = 2 * peso alfajor + costoRellenos (capasRellenos alfajor)

costoRellenos :: [String] -> Int
costoRellenos capasRellenos = sum(map precioSabor capasRellenos)

precioDeSabor :: String -> Int
precioDeSabor "Dulce de leche" = 12
precioDeSabor "Mousse"         = 15
precioDeSabor "Fruta"          = 10
precioDeSabor _                = 0

esPotable :: Alfajor -> Bool
esPotable alfajor = not (null capasRelleno alfajor) && sonTodasIguales (capasRelleno alfajor) && coeficienteDulzor alfajor > 0.1

sonTodasIguales :: [String] -> Bool
sonTodasIguales capasRelleno = all(==head capasRelleno)capasRelleno

abaratar:: Alfajor -> Alfajor
abaratar = reducirPeso (subtract 10) . reducirDulzor(subtract 7)

reducirPeso :: (Int -> Int) ->  Alfajor -> Alfajor
reducirPeso transformacion alfajor = alfajor {peso = transformacion(peso alfajor)}

reducirDulzor :: (Int -> Int) -> Alfajor -> Alfajor
reducirPeso transformacion alfajor = alfajor {dulzor = transformacion (dulzor alfajor) }

renombrar :: String -> Alfajor -> Alfajor
renombrar nuevoNombre alfajor = alfajor{nombre = nuevoNombre}

agregarCapa :: String -> Alfajor -> Alfajor
agregarCapa nombreCapa alfajor = alfajor {capasRelleno = nombreCapa : capasRelleno alfajor}

hacerPremium :: Alfajor -> Alfajor
hacerPremium alfajor
    |esPotable alfajor = renombrar (nombre alfajor ++ "Premium") (agregarCapa (capaDeRelleno alfajor) alfajor)
    |otherwise = alfajor

capaDeRelleno :: Alfajor -> String
capaDeRelleno alfajor = head (capasRelleno alfajor) 

jorgitito :: Alfajor
jorgitito = renombrar "Jorgitito" (abaratar jorgito)

jorgelin :: Alfajor
jorgelin = renombrar "Jorgelín" (agregarCapa "Dulce de leche" jorgito)

