data Animal = Animal{
    iq :: Int,
    especie :: String,
    capacidades :: [String]
} deriving (Eq, Show)

elefante :: Animal
elefante = Animal{
    iq = 50,
    especie = "Mamifero",
    capacidades = ["Tirar agua por la trompa"]
}

raton :: Animal
raton = Animal {
    iq = 17,
    especie = "Roedor",
    capacidades = ["Destruengloir el mundo", "Hacer planes desalmados"] 
}

inteligenciaSuperior :: Int -> Animal -> Animal
inteligenciaSuperior n animal = animal {iq = iq animal + n}

pinkificar :: Animal -> Animal
pinkificar animal = animal {capacidades = []}

superpoderes :: Animal -> Animal
superpoderes animal
    |especie animal == "Mamifero" && iq animal == iq elefante = agregarCapacidad "No tenerle miedo a los ratones" animal
    |especie animal == "Roedor" && iq animal >= 100   = agregarCapacidad "Hablar" animal
    |otherwise = animal

agregarCapacidad :: String -> Animal-> Animal
agregarCapacidad capacidad animal = animal {capacidades = capacidades animal ++ [capacidad]}

antropomorfico :: Animal -> Bool
antropomorfico animal = "Hablar" `elem` capacidades animal && iq animal > 60

noTanCuerdo :: Animal -> Bool
noTanCuerdo animal = length (filter pinkiesko (capacidades animal)) > 2

pinkiesko :: String -> Bool
pinkiesko habilidad = take 6 habilidad == "Hacer " && palabraPinkiesca (drop 6 habilidad) 

palabraPinkiesca :: String -> Bool
palabraPinkiesca palabra = length palabra <= 4 && any (`elem` "aeiouAEIOU") palabra

type Experimento = ([Animal -> Animal], Animal -> Bool)

experimentoExitoso :: Experimento -> Animal -> Bool
experimentoExitoso (trsf, criterio) animal = criterio (aplicarTransformaciones trsf animal)

aplicarExperimento :: Experimento -> Animal -> Animal
aplicarExperimento (transformacion, _)  = aplicarTransformaciones transformacion 

aplicarTransformaciones :: [Animal -> Animal] -> Animal -> Animal
aplicarTransformaciones transformaciones animal = foldl (\a f -> f a) animal transformaciones

{-EXPLICACION DEL FOLDL 
(\a f -> f a)
a = animal, f = subirIQ → resultado: subirIQ animal
a = resultado anterior, f = hacerHablar → resultado: hacerHablar (subirIQ animal)

El foldl necesita tres cosas:
Una función que combine (por ejemplo, aplicar transformaciones).
Un valor inicial (en tu caso, un Animal de entrada).
Una lista con la que va a ir aplicando la función (la lista de transformaciones)
-}

iqsConAlgunaCapacidad :: [Animal] -> [String] -> Experimento -> [Int]
iqsConAlgunaCapacidad animales caps experimento =
  map iq (filter (tieneAlgunaCapacidad caps . aplicarExperimento experimento) animales)

tieneAlgunaCapacidad :: [String] -> Animal -> Bool
tieneAlgunaCapacidad caps animal = any (`elem` capacidades animal) caps

especiesConTodasLasCapacidades :: [Animal] -> [String] -> Experimento -> [String]
especiesConTodasLasCapacidades animales caps experimento =
  map especie (filter (tieneTodasLasCapacidades caps . aplicarExperimento experimento) animales)

tieneTodasLasCapacidades :: [String] -> Animal -> Bool
tieneTodasLasCapacidades caps animal = all (`elem` capacidades animal) caps

cantidadesSinNingunaCapacidad :: [Animal] -> [String] -> Experimento -> [Int]
cantidadesSinNingunaCapacidad animales caps experimento =
  map (length . capacidades) (filter (sinNingunaCapacidad caps . aplicarExperimento experimento) animales)

sinNingunaCapacidad :: [String] -> Animal -> Bool
sinNingunaCapacidad caps animal = all (`notElem` capacidades animal) caps

