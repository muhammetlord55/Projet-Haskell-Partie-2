module Problem3
  ( s0
  , fatherAnn
  , aliceIgn
  , bobIgn
  , carolineIgn
  , problem3
  ) where

import EL
import Data.Bits (xor)


interp :: Prop -> [World]
interp "as" = [4, 5, 6, 7]
interp "bs" = [2, 3, 6, 7]
interp "cs" = [1, 3, 5, 7] 
interp _    = []


indis :: Agent -> World -> [World]
indis "a" w = [w, w `xor` 4] 
indis "b" w = [w, w `xor` 2]
indis "c" w = [w, w `xor` 1]   
indis _ w   = [w]



s0 :: EpiState
s0 = (interp, indis, 7)

fatherAnn :: EpiFormula
fatherAnn = Or (Var "as") (Or (Var "bs") (Var "cs"))

aliceIgn :: EpiFormula
aliceIgn = And (Not (Knows "a" (Var "as")))
               (Not (Knows "a" (Not (Var "as"))))

bobIgn :: EpiFormula
bobIgn = And (Not (Knows "b" (Var "bs")))
             (Not (Knows "b" (Not (Var "bs"))))

carolineIgn :: EpiFormula
carolineIgn = And (Not (Knows "c" (Var "cs")))
                  (Not (Knows "c" (Not (Var "cs"))))


allIgn :: EpiFormula
allIgn = And aliceIgn (And bobIgn carolineIgn)



problem3 :: EpiFormula
problem3 =
  And allIgn
      (After fatherAnn
        (And allIgn
             (After allIgn
               (And allIgn
                    (After allIgn
                      (And (Not aliceIgn)
                           (And (Not bobIgn)
                                (Not carolineIgn))))))))
