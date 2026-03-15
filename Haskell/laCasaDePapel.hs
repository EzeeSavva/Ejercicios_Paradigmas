data Rehen = Rehen{
    nombreRehen :: String,
    nivelComplot :: Int,
    nivelMiedo :: Int,
    plan :: [String]
}deriving (Show)

data Ladron = Ladron{
    nombre :: String,
    habilidades :: [String],
    armas :: [Arma]
}deriving (Show, Eq)



type Arma = Rehen -> Rehen

tokio :: Ladron
tokio = Ladron "Tokio" ["Atraco", "Fuga"] [pistola 9, ametralladora 30]



pistola :: Int -> Arma
pistola calibre rehen = (cambiarNivelComplot(subtract(5* calibre)) . cambiarMiedo(+ (3* cantidadLetrasNombre rehen)))rehen

cambiarNivelComplot :: (Int-> Int) -> Rehen -> Rehen
cambiarNivelComplot funcion rehen = rehen {nivelComplot = funcion(nivelComplot rehen)}

cambiarMiedo :: (Int-> Int) -> Rehen -> Rehen
cambiarMiedo funcion rehen = rehen {nivelMiedo = funcion(nivelMiedo rehen)}

cantidadLetrasNombre :: Rehen -> Int
cantidadLetrasNombre = length . nombreRehen  

ametralladora::Int -> Arma
ametralladora balas rehen = (cambiarNivelComplot(`div` 2). cambiarMiedo(+(balas))) rehen

armaMasIntimidante :: Ladron -> Rehen -> Arma
armaMasIntimidante ladron rehen = max(miedoQueGenera rehen) (armas ladron)

miedoQueGenera :: Rehen -> Arma -> Int
miedoQueGenera rehen arma = nivelMiedo (arma rehen)

disparosAlTecho :: Ladron -> Rehen -> Rehen
disparosAlTecho ladron rehen = (armaMasIntimidante ladron rehen) rehen



