type Prop = String
type Agent = String
type World = Int 

type EpiState = (
    Prop -> [World],                          
    Agent -> World -> [World],     
    World                         
  )

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
    deriving (Show, Eq)

epiSat :: EpiState -> EpiFormula -> Bool
epiSat s T = True
epiSat s F = False
epiSat (interp, _, w) (Var p) = w `elem` interp p
epiSat s (Not phi) = not (epiSat s phi)
epiSat s (And phi psi) = epiSat s phi && epiSat s psi 
epiSat s (Or phi psi)  = epiSat s phi || epiSat s psi 
epiSat s (Imp phi psi) = not (epiSat s phi) || epiSat s psi
epiSat s (Eqv phi psi) = epiSat s phi == epiSat s psi
epiSat (interp, indis, w) (Knows a phi) = 
    all (\w' -> epiSat (interp, indis, w') phi) (indis a w)
epiSat s (After phi psi) = 
    epiSat s phi && epiSat (update s phi) psi

update :: EpiState -> EpiFormula -> EpiState
update (interp, indis, w) phi = (interp', indis', w)
  where
    interp' p = [w' | w' <- interp p, epiSat (interp, indis, w') phi]
    indis' a w_ref = [w' | w' <- indis a w_ref, epiSat (interp, indis, w') phi]
