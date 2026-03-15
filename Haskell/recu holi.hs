import Control.Monad.Cont (Cont)
import Distribution.Simple.Program.HcPkg (list)
data Persona = Persona{
    nivelStress :: Int,
    nombre :: String,
    preferencias :: [String],
    cantidadAmigos :: Int
}deriving (Show)

type Contingente = [Persona]

totalStressGlotones :: Contingente -> Int
totalStressGlotones listaPersonas = (sum . map nivelStress . filter (\persona -> elem "Gastronomia" (preferencias persona))) listaPersonas

--contingenteRaro :: Contingente -> Bool
--contingenteRaro listaPersonas = all (even . cantidadAmigos) listaPersonas

contingenteRaro :: Contingente -> Bool
contingenteRaro listaPersonas = all (\persona -> even(cantidadAmigos persona)) listaPersonas

type Plan = Persona -> Persona

villaGessel :: Int -> Plan
villaGessel mes persona
    |mes == 1 || mes ==2  = cambiarStress (+10) persona
    |otherwise =  relajarse persona

cambiarStress :: (Int -> Int ) -> Persona -> Persona
cambiarStress funcion persona = persona { nivelStress = funcion(nivelStress persona)}

lasToninas :: Bool -> Plan
lasToninas conPlata persona 
    |conPlata = relajarse persona
    |otherwise = cambiarStress(+(10 * cantidadAmigos persona)) persona

relajarse :: Plan
relajarse  = cambiarStress(`div` 2) 

puertoMadryn :: Plan 
puertoMadryn persona = persona {cantidadAmigos = cantidadAmigos persona + 1}

adela :: Plan
adela = id 

z = b

x = 

y = a

g 

g = a -> b -> Bool


(a -> b -> Bool)-> (a-> a)-> a-> b -> Bool






