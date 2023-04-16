module Dibujos.Escher (
    -- escherConf
) where

import Dibujo (figura, encimar, encimar4, cuarteto, rotar, Dibujo, rot45, r270, r180, espejar, juntar, apilar)
import Interp (interp, Conf(..))
import Grilla (grilla)
import FloatingPic (Output, zero, half)
import Graphics.Gloss (pictures, Picture (Blank), line, polygon)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

-- Supongamos que eligen.
type Escher = Bool

blank :: Dibujo Escher 
blank = figura False

-- El dibujoU.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar4 p'
    where
        p' = (espejar (rot45 p))

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar p (encimar p'(r270 p'))
    where
        p' = (espejar (rot45 p))

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 0 p = cuarteto blank blank blank (dibujoU p)
esquina n p = cuarteto (esquina (n-1) p) (lado (n-1) p) (rotar(lado (n-1) p)) (dibujoU p)

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 p = cuarteto blank blank (rotar (dibujoT p)) (dibujoT p)
lado n p = cuarteto (lado(n-1) p) (lado(n-1) p) (rotar (dibujoT p)) (dibujoT p)