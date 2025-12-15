{-
req
1- colorAuto auto
2- correr auto
-}

data Auto = Auto String  Int Int deriving (Eq, Show)

type Carrera = [Auto]
auto1 = Auto "Rojo" 100 50
auto2 = Auto "Azul" 120 55
auto3 = Auto "Rojo" 100 50  -- Mismo que auto1

colorAuto :: Auto -> String
colorAuto (Auto color _ _) = color

velocidad :: Auto -> Int
velocidad (Auto _ velocidad _ ) = velocidad

distancia :: Auto -> Int
distancia (Auto _ _ distancia) = distancia

distanciaAbsoluta ::  Auto -> Int
distanciaAbsoluta = abs . distancia
--A mi me interesa el estado actual de cada auto que esta participando

estaCerca ::Auto -> Auto -> Bool
estaCerca auto1 auto2 = auto1 /= auto2 && abs (distancia auto1 - distancia auto2) < 10

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = ningunAutoCerca auto carrera && vaGanando auto carrera

ningunAutoCerca :: Auto -> Carrera -> Bool
ningunAutoCerca auto = all(\otro -> not(estaCerca auto otro) || auto == otro) 

vaGanando :: Auto -> Carrera -> Bool
vaGanando auto  = all(\otro -> (distancia auto > distancia otro) || auto == otro) 

