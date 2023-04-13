module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

-- Utilizamos la librería de Gloss para dibujar
import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)

-- Utilizamos la librería de Vectores para hacer operaciones con vectores
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid, half, zero)

-- Interpretacion de dibujo 
interp :: Output a -> Output (Dibujo a)
interp interpBas = foldDib interpBas interpRot interpEspejar interpRot45 interpApilar interpJuntar interpEncimar

interpRot :: FloatingPic -> FloatingPic
interpRot f x w h = f (x V.+ w) h (zero V.- w)

interpEspejar :: FloatingPic -> FloatingPic
interpEspejar f x w = f (x V.+ w) (zero V.- w)

interpRot45 :: FloatingPic -> FloatingPic
interpRot45 f x w h = f (x V.+ half (w V.+ h)) (half (w V.+ h)) (half (h V.- w))

interpApilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpApilar n m f g x w h = pictures [f (x V.+ h') w (r V.* h), g x w h']
    where
        r' = n / (m + n)
        r = m / (m + n)
        h' = r' V.* h

interpJuntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpJuntar n m f g x w h = pictures [f x w' h, g (x V.+ w') (r' V.* w) h]
    where
      r' = n / (m + n)
      r = m / (m + n)
      w' = r V.* w

interpEncimar :: FloatingPic -> FloatingPic -> FloatingPic
interpEncimar f g x w h = pictures [f x w h, g x w h]

-- Configuración de la interpretación
data Conf = Conf {
        name :: String,
        pic :: FloatingPic
    }

interpConf :: Conf -> Float -> Float -> Picture 
interpConf (Conf _ p) x y = p (0, 0) (x,0) (0,y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (interpConf cfg size size) size size
  where withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
        grey = makeColorI 120 120 120 120