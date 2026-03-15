-- === DEFINICIONES DE TIPOS ===
type Ingrediente = String 
data Hamburguesa = Hamburguesa {nombreHamburguesa :: String, ingredientes :: [Ingrediente]} deriving (Show)
data Bebida = Bebida {nombreBebida :: String, tamanioBebida :: Int, light :: Bool} deriving (Show)
type Acompaniamiento = String 
type Combo = (Hamburguesa, Bebida, Acompaniamiento)

-- === SELECTORES DE TUPLA ===
hamburguesa (h,_,_) = h 
bebida (_,b,_) = b 
acompaniamiento (_,_,a) = a 

-- === DATOS ===
informacionNutricional :: [(Ingrediente, Int)]
informacionNutricional = [
    ("Carne", 250), ("Queso", 50), ("Pan", 20), ("Panceta", 541),
    ("Lechuga", 5), ("Tomate", 6), ("Mayonesa", 0), ("Ketchup", 0) -- Agregué estos para que no rompa
    ]

condimentos = ["Barbacoa","Mostaza","Mayonesa","Salsa big mac","Ketchup"] 

cocaCola = Bebida "Coca Cola" 2 False 
qyb = Hamburguesa "QyB" ["Pan", "Carne", "Queso", "Panceta", "Mayonesa", "Ketchup", "Pan"] 
comboQyB = (qyb, cocaCola, "Papas") 

-- === LÓGICA DE CALORÍAS ===
cantidadCaloriasIngrediente :: Ingrediente -> Int
cantidadCaloriasIngrediente nombreBuscado = snd (head (filter (\(nombre, _) -> nombre == nombreBuscado) informacionNutricional))

esUnaBomba :: Hamburguesa -> Bool
esUnaBomba h = any (>300) cals || sum cals > 1000
    where cals = map cantidadCaloriasIngrediente (ingredientes h)

-- === CONDICIONES MORTALES ===
noEsDietetica :: Bebida -> Bool
noEsDietetica = not . light

noEsEnsalada :: Acompaniamiento -> Bool
noEsEnsalada acomp = acomp /= "Ensalada"

esMortal :: Combo -> Bool
esMortal (h,b,a) = (noEsDietetica b && noEsEnsalada a) || esUnaBomba h

-- === TRANSFORMACIONES DEL COMBO ===
agrandarBebida :: Combo -> Combo
agrandarBebida (h,b,a) = (h, incrementarTamanio (+1) b, a)

incrementarTamanio :: (Int -> Int) -> Bebida -> Bebida
incrementarTamanio f b = b { tamanioBebida = f (tamanioBebida b) }

cambiarAcompaniamientoPor :: Acompaniamiento -> Combo -> Combo
cambiarAcompaniamientoPor nuevo (h,b,_) = (h, b, nuevo)

-- === EL PUNTO CLAVE: peroSin GENÉRICO ===
-- Acá corregí tu código para que 'condicion' se use de verdad
peroSin :: (Ingrediente -> Bool) -> Combo -> Combo
peroSin condicion (h,b,a) = (h { ingredientes = filter (not . condicion) (ingredientes h) }, b, a)

-- === FUNCIONES DE APOYO PARA ALTERACIONES ===
esCondimento :: Ingrediente -> Bool
esCondimento i = i `elem` condimentos

masCaloricoQue :: Int -> Ingrediente -> Bool
masCaloricoQue limite i = cantidadCaloriasIngrediente i > limite

-- === LISTA DE ALTERACIONES Y CONSULTA FINAL ===
alteraciones :: [Combo -> Combo]
alteraciones = [
    agrandarBebida, 
    cambiarAcompaniamientoPor "Ensalada", 
    peroSin esCondimento, 
    peroSin (masCaloricoQue 400), 
    peroSin (== "Queso")
    ]

