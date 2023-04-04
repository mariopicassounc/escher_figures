{-# LANGUAGE LambdaCase #-}

module Dibujo (
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
    ) 
where
    
data Dibujo a = Figura a
    | Rotar (Dibujo a) 
    | Espejar (Dibujo a) 
    | Rot45 (Dibujo a)
    | Apilar Float Float (Dibujo a) (Dibujo a) 
    | Juntar Float Float (Dibujo a) (Dibujo a) 
    | Encimar (Dibujo a) (Dibujo a)     
    deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones

-- Composicion n-veces de una funcion con si misma
comp :: (a -> a) -> Int -> a -> a
comp f n d
    |n <= 0 = d
    |n > 0 = comp f (n-1) $ f d

-- Construcción de dibujo. Abstraen los constructores.
  
figura :: a -> Dibujo a 
figura d =  Figura d

rotar :: Dibujo a -> Dibujo a
rotar d = Rotar d

espejar :: Dibujo a -> Dibujo a
espejar d = Espejar d

rot45 :: Dibujo a -> Dibujo a 
rot45 d = Rot45 d 

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a 
apilar x y d1 d2 = Apilar x y d1 d2

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a 
juntar x y d1 d2 = Juntar x y d1 d2 

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar d1 d2 = Encimar d1 d2


-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 d = comp Rotar 2 d

r270 :: Dibujo a -> Dibujo a
r270 d = comp Rotar 3 d

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.):: Dibujo a -> Dibujo a -> Dibujo a 
(.-.) d1 d2 = Apilar 1 1 d1 d2 

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) d1 d2 = Juntar 1 1 d1 d2

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a 
(^^^) d1 d2 = Juntar 1 1 d1 d2

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a 
cuarteto d1 d2 d3 d4 = (d1 /// d2) .-. (d3 /// d4)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 d = d ^^^ rot45 d ^^^ r180 d ^^^ r270 d

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar d = cuarteto d (rotar d) (r180 d) (r270 d)


-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib fig rot esp r45 ap jun enc dibujo = case dibujo of
    Figura f -> fig f
    Rotar d -> rot (foldDib fig rot esp r45 ap jun enc d)
    Espejar d -> esp (foldDib fig rot esp r45 ap jun enc d)
    Rot45 d -> r45 (foldDib fig rot esp r45 ap jun enc d)
    Apilar x y d1 d2 -> ap x y (foldDib fig rot esp r45 ap jun enc d1) (foldDib fig rot esp r45 ap jun enc d2)
    Juntar x y d1 d2 -> jun x y (foldDib fig rot esp r45 ap jun enc d1) (foldDib fig rot esp r45 ap jun enc d2)
    Encimar d1 d2 -> enc (foldDib fig rot esp r45 ap jun enc d1) (foldDib fig rot esp r45 ap jun enc d2)


-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib f (Figura fig) = f fig
mapDib f (Rotar d) = Rotar (mapDib f d)
mapDib f (Espejar d) = Espejar (mapDib f d)
mapDib f (Rot45 d) = Rot45 (mapDib f d)
mapDib f (Apilar x y d1 d2) = Apilar x y (mapDib f d1) (mapDib f d2)
mapDib f (Juntar x y d1 d2) = Juntar x y (mapDib f d1) (mapDib f d2)
mapDib f (Encimar d1 d2) = Encimar (mapDib f d1) (mapDib f d2)


-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [Dibujo a]
figuras (Figura f) = [Figura f]
figuras (Rotar d) = figuras d
figuras (Espejar d) = figuras d
figuras (Rot45 d) = figuras d
figuras (Apilar _ _ d1 d2) = figuras d1 ++ figuras d2
figuras (Juntar _ _ d1 d2) = figuras d1 ++ figuras d2
figuras (Encimar d1 d2) = figuras d1 ++ figuras d2
