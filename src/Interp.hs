module Interp (
    interp,
    Conf(..),
    inter_conf,
    initial
) where


-- Utilizamos la librería de Gloss para dibujar
import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)

-- Utilizamos la librería de Vectores para hacer operaciones con vectores
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid, half, zero)


-- Interpretación de un dibujo
-- formulas sacadas del enunciado

-- interp será una función que recibe la interpretación de una figura básica
-- y devuelve una función que toma dibujos y devuelve floatingPics
interp :: Output a -> Output (Dibujo a)
interp inter_bas = foldDib inter_bas inter_rot inter_espejar inter_rot45 inter_apilar inter_juntar inter_encimar

inter_rot :: FloatingPic -> FloatingPic
inter_rot f x w h = f (x V.+ w) h (zero V.- w)

inter_espejar :: FloatingPic -> FloatingPic
inter_espejar f x w = f (x V.+ w) (zero V.- w)

inter_rot45 :: FloatingPic -> FloatingPic
inter_rot45 f x w h = f (x V.+ half (w V.+ h)) (half (w V.+ h)) (half (h V.- w))

inter_apilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
inter_apilar n m f g x w h = pictures [f (x V.+ h') w (r V.* h), g x w h']
    where
        r' = n / (m + n)
        r = m / (m + n)
        h' = r' V.* h

inter_juntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
inter_juntar n m f g x w h = pictures [f x w' h, g (x V.+ w') (r' V.* w) h]
    where
      r' = n / (m + n)
      r = m / (m + n)
      w' = r V.* w

inter_encimar :: FloatingPic -> FloatingPic -> FloatingPic
inter_encimar f g x w h = pictures [f x w h, g x w h]

-- Configuración de la interpretación
data Conf = Conf {
        name :: String,
        pic :: FloatingPic
    }

inter_conf :: Conf -> Float -> Float -> Picture 
inter_conf (Conf _ p) x y = p (0, 0) (x,0) (0,y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (inter_conf cfg size size) size size
  where withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
        grey = makeColorI 120 120 120 120