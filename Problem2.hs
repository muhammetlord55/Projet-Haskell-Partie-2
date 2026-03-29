module Problem2
  ( s0
  , fatherAnn
  , aliceIgn
  , bobIgn
  , problem2
  ) where

import EL


interp :: Prop -> [World]
interp "as" = [2, 3]
interp "bs" = [1, 3]
interp _    = []

indis :: Agent -> World -> [World]
indis "a" 0 = [0, 2]
indis "a" 1 = [1, 3]
indis "a" 2 = [0, 2]
indis "a" 3 = [1, 3]
indis "b" 0 = [0, 1]
indis "b" 1 = [0, 1]
indis "b" 2 = [2, 3]
indis "b" 3 = [2, 3]
indis _ w   = [w]

s0 :: EpiState
s0 = (interp, indis, 3)

fatherAnn :: EpiFormula
fatherAnn = Or (Var "as") (Var "bs")

aliceIgn :: EpiFormula
aliceIgn = And (Not (Knows "a" (Var "as")))
               (Not (Knows "a" (Not (Var "as"))))

bobIgn :: EpiFormula
bobIgn = And (Not (Knows "b" (Var "bs")))
             (Not (Knows "b" (Not (Var "bs"))))


problem2 :: EpiFormula
problem2 =
  And (And aliceIgn bobIgn)
      (After fatherAnn
        (And (And aliceIgn bobIgn)
             (After (And aliceIgn bobIgn)
               (And (Not aliceIgn) (Not bobIgn)))))
