module Problem1 where
import EL 

interp1 :: Prop -> [World]
interp1 "as" = [10, 11]
interp1 "bs" = [01, 11] 
interp1 _    = [] 

indis1 :: Agent -> World -> [World]
indis1 "a" 00 = [00, 10]
indis1 "a" 01 = [01, 11] 
indis1 "a" 10 = [00, 10]
indis1 "a" 11 = [01, 11]
indis1 "b" 00 = [00, 01]
indis1 "b" 10 = [10, 11] 
indis1 "b" 01 = [00, 01]
indis1 "b" 11 = [10, 11]
indis1 _ w    = [w] 

s0 :: EpiState
s0 = (interp1, indis1, 01)

fatherAnn = Or (Var "as") (Var "bs")
bobKnows = Knows "b" (Var "bs")
testFormula = After fatherAnn bobKnowsgh