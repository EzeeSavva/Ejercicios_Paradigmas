
data Artefacto = Artefacto {
    nombre :: String,
    rareza :: Int
}deriving (Eq, Show)

data Heroe = Heroe { 
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
}

data Bestia = Bestia {
  nombreBestia :: String,
  debilidad :: Heroe -> Bool
}


type Tarea = Heroe -> Heroe

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria heroe
    | reconocimiento heroe > 1000 = registrarTarea pasarALaHistoria (cambiarEpiteto "El Mitico" heroe)
    | reconocimiento heroe >= 500 = registrarTarea pasarALaHistoria (cambiarEpiteto "El Magnifico"(agregarArtefacto (Artefacto "Lanza del Olimpo" 100) heroe))
    | reconocimiento heroe > 100  = registrarTarea pasarALaHistoria (cambiarEpiteto "Hoplita" (agregarArtefacto (Artefacto "Xiphos" 50) heroe))
    | otherwise                   = heroe

--HAGO ++ PARA NO PERDER LOS QUE YA TENIA EL HEROE, CONCATENO
--USO SINTAX RECORD

encontrarArtefacto :: Artefacto -> Heroe -> Heroe
encontrarArtefacto = agregarArtefacto 

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto a h = h {
    artefactos = artefactos h ++ [a],
    reconocimiento = reconocimiento h + rareza a
}


registrarTarea :: Tarea -> Heroe -> Heroe
registrarTarea tarea heroe = heroe { tareas = tareas heroe ++ [tarea] }

aumentarReconocimiento :: Int -> Heroe -> Heroe
aumentarReconocimiento n heroe = heroe { reconocimiento = reconocimiento heroe + n }

escalarOlimpo :: Heroe -> Heroe
escalarOlimpo = registrarTarea escalarOlimpo . desecharArtefactos . triplicarRarezas . agregarArtefacto (Artefacto "El Relampago de Zeus" 500) . aumentarReconocimiento 500 

desecharArtefactos :: Heroe -> Heroe
desecharArtefactos heroe = heroe { artefactos = filter (\a -> rareza a >= 1000) (artefactos heroe) }

triplicarRarezas :: Heroe -> Heroe
triplicarRarezas heroe = heroe { artefactos = map triplicar (artefactos heroe) }
  where triplicar art = art { rareza = rareza art * 3 }

ayudarACruzarLaCalle :: Int -> Heroe -> Heroe
ayudarACruzarLaCalle cuadras = registrarTarea (ayudarACruzarLaCalle cuadras) . cambiarEpiteto (epitetoGroso cuadras)

cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto nuevoEpiteto heroe = heroe {epiteto = nuevoEpiteto}

epitetoGroso :: Int -> String
epitetoGroso cuadras = "Gros" ++ replicate cuadras 'o'

matarBestia :: Bestia -> Heroe -> Heroe
matarBestia (Bestia nombre debilidad) heroe
    | debilidad heroe = registrarTarea (matarBestia (Bestia nombre debilidad)) (cambiarEpiteto("El asesino de " ++ nombre) heroe)
    | otherwise = registrarTarea(matarBestia(Bestia nombre debilidad))(cambiarEpiteto "El Cobarde"(perderPrimerArtefacto heroe))

perderPrimerArtefacto :: Heroe -> Heroe
perderPrimerArtefacto heroe = heroe { artefactos = drop 1 (artefactos heroe) }

heracles :: Heroe
heracles = Heroe {
    epiteto = "Guardian del Olimpo",
    reconocimiento = 700,
    artefactos = [Artefacto "Pistola " 1000, Artefacto "Relampago de Zeus" 500],
    tareas = []
}

leonNemea :: Bestia
leonNemea = Bestia {
    nombreBestia = "Leon De Nemea",
    debilidad = \heroe -> length (epiteto heroe) >=20
}

matarLeonNemea :: Bestia -> Heroe -> Heroe
matarLeonNemea bestia = matarBestia leonNemea

hacerTarea :: Tarea -> Heroe -> Heroe
hacerTarea = registrarTarea 

presumir :: Heroe -> Heroe -> (Heroe, Heroe)
presumir heroe1 heroe2
    | reconocimiento heroe1 > reconocimiento heroe2 = (heroe1, heroe2)
    | reconocimiento heroe2 > reconocimiento heroe1 = (heroe2, heroe1)
    | rarezaTotal heroe1 > rarezaTotal heroe2       = (heroe1, heroe2)
    | rarezaTotal heroe2 > rarezaTotal heroe1       = (heroe2, heroe1)
    | otherwise = presumir (realizarTareasDe heroe2 heroe1) (realizarTareasDe heroe1 heroe2)

rarezaTotal :: Heroe -> Int
rarezaTotal = sum . map rareza . artefactos

realizarTareasDe :: Heroe -> Heroe -> Heroe
realizarTareasDe otro heroe = foldl (flip ($)) heroe (tareas otro)

--No hay resultado definido: la comparación entra en loop infinito, porque no hay nada que modifique a los héroes ni corte el ciclo.

type Labor = [Heroe -> Heroe]
realizarLabor :: Labor -> Heroe -> Heroe
realizarLabor labor heroe = foldl (\h tarea -> tarea h) heroe labor

