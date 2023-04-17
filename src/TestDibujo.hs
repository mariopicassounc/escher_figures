import Test.HUnit
import Dibujo

-- Test para los constructores de Dibujo
constructoresTest = TestList
    [ "Test figura" ~: (show $ figura 1) ~?= "Figura 1"
    , "Test rotar" ~: (show $ rotar $ figura 1) ~?= "Rotar (Figura 1)"
    , "Test espejar" ~: (show $ espejar $ figura 1) ~?= "Espejar (Figura 1)"
    , "Test rot45" ~: (show $ rot45 $ figura 1) ~?= "Rot45 (Figura 1)"
    , "Test apilar" ~: (show $ apilar 1 1 (figura 1) (figura 2)) ~?= "Apilar 1.0 1.0 (Figura 1) (Figura 2)"
    , "Test juntar" ~: (show $ juntar 1 1 (figura 1) (figura 2)) ~?= "Juntar 1.0 1.0 (Figura 1) (Figura 2)"
    , "Test encimar" ~: (show $ encimar (figura 1) (figura 2)) ~?= "Encimar (Figura 1) (Figura 2)"
    ]

-- Test para las funciones de composicion
funcionesTest = TestList
    [ "Test r180" ~: (show $ r180 (figura 1)) ~?= "Rotar (Rotar (Figura 1))"
    , "Test r270" ~: (show $ r270 (figura 1)) ~?= "Rotar (Rotar (Rotar (Figura 1)))"
    , "Test (.-.)" ~: (show $ (figura 1) .-. (figura 2)) ~?= "Apilar 1.0 1.0 (Figura 1) (Figura 2)"
    , "Test (///)" ~: (show $ (figura 1) /// (figura 2)) ~?= "Juntar 1.0 1.0 (Figura 1) (Figura 2)"
    , "Test (^^^)" ~: (show $ (figura 1) ^^^ (figura 2)) ~?= "Encimar (Figura 1) (Figura 2)"
    , "Test cuarteto" ~: (show $ cuarteto (figura 1) (figura 2) (figura 3) (figura 4)) ~?= "Apilar 1.0 1.0 (Juntar 1.0 1.0 (Figura 1) (Figura 2)) (Juntar 1.0 1.0 (Figura 3) (Figura 4))"
    , "Test encimar4" ~: (show $ encimar4 (figura 1)) ~?= "Encimar (Figura 1) (Encimar (Encimar (Rotar (Figura 1)) (Rotar (Rotar (Figura 1)))) (Rotar (Rotar (Rotar (Figura 1)))))"
    , "Test ciclar" ~: (show $ ciclar (figura 1)) ~?= "Apilar 1.0 1.0 (Juntar 1.0 1.0 (Figura 1) (Rotar (Figura 1))) (Juntar 1.0 1.0 (Rotar (Rotar (Figura 1))) (Rotar (Rotar (Rotar (Figura 1)))))"
    ]

-- definimos las funciones auxiliares y tipos necesarios para el test
data FiguraTest = CirculoTest Float | CuadradoTest Float Float deriving (Eq, Show)

type DibujoTest = Dibujo FiguraTest

-- Test para la funcion foldDib

testFoldDib = TestList
    ["Test fold con figura" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (figura 1)) ~?= "Figura 1"
    ,"Test fold rotación" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (rotar (figura (CuadradoTest 2 3)))) ~?= "Rotar (Figura (CuadradoTest 2.0 3.0))"
    ,"Test fold espejo" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (espejar (figura (CirculoTest 2)))) ~?= "Espejar (Figura (CirculoTest 2.0))"
    ,"Test fold rotación 45 grados" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (rot45 (figura (CuadradoTest 4 5)))) ~?= "Rot45 (Figura (CuadradoTest 4.0 5.0))"
    ,"Test fold apilar" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (apilar 1 2 (figura (CirculoTest 1)) (figura (CuadradoTest 2 3)))) ~?= "Apilar 1.0 2.0 (Figura (CirculoTest 1.0)) (Figura (CuadradoTest 2.0 3.0))"
    ,"Test fold juntar" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (juntar 3 4 (figura (CuadradoTest 1 2)) (figura (CirculoTest 3)))) ~?= "Juntar 3.0 4.0 (Figura (CuadradoTest 1.0 2.0)) (Figura (CirculoTest 3.0))"
    ,"Test fold encimar" ~: show (foldDib figura rotar espejar rot45 apilar juntar encimar (encimar (figura (CuadradoTest 2 2)) (figura (CirculoTest 1)))) ~?= "Encimar (Figura (CuadradoTest 2.0 2.0)) (Figura (CirculoTest 1.0))"
    ]

-- Test para la funcion mapDib
testMapDib = TestList
    ["Test mapDib con figura" ~: show (mapDib figura (figura 1)) ~?= "Figura 1"
    ,"Test mapDib rotación" ~: show (mapDib figura (rotar (figura (CuadradoTest 2 3)))) ~?= "Rotar (Figura (CuadradoTest 2.0 3.0))"
    ,"Test mapDib espejo" ~: show (mapDib figura (espejar (figura (CirculoTest 2)))) ~?= "Espejar (Figura (CirculoTest 2.0))"
    ,"Test mapDib rotación 45 grados" ~: show (mapDib figura (rot45 (figura (CuadradoTest 4 5)))) ~?= "Rot45 (Figura (CuadradoTest 4.0 5.0))"
    ,"Test mapDib apilar" ~: show (mapDib figura (apilar 1 2 (figura (CirculoTest 1)) (figura (CuadradoTest 2 3)))) ~?= "Apilar 1.0 2.0 (Figura (CirculoTest 1.0)) (Figura (CuadradoTest 2.0 3.0))"
    ,"Test mapDib juntar" ~: show (mapDib figura (juntar 3 4 (figura (CuadradoTest 1 2)) (figura (CirculoTest 3)))) ~?= "Juntar 3.0 4.0 (Figura (CuadradoTest 1.0 2.0)) (Figura (CirculoTest 3.0))"
    ,"Test mapDib encimar" ~: show (mapDib figura (encimar (figura (CuadradoTest 2 2)) (figura (CirculoTest 1)))) ~?= "Encimar (Figura (CuadradoTest 2.0 2.0)) (Figura (CirculoTest 1.0))"
    ]

-- Debido a que hay constructores con la misma estructura, como es el caso
-- Apilar y Juntar o Rotar, Rotar45 y Espejar, se puede dar que se
-- aplique la función incorrecta, por lo que podemos probar que la funciónes
-- foldDib y mapDib devuelve un valor distinto para cada llamada. Consultar...

-- Para compilar con todos los módulos cargados:
main = runTestTT (TestList [constructoresTest, funcionesTest, testFoldDib, testMapDib])
