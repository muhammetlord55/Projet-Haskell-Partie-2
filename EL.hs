module EL
  ( Prop
  , Agent
  , World
  , EpiState
  , EpiFormula(..)
  , epiSat
  , testEpiSat
  , update
  , testUpdate
  , testAll
  ) where

type Prop = String
type Agent = String
type World = Int
type EpiState = (Prop -> [World], Agent -> World -> [World], World)

data EpiFormula
  = T
  | F
  | Var Prop 
  | Not EpiFormula
  | And EpiFormula EpiFormula
  | Or  EpiFormula EpiFormula
  | Imp EpiFormula EpiFormula
  | Eqv EpiFormula EpiFormula
  | Knows Agent EpiFormula
  | After EpiFormula EpiFormula  
  deriving (Show)

epiSat :: EpiState -> EpiFormula -> Bool
epiSat _  T  = True
epiSat _  F  = False
epiSat (interp, _, w)   (Var p)       = w `elem` interp p
epiSat s                (Not phi)     = not (epiSat s phi)
epiSat s                (And phi psi) = epiSat s phi && epiSat s psi
epiSat s                (Or  phi psi) = epiSat s phi || epiSat s psi
epiSat s                (Imp phi psi) = not (epiSat s phi) || epiSat s psi
epiSat s                (Eqv phi psi) = epiSat s (Imp phi psi) && epiSat s (Imp psi phi)
epiSat (interp, indis, w) (Knows a phi) =
  all (\w' -> epiSat (interp, indis, w') phi) (indis a w)
epiSat s                  (After phi psi) =
  epiSat s phi && epiSat (update s phi) psi


update :: EpiState -> EpiFormula -> EpiState
update (interp, indis, w) phi = (interp', indis', w)
  where
    valid w'   = epiSat (interp, indis, w') phi
    interp' p  = filter valid (interp p)
    indis' a w' = filter valid (indis a w')


testEpiSat :: EpiState -> EpiFormula -> String
testEpiSat s f = show (epiSat s f)

testUpdate :: EpiState -> EpiFormula -> String
testUpdate s phi = show (epiSat (update s phi) phi)

testAll :: String
testAll = if all id results then "All tests passed."
          else "Some tests FAILED."
  where
    results = [t1, t2, t3, t4, t5, t6]
    s       = (interp0, indis0, 1)

    interp0 :: Prop -> [World]
    interp0 "as" = [2, 3]
    interp0 "bs" = [1, 3]
    interp0 _    = []

    indis0 :: Agent -> World -> [World]
    indis0 "a" 0 = [0, 2]
    indis0 "a" 1 = [1, 3]
    indis0 "a" 2 = [0, 2]
    indis0 "a" 3 = [1, 3]
    indis0 "b" 0 = [0, 1]
    indis0 "b" 1 = [0, 1]
    indis0 "b" 2 = [2, 3]
    indis0 "b" 3 = [2, 3]
    indis0 _   w = [w]

    t1 = epiSat s T                                                      == True
    t2 = epiSat s F                                                      == False
    t3 = epiSat s (Var "bs")                                             == True
    t4 = epiSat s (Var "as")                                             == False
    t5 = epiSat s (Knows "b" (Var "bs"))                                 == False
    t6 = epiSat s (After (Or (Var "as") (Var "bs")) (Knows "b" (Var "bs"))) == True
