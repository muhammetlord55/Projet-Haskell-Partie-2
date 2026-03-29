module Problem4
  ( s0
  , anneIgn
  , billIgn
  , problem4
  ) where

import EL
-----------------------------------------------------

interp :: Prop -> [World]
-- Anne's number
interp "a0" = [0]
interp "a1" = [1, 2]
interp "a2" = [3, 4]
interp "a3" = [5, 6]
interp "a4" = [7]
-- Bill's number
interp "b0" = [1]
interp "b1" = [0, 3]
interp "b2" = [2, 5]
interp "b3" = [4, 7]
interp "b4" = [6]
interp _    = []



indis :: Agent -> World -> [World]
indis "anne" 0 = [0]
indis "anne" 1 = [1, 2]
indis "anne" 2 = [1, 2]
indis "anne" 3 = [3, 4]
indis "anne" 4 = [3, 4]
indis "anne" 5 = [5, 6]
indis "anne" 6 = [5, 6]
indis "anne" 7 = [7]


indis "bill" 0 = [0, 3]  
indis "bill" 1 = [1]   
indis "bill" 2 = [2, 5]
indis "bill" 3 = [0, 3] 
indis "bill" 4 = [4, 7]
indis "bill" 5 = [2, 5]   
indis "bill" 6 = [6]      
indis "bill" 7 = [4, 7] 
indis _ w = [w]


s0 :: EpiState
s0 = (interp, indis, 2)

anneIgn :: EpiFormula
anneIgn =
  Not (Or (Knows "anne" (Var "b0"))
          (Or (Knows "anne" (Var "b1"))
              (Or (Knows "anne" (Var "b2"))
                  (Or (Knows "anne" (Var "b3"))
                      (Knows "anne" (Var "b4"))))))


billIgn :: EpiFormula
billIgn =
  Not (Or (Knows "bill" (Var "a0"))
          (Or (Knows "bill" (Var "a1"))
              (Or (Knows "bill" (Var "a2"))
                  (Or (Knows "bill" (Var "a3"))
                      (Knows "bill" (Var "a4"))))))


anneKnows :: EpiFormula
anneKnows =
  Or (Knows "anne" (Var "b0"))
     (Or (Knows "anne" (Var "b1"))
         (Or (Knows "anne" (Var "b2"))
             (Or (Knows "anne" (Var "b3"))
                 (Knows "anne" (Var "b4")))))


problem4 :: EpiFormula
problem4 =
  And (And anneIgn billIgn)
      (After anneIgn
        (After billIgn
          anneKnows))
