import Test.HUnit
import Pred
import Dibujo

-- Para compilar con todos los módulos cargados:
-- Primero, situarse en ../src ; luego ejecutar:
-- ghci -package HUnit Tests/TestPred.hs Pred.hs Dibujo.hs

cambiarTests = TestList [
    "Test 1a cambiar" ~: cambiar (==2) (\x -> rotar (figura x)) (figura 1) ~?= figura 1,
    "Test 1b cambiar" ~: cambiar (==1) (\x -> rotar (figura x)) (figura 1) ~?= rotar (figura 1),
    "Test 2a cambiar" ~: cambiar (==1) (\x -> rotar (figura x)) (apilar 1 1 (figura 1) (figura 2)) ~?= apilar 1 1 (rotar (figura 1)) (figura 2),
    "Test 2b cambiar" ~: cambiar (==1) (\x -> rotar (figura x)) (apilar 1 1 (figura 2) (figura 1)) ~?= apilar 1 1 (figura 2) (rotar (figura 1)) 
    ]

anyFigTests = TestList [
   "Test 1a anyFIg" ~: anyFig (==1) (figura 1) ~?= True,
   "Test 1b anyFig" ~: anyFig (==1) (figura 2) ~?= False,
   "Test 2a anyFig" ~: anyFig (==1) (apilar 1 1 (figura 1) (figura 2)) ~?= True,
   "Test 2b anyFig" ~: anyFig (==1) (apilar 1 1 (figura 2) (figura 3)) ~?= False
    ]

allFigTests = TestList [
   "Test 1a allFig" ~: allFig (==1) (figura 1) ~?= True,
   "Test 1b allFig" ~: allFig (==1) (figura 2) ~?= False,
   "Test 2a allFig" ~: allFig (==1) (apilar 1 1 (figura 1) (figura 1)) ~?= True,
   "Test 2b allFig" ~: allFig (==1) (apilar 1 1 (figura 2) (figura 3)) ~?= False,
   "Test 2c allFig" ~: allFig (==1) (apilar 1 1 (figura 1) (figura 2)) ~?= False
    ]

andPTests = TestList [
   "Test 1a andP" ~: andP (==1) (==1) 1 ~?= True,
   "Test 1b andP" ~: andP (==1) (==2) 1 ~?= False,
   "Test 1c andP" ~: andP (==2) (==1) 1 ~?= False,
   "Test 1d andP" ~: andP (==2) (==2) 1 ~?= False
    ]

orPTests = TestList [
   "Test 1a orP" ~: orP (==1) (==1) 1 ~?= True,
   "Test 1b orP" ~: orP (==1) (==2) 1 ~?= True,
   "Test 1c orP" ~: orP (==2) (==1) 1 ~?= True,
   "Test 1d orP" ~: orP (==2) (==2) 1 ~?= False
    ]

main = runTestTT (TestList [cambiarTests, anyFigTests, allFigTests, andPTests, orPTests])