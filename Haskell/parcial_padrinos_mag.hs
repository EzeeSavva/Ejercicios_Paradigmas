data Chico = Chico{
    nombre :: String,
    edad :: Int,
    habilidades :: [String],
    deseos :: [Deseo]
}

type Deseo = Chico -> Chico

aprenderHabilidades :: [String] -> Chico -> Chico
aprenderHabilidades habilidad unChico = unChico {habilidades = habilidades unChico ++ habilidad}

serGroso :: Chico -> Chico
serGroso  = aprenderHabilidades habilidadesNeedForSpeed

habilidadesNeedForSpeed :: [String]
habilidadesNeedForSpeed = map (\n -> "jugar need for speed " ++ show n) [1..]

serMayor :: Deseo
serMayor unChico = unChico {edad = 18}

wanda :: Chico -> Chico
wanda unChico = cumplirDeseo (head (deseos unChico)) (cambiarEdad (+1) unChico)

cumplirDeseo :: Deseo -> Chico -> Chico
cumplirDeseo deseos  = deseos

cosmo :: Chico -> Chico
cosmo  = cambiarEdad (\t -> div t 2)

muffinMagico :: Chico -> Chico
muffinMagico unChico = foldr ($) unChico (deseos unChico)

cambiarEdad :: (Int -> Int) -> Chico -> Chico
cambiarEdad f unChico = unChico  {edad = f (edad unChico)}

tieneHabilidad :: String -> Chico -> Bool
tieneHabilidad habilidad unChico = habilidad `elem` habilidades unChico

esSuperMaduro :: Chico ->  Bool
esSuperMaduro unChico  = edad unChico > 18 &&  tieneHabilidad "Sabe manejar" unChico

data Chica = Chica{
    nombreChica :: String,
    condicion :: Chico -> Bool
}

noEsTimmy :: String -> Bool
noEsTimmy nombrechico = nombrechico /= "Timmy Turner"

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA chica [pretendiente] = pretendiente  -- último si es el único
quienConquistaA chica (pretendiente:resto)
  | condicion chica pretendiente = pretendiente
  | otherwise = quienConquistaA chica resto


pepe :: Chico
pepe = Chico {
    nombre = "Pepe",
    edad = 20,
    habilidades = ["Sabe cocinar", "Canta"],
    deseos = []
}

juan :: Chico
juan = Chico {
    nombre = "Juan",
    edad = 18,
    habilidades = ["Baila"],
    deseos = []
}

tomas :: Chico
tomas = Chico {
    nombre = "Tomás",
    edad = 22,
    habilidades = ["Sabe manejar"],
    deseos = []
}

lucia :: Chica
lucia = Chica {
    nombreChica = "Lucía",
    condicion = tieneHabilidad "Sabe cocinar"
}

--nombre (quienConquistaA lucia [juan, tomas, pepe])
--"Pepe"

habilidadesProhibidas :: [String]
habilidadesProhibidas = ["enamorar", "matar", "dominar el mundo"]

deseoProhibido :: Deseo -> Chico -> Bool
deseoProhibido deseo chico = any (`elem` habilidadesProhibidas) (take 5 (habilidades (deseo chico)))

tieneDeseoProhibido :: Chico -> Bool
tieneDeseoProhibido chico = any (`deseoProhibido` chico) (deseos chico)

infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules = map nombre . filter tieneDeseoProhibido

--Funciones de orden superior filter, map, any, elem
--Composicion : map nombre . filter tieneDeseoProhibido
-- Aplicacion parcial any elem prohibidas, map nombre, filter tieneDeseoProhibido

