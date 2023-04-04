module Pred (
  Pred,
  cambiar, orP, andP, anyFig
) where

import Dibujo (
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
    )

data TriORect = Triangulo | Rectangulo deriving (Eq, Show)

-- `Pred a` define un predicado sobre figuras básicas. Por ejemplo,
-- `(== Triangulo)` es un `Pred TriOCuat` que devuelve `True` cuando la
-- figura es `Triangulo`.
type Pred a = a -> Bool

-- Dado un predicado sobre figuras básicas, cambiar todas las que satisfacen
-- el predicado por el resultado de llamar a la función indicada por el
-- segundo argumento con dicha figura.
-- Por ejemplo, `cambiar (== Triangulo) (\x -> Rotar (Figura x))` rota
-- todos los triángulos.
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar p f d = foldDib 
    (\x -> if p x then f x else figura x) 
    (\x -> rotar x) 
    (\x -> espejar x) 
    (\x -> rot45 x) 
    (\x y z w -> apilar x y z w) 
    (\x y z w -> juntar x y z w) 
    (\x y -> encimar x y) d

-- Alguna figura satisface el predicado.
anyFig :: Pred a -> Dibujo a -> Bool
anyFig p d = foldDib 
    (\x -> p x) 
    (id) 
    (id) 
    (id) 
    (\x y z w -> z || w) 
    (\x y z w -> z || w) 
    (\x y -> x || y) d

-- Todas las figuras satisfacen el predicado.
allFig :: Pred a -> Dibujo a -> Bool
allFig p d = foldDib 
    (\x -> p x) 
    (id) 
    (id) 
    (id) 
    (\x y z w -> z && w) 
    (\x y z w -> z && w) 
    (\x y -> x && y) d

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP p1 p2 x = p1 x && p2 x

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP p1 p2 x = p1 x || p2 x