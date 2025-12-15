data Persona = UnaPersona String Float Int [(String,Int)] deriving(Show)

nico :: Persona
nico = UnaPersona "Nico" 100.0 30 [("amuleto", 3), ("manos magicas",100)]

maiu :: Persona
maiu = UnaPersona "Maiu" 100.0 42 [("inteligencia",55), ("paciencia",50)]

suerteTotal :: Persona -> Int
suerteTotal (UnaPersona _ _ suerte amuletos)
    |null amuletos = suerte 
    |length amuletos == 1 = suerte 
    |otherwise = suerte

