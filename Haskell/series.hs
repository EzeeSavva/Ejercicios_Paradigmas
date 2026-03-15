import GHC.Base (VecElem(Int16ElemRep))
data Serie = Serie{
    nombreSerie :: String,
    quienesActuan :: [Actor],
    presupuestoAnual :: Int,
    cantidadTemporadas :: Int,
    rating :: Float,
    cancelada :: Bool
}

data Actor = Actor{
    nombreActor :: String,
    sueldoPretendido :: Int,
    restricciones :: [String]
}


--1

estaEnRojo :: Serie -> Bool
estaEnRojo serie = (sum . map sueldoPretendido . quienesActuan) serie > presupuestoAnual serie


esProblematica :: Serie -> Bool
esProblematica serie = (length . filter (>1) . map (length . restricciones) . quienesActuan) serie > 3





x y 

y=[a]
map = [Int]

filter (even . X) [Int]
 

f =  (a -> Int) -> [a] -> [Int] 


