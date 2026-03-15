import Text.Read.Lex (Number)

data Nota = Nota{
    tono :: Int,
    volumen :: Int,
    duracion :: Number
}deriving (Eq, Show)

type Cancion = [Nota]

cambiarVolumen :: (Int -> Int) -> Nota -> Nota
cambiarVolumen funcion nota = nota{ volumen = funcion (volumen nota)}

cambiarTono :: (Int -> Int) -> Nota -> Nota
cambiarTono funcion nota = nota{ tono = funcion (tono nota)}

esAudible :: Nota -> Bool
esAudible nota = ((>=20) (tono nota) && (<=20000) (tono nota)) && (> 10) (volumen nota)

esMolesta :: Nota -> Bool
esMolesta nota = esAudible nota && estaEnElRango nota

estaEnElRango ::  Nota -> Bool
estaEnElRango nota
    |tono nota < 250 = volumen nota > 85
    |tono nota >= 250 = volumen nota > 55
    |otherwise = False

silencioTotal :: Cancion -> Int
silencioTotal cancion = sum(map duracion (filter (not . esAudible)cancion))

{-
silencioTotal :: Cancion -> Int
silencioTotal cancion = sum (map (\nota -> duracion nota) (filter (\nota -> not (esAudible nota)) cancion))
-}


{-silencioTotal :: Cancion -> Int
silencioTotal cancion = (sum . map duracion . noSonAudibles) (cancion)

noSonAudibles :: Cancion -> Cancion
noSonAudibles cancion = filter(\nota -> not esAudible nota cancion)
-}


sinInterrupciones :: Cancion -> Bool
sinInterrupciones cancion = all(\nota -> duracion nota > 0.1 )(filter(esAudible) cancion)

peorMomento:: Cancion -> Int
peorMomento cancion = maximum (volumenesMolestos cancion)


volumenesMolestos:: Cancion -> [Int]
volumenesMolestos cancion = map volumen (filter(\nota->esMolesta nota)cancion)

type Filtro = Cancion -> Cancion

trasponer :: Int -> Filtro
trasponer numero cancion = map(cambiarTono(*numero)) cancion

acotarVolumen :: Int -> Int -> Filtro
acotarVolumen maximo minimo cancion = map(cambiarVolumen(min maximo) . cambiarVolumen(max minimo))cancion

normalizar :: Filtro
normalizar cancion = map (cambiarVolumen (\_ -> promedio (map volumen cancion))) cancion

promedio :: [Int] -> Int
promedio lista = sum lista `div` length lista

notasMolestas :: Cancion -> Cancion
notasMolestas cancion = filter esMolesta cancion

