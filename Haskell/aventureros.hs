import Distribution.Simple.Setup (trueArg)
import Utils.Containers.Internal.BitUtil (wordSize)
type Encuentro = Aventurero -> Aventurero

data Aventurero = Aventurero{
    nombre :: String,
    carga :: Int,
    salud :: Int,
    coraje :: Bool,
    criterioSeleccion :: Criterio
}deriving (Show)

type Criterio = Aventurero -> Bool

conformista :: Criterio
conformista _ = True

valiente :: Criterio
valiente aventurero = coraje aventurero || salud aventurero > 50

lightPacker :: Int ->  Criterio
lightPacker valorUmbral aventurero = carga aventurero < valorUmbral

aventurero5Letras :: Aventurero -> Bool
aventurero5Letras aventurero = length (nombre aventurero) > 5

sumarCargaTotal :: [Aventurero] -> Int
sumarCargaTotal aventureros = (sum . filter even .map carga) aventureros

type Personaje = Encuentro

-- Usamos el punto para encadenar las acciones
curandero :: Personaje
curandero = quitarKilo . cambiarCarga (`div` 2) . curar20Porciento

--curandero aventurero = quitarKilo (cambiarCarga (`div` 2) (curar20Porciento aventurero))

inspirador :: Personaje
inspirador = darCoraje . curar10Porciento

cambiarCarga :: (Int -> Int) -> Aventurero -> Aventurero
cambiarCarga funcion aventurero = aventurero{carga = funcion(carga aventurero)}

quitarKilo :: Aventurero -> Aventurero
quitarKilo aventurero = cambiarCarga(subtract(1)) aventurero

cambiarSalud:: (Int -> Int) -> Aventurero -> Aventurero
cambiarSalud funcion aventurero = aventurero{salud =  funcion (salud aventurero)}


darCoraje :: Aventurero -> Aventurero
darCoraje aventurero = aventurero{coraje = True}


sanar :: Int -> Int -> Int
sanar puntos saludActual = min 100 (saludActual + puntos)

curar20Porciento :: Aventurero -> Aventurero
curar20Porciento = cambiarSalud (sanar 20)

--curar20Porciento aventurero = modificarSalud (\salud -> min 100 (salud + (salud * 20 `div` 100))) aventurero

curar10Porciento :: Aventurero -> Aventurero
curar10Porciento a = cambiarSalud (sanar (salud a * 10 `div` 100)) a


