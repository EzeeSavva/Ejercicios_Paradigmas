type Ingrediente = String 

data Hamburguesa = Hamburguesa {nombreHamburguesa :: String,
 ingredientes :: [Ingrediente]
 } 

data Bebida = Bebida {nombreBebida :: String,
 tamanioBebida :: Int,
 light :: Bool} 

type Acompaniamiento = String 

type Combo = (Hamburguesa, Bebida, Acompaniamiento)

hamburguesa :: (a, b, c) -> a
hamburguesa (h,_,_) = h
bebida :: (a, b, c) -> b
bebida (_,b,_) = b
acompaniamiento :: (a, b, c) -> c
acompaniamiento (_,_,a) = a 

informacionNutricional :: [(String, Int)]
informacionNutricional = [("Carne", 250), ("Queso", 50), ("Pan", 20), ("Panceta", 541), ("Lechuga", 5), ("Tomate", 6)]

condimentos :: [String]
condimentos = ["Barbacoa","Mostaza","Mayonesa","Salsa big mac","Ketchup"] 

cantidadCalorias :: String -> Int
cantidadCalorias ingrediente
    | elem ingrediente condimentos = 10
    | otherwise                    = buscarCalorias ingrediente

buscarCalorias :: String -> Int
buscarCalorias ingrediente = snd (head (filter (\(nombre,cal) -> nombre == ingrediente) informacionNutricional))

esMortal :: Combo -> Bool
esMortal (hamburguesa, bebida, acompaniamiento) = noEsDietetica bebida && acompaniamiento /= "Ensalada" ||  esUnaBomba hamburguesa

noEsDietetica :: Bebida -> Bool
noEsDietetica bebida = not (light bebida)

esUnaBomba :: Hamburguesa -> Bool
esUnaBomba hamburguesa = mayorA300 (ingredientes hamburguesa) || superaLas1000 (ingredientes hamburguesa)

mayorA300 :: [Ingrediente] -> Bool
mayorA300 ingredientes = any (\ingrediente -> cantidadCalorias ingrediente > 300) ingredientes

superaLas1000 :: [Ingrediente] -> Bool
superaLas1000 ingredientes = ((>1000) .sum . map cantidadCalorias) ingredientes

agrandarBebida :: Combo -> Combo
agrandarBebida (hamburguesa,bebida,acompaniamiento) = (hamburguesa, bebida{tamanioBebida = tamanioBebida bebida + 1}, acompaniamiento)

cambiarAcompaniamientoPor :: String -> Combo -> Combo
cambiarAcompaniamientoPor acompaniamientoNuevo (hamburguesa,bebida,acompaniamiento) = (hamburguesa,bebida,acompaniamientoNuevo)

peroSin :: (String -> Bool ) -> Combo -> Combo
peroSin unaFuncion (hamburguesa,bebida,acompaniamiento) = (hamburguesa{ingredientes = filter (\ingrediente-> not (unaFuncion ingrediente))(ingredientes hamburguesa)},bebida,acompaniamiento)

esCondimento ::  String -> Bool 
esCondimento ingrediente = elem ingrediente condimentos

masCaloricoQue :: Int -> String -> Bool
masCaloricoQue valorDado ingrediente = cantidadCalorias ingrediente > valorDado


