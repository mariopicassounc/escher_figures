module Dibujos.Escher (
    escherConf
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

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = 
                        apilar  1 2 (juntar 1 2 p (juntar 1 1 q r))
                                    (apilar 1 1 (juntar 1 2 s (juntar 1 1 t u)) (juntar 1 2 v (juntar 1 1 w x)))

--above(1,2,beside(1,2,p,beside(1,1,q,r)),
--above(1,1,beside(1,2,s,beside(1,1,t,u)),
--beside(1,2,v,beside(1,1,w,x))))

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n f = noneto p q r s t u v w x
    where
    p = (esquina n (figura f)) 
    q = (lado n (figura f)) 
    r = (r270 (esquina n (figura f)))
    s = (rotar (lado n (figura f)))
    t = dibujoU (figura f)
    u = (r270(lado n (figura f)))
    v = (rotar (esquina n (figura f)))
    w = (r180 (lado n (figura f)))
    x = (r180 (esquina n (figura f)))

interpBas :: Output Escher
interpBas False a b c = Blank
interpBas True a b c = pictures [line $ triangulo a b c, cara a b c]
  where
      triangulo a b c = map (a V.+) [zero, c, b, zero]
      cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)

escherConf :: Conf
escherConf = Conf {
    name = "Escher",
    pic = interp interpBas (escher 5 True)
}