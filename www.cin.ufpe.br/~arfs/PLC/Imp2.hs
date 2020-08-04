module Imp2 where

-- tokens
data T_SC                      = SEMI_COLON                  -- ;
data T_CM                      = COMMA                       -- ,
data T_BC                      = BECOMES                     -- :=
data T_AM                      = AMPERSAND                   -- &
data T_AS                      = ASTERISK                    -- *
data T_LB                      = LEFT_BRACKET                -- {
data T_RB                      = RIGHT_BRACKET               -- }
data T_PL                      = PLUS                        -- +
data T_MI                      = MINUS                       -- -
data T_CO                      = COMPARATION                 -- ==
data T_CC                      = CONCAT                      -- ++
data T_EQ                      = EQUALS                      -- =
data T_CI                      = CIRCUMFLEX                  -- ^
data T_LP                      = LEFT_PARENTHESIS            -- (
data T_RP                      = RIGHT_PARENTHESIS           -- )
data TProc                     = PROC                           
data TCall                     = CALL
data TWrite                    = WRITE
data TRead                     = READ
data TIf                       = IF
data TThen                     = THEN
data TElse                     = ELSE
data TWhile                    = WHILE
data TDo                       = DO
data TVar                      = VAR
data TPointer                  = POINTER
data TAnd                      = AND
data TOr                       = OR



-- producoes da sintaxe de Imp2
data Programa                     = PROGRAM                     Comando

data Comando                      = COM_DECL                    ComandoDeclaracao
                                  | COM_ATTR                    Atribuicao
                                  | COM_WHIL                    While
                                  | COM_IF                      IfThenElse
                                  | COM_IO                      IO_IMP
                                  | COM_SKIP                    Skip
                                  | COM_CALL                    ChamadaProcedimento
                                  | COM_SEQ                     Comando T_SC Comando

data Skip                         = SKIP

data Atribuicao                   = ATRIB                       Id T_BC Expressao

data Expressao                    = VALUE                       Valor
                                  | UNARY                       ExpUnaria
                                  | BINARY                      ExpBinaria
                                  | EXP_ID                      Id
                                  | AMP_OPE                     T_AM Id
                                  | AST_OPE                     T_AS Id

data Valor                        = CONC_VALUE                  ValorConcreto


data ValorConcreto                = INT_VALUE                   Int
                                  | BOL_VALUE                   Bool
                                  | STR_VALUE                   String

data ExpUnaria                    = INVERT                      Expressao
                                  | NOT                         Expressao
                                  | LENGTH                      Expressao

data ExpBinaria                   = SUM_EXP                     Expressao T_PL Expressao
                                  | SUB_EXP                     Expressao T_MI Expressao
                                  | AND_EXP                     Expressao TAnd Expressao
                                  | OR_EXP                      Expressao TOr Expressao
                                  | COMP_EXP                    Expressao T_CO Expressao
                                  | CONC_EXP                    Expressao T_CC Expressao


data ComandoDeclaracao            = DECL                        T_LB Declaracao T_SC Comando T_RB

data Declaracao                   = VAR_DECL                    DeclaracaoVariavel
                                  | PROC_DECL                   DeclaracaoProcedimento
                                  | SEQ_DECL                    Declaracao T_CM Declaracao

data DeclaracaoVariavel           = VAR_SIMPLES                 TVar Id T_EQ Expressao
                                  | VAR_POINTER                 TPointer Id T_EQ T_CI Tipo

data DeclaracaoProcedimento       = PROC_PARAM                  TProc Id T_LP Parametros T_RP T_LB Comando T_RB

data ListaDeclaracaoParametro     = DECL_SIMP                   Id PointerOrNo Tipo
                                  | DECL_SEQ                    Id PointerOrNo Tipo T_CM ListaDeclaracaoParametro 

data Tipo                         = TYPE_S | TYPE_I | TYPE_B deriving (Eq)

data While                        = WHILE_COM                   TWhile Expressao TDo Comando

data IfThenElse                   = IF_COM                      TIf Expressao TThen Comando TElse Comando

data IO_IMP                       = IO_WRITE                    TWrite T_LP Expressao T_RP
                                  | IO_READ                     TRead T_LP Id T_RP

data ChamadaProcedimento          = PROC_CALL_PARAM             TCall Id T_LP ListaExpressao T_RP
                                  | PROC_CALL_VOID              TCall Id T_LP T_RP  

data ListaExpressao               = ONE_EXP                     Expressao
                                  | MORE_EXP                    Expressao T_CM ListaExpressao

data Parametros                   = PARAM                       ListaDeclaracaoParametro
                                  | NULL_PARAM
--- para a ideia de zero ou um listaDeclaracaoParametro

data PointerOrNo                  = WITH_POINTER | NO_POINTER 
-- para a idéia de zero ou um pointeiro




-- métodos show para mostrar as produções.

instance Show Programa where
         show (PROGRAM x) = "program " ++ show(x)

instance Show Comando where
         show (COM_SEQ x SEMI_COLON y) = show (x) ++ ";\n" ++ show (y)
         show (COM_DECL x) = show (x)
         show (COM_ATTR x) = show (x)
         show (COM_WHIL x) = show (x)
         show (COM_IF x) = show (x)
         show (COM_IO x) = show (x)
         show (COM_CALL x) = show (x)
         show (COM_SKIP SKIP) = "skip"

instance Show Atribuicao where
         show (ATRIB x BECOMES y) = show (x) ++ " := " ++ show (y)

instance Show Expressao where
         show (VALUE x) = show (x)
         show (UNARY x) = show (x)
         show (BINARY x) = show (x)
         show (EXP_ID x) = show (x)
         show (AMP_OPE AMPERSAND x) = "&" ++ show (x)
         show (AST_OPE ASTERISK x) = "*" ++ show (x)

instance Show Valor where
         show (CONC_VALUE x) = show (x);

instance Show ValorConcreto where
         show (INT_VALUE x) = show (x);
         show (BOL_VALUE x) = show (x);
         show (STR_VALUE x) = show (x);

instance Show ExpUnaria where
         show (INVERT x) = "- (" ++ show (x) ++ ")"
         show (NOT x) = "not (" ++ show (x) ++ ")";
         show (LENGTH x) = "length (" ++ show (x) ++ ")";

instance Show ExpBinaria where
         show (SUM_EXP x PLUS y) = "(" ++ show (x) ++ " + " ++ show (y) ++ ")"
         show (SUB_EXP x MINUS y) = "(" ++ show (x) ++ " - " ++ show (y) ++ ")"
         show (AND_EXP x AND y) = "(" ++ show (x) ++ " and " ++ show (y) ++ ")"
         show (OR_EXP x OR y) = "(" ++ show (x) ++ " or " ++ show (y) ++ ")"
         show (COMP_EXP x COMPARATION y) = "(" ++ show (x) ++ " == " ++ show (y) ++ ")"
         show (CONC_EXP x CONCAT y) = "(" ++ show (x) ++ " ++ " ++ show (y) ++ ")"

instance Show ComandoDeclaracao where
         show (DECL LEFT_BRACKET x SEMI_COLON y RIGHT_BRACKET) = "{\n" ++ show (x) ++ ";\n" ++ show (y) ++ "\n}"

instance Show Declaracao where
         show (VAR_DECL x) = show (x)
         show (PROC_DECL x) = show (x)
         show (SEQ_DECL x COMMA y) = show (x) ++ ", " ++ show (y)

instance Show DeclaracaoVariavel where
         show (VAR_SIMPLES VAR x EQUALS y) = "var " ++ show (x) ++ " = " ++ show (y)
         show (VAR_POINTER POINTER x EQUALS CIRCUMFLEX y) = "pointer " ++ show (x) ++ " = ^" ++ show (y)

instance Show DeclaracaoProcedimento where
         show (PROC_PARAM PROC x LEFT_PARENTHESIS y RIGHT_PARENTHESIS LEFT_BRACKET z RIGHT_BRACKET) = "proc " ++ show (x) ++ "(" ++ show (y) ++ ") {\n" ++ show(z) ++ "\n}";

instance Show Parametros where
         show (PARAM x) = show (x)
         show (NULL_PARAM) = ""

instance Show ListaDeclaracaoParametro where
         show (DECL_SIMP x y z) = show (x) ++ " " ++ show(y) ++ show(z)
         show (DECL_SEQ x y z COMMA w) = show (x) ++ " " ++ show(y) ++ show(z) ++ " , " ++ show(w)

instance Show PointerOrNo where
         show (WITH_POINTER) = "^"
         show (NO_POINTER) = ""

instance Show Tipo where
         show (TYPE_B) = "boolean"
         show (TYPE_S) = "string"
         show (TYPE_I) = "int"

instance Show Id where
         show (ID x) = x
         
instance Show Endereco where
         show (END x) = show (x)

instance Show While where
         show (WHILE_COM WHILE x DO y) = "while " ++ show(x) ++ " do {\n" ++ show(y) ++ "\n}"

instance Show IfThenElse where
         show (IF_COM IF x THEN y ELSE z) = "if " ++ show(x) ++ " then {\n" ++ show(y) ++ "\n} ELSE {\n" ++ show (z) ++ "\n}"

instance Show IO_IMP where
         show (IO_WRITE WRITE LEFT_PARENTHESIS x RIGHT_PARENTHESIS) = "write (" ++ show (x) ++ ")"
         show (IO_READ READ LEFT_PARENTHESIS x RIGHT_PARENTHESIS) = "read (" ++ show (x) ++ ")"

instance Show ChamadaProcedimento where
         show (PROC_CALL_PARAM CALL x LEFT_PARENTHESIS y RIGHT_PARENTHESIS) = "call " ++ show (x) ++ " (" ++ show (y) ++ ")"
         show (PROC_CALL_VOID CALL x LEFT_PARENTHESIS RIGHT_PARENTHESIS) = "call " ++ show (x) ++ " ()"

instance Show ListaExpressao where
         show (ONE_EXP x) = show (x)
         show (MORE_EXP x COMMA y) = show (x) ++ " , " ++ show (y)

instance Show Memoria where
         show (MEM_LIST_END video _) = "Fim da memoria" ++ "\nSaida do Programa\n\n" ++ showVideo (video) ++ "\n\nFim Saida do Programa\n\n"
         show (MEM_LIST frame mem) = showFrame (frame) ++ "\n---------------------\n" ++ show (mem)

instance Show ValorMemoria where
         show (VAR_MEM (T tipo) valor) = ("Variavel Tipo (" ++ (show tipo) ++ ", " ++ (show valor) ++ ")")
         show (VAR_MEM (P tipo) valor) = ("Variavel Ponteiro pra " ++ (show tipo) ++ " (" ++ (show valor) ++ ")")
         show (FUNC_MEM (PROC_PARAM PROC x LEFT_PARENTHESIS y RIGHT_PARENTHESIS LEFT_BRACKET z RIGHT_BRACKET)) = "Funcao : proc " ++ show (x) ++ "(" ++ show (y) ++ ")"
         show (NULL) = "NULL"

showFrame :: Frame -> String
showFrame [] = ""
showFrame (bind : tail) = showFrame (tail) ++ "\n" ++ showBinding (bind)

showBinding :: Binding -> String
showBinding (end, ident, valor) = show (end) ++ " " ++ show (ident) ++ " " ++ show (valor)

showVideo :: Video -> String
showVideo [] = ""
showVideo (a : []) = "\"" ++ a ++ "\""
showVideo (a:tail) = (showVideo tail) ++ "\n" ++ "\"" ++ a ++ "\""







-- Abstração de memória

type Video = [String]
type Teclado = [ValorMemoria]

type Frame = [Binding]
type Binding = (Endereco, Id, ValorMemoria)
data TipoMemoria = P Tipo | T Tipo
data ValorMemoria =  VAR_MEM TipoMemoria Valor
             | FUNC_MEM DeclaracaoProcedimento
             | NULL

data Memoria                      = MEM_LIST_END Video Teclado
                                  | MEM_LIST Frame Memoria

data Endereco                     = END Int
data Id                           = ID  String 



getVideo :: Memoria -> Video
getVideo (MEM_LIST_END video _) = video
getVideo (MEM_LIST _ mem) = getVideo mem

adcionarStringVideo :: Memoria -> String -> Memoria
adcionarStringVideo (MEM_LIST_END video teclado) texto = MEM_LIST_END (texto : video) teclado
adcionarStringVideo (MEM_LIST frame mem) texto = MEM_LIST frame (adcionarStringVideo mem texto)

getProximaEntrada :: Memoria -> (Memoria, ValorMemoria)
getProximaEntrada (MEM_LIST_END _ []) = error "temos mais requisicoes do que entradas cadastradas"
getProximaEntrada (MEM_LIST_END video (a:teclado)) = ((MEM_LIST_END video (a:teclado)), a)
getProximaEntrada (MEM_LIST frame mem) = (MEM_LIST frame memoria, valor)
										  where
										      (memoria, valor) = getProximaEntrada (mem)

openScope :: Memoria -> Memoria
openScope (MEM_LIST_END _ _)=  error ("Isso realmente nao deveria ter acontecido!! Alguem deu um closeScope a mais e estamos no openScope")
openScope (MEM_LIST mem list) = MEM_LIST [] (MEM_LIST mem list)

closeScope :: Memoria -> Memoria
closeScope (MEM_LIST_END _ _) =  error ("Isso realmente nao deveria ter acontecido!! Alguem deu um closeScope a mais e estamos no closeScope")
closeScope (MEM_LIST _ (MEM_LIST_END _ _)) = error ("Isso realmente nao deveria ter acontecido!! Alguem deu um closeScope a mais e estamos no closeScope!")
closeScope (MEM_LIST _ (MEM_LIST mem list)) = (MEM_LIST mem list)

existeId :: Memoria -> Id -> Bool
existeId (MEM_LIST_END _ _) id = False;
existeId (MEM_LIST mem list) id | (existeIdNaTabela mem id) = True
                               | otherwise = (existeId list id)

buscarId :: Memoria -> Id -> Binding
buscarId (MEM_LIST_END _ _) x = error ("\n\n     A variavel " ++ show(x) ++ " ainda nao foi declarada!!!");
buscarId (MEM_LIST mem list) id   | (existeIdNaTabela mem id) = (buscarIdNaTabela mem id)
                                 | otherwise = (buscarId list id)

adcionarIdAoEscopo :: Memoria -> Id -> ValorMemoria -> Memoria
adcionarIdAoEscopo (MEM_LIST_END _ _) _ _ = error ("querendo adcionar uma varaivel no nada!!")
adcionarIdAoEscopo (MEM_LIST mem list) id valor | (existeIdNaTabela mem id) = error ("Esse identificador jah foi declarado!!")
                                               | otherwise = (MEM_LIST (adcionarIdNaTabela mem (END (getEndInteger(getProximoEnd (MEM_LIST mem list)) + 1)) id valor) list)

buscarIdNaTabela :: Frame -> Id -> Binding
buscarIdNaTabela [] _ = ((END 666), (ID "nao existe"), NULL)
buscarIdNaTabela ((a, id, b) : tail) idBusca | (equalsId id idBusca) =  (a, id, b)
                                             | otherwise = (buscarIdNaTabela tail idBusca)



adcionarIdNaTabela :: Frame -> Endereco -> Id -> ValorMemoria -> Frame
adcionarIdNaTabela mem end id valor = ((end, id, valor) : mem)

getProximoEnd :: Memoria -> Endereco
getProximoEnd (MEM_LIST_END _ _) = (END (-1))
getProximoEnd (MEM_LIST mem list) | (compEnd maiorDessa maiorProximas) > 0 = maiorDessa
                                 | otherwise = maiorProximas
                               where
                                  maiorDessa = getMaiorEndMemory mem
                                  maiorProximas = getProximoEnd list

getMaiorEndMemory :: Frame -> Endereco
getMaiorEndMemory [] = END (-1)
getMaiorEndMemory ((x, _, _):tail) | (compEnd x maior) > 0  = x
                                   | otherwise = maior
                                where
                                   maior = getMaiorEndMemory tail

compEnd :: Endereco -> Endereco -> Int
compEnd (END x) (END y) = x - y

getEndInteger :: Endereco -> Int
getEndInteger (END x) = x


existeIdNaTabela :: Frame -> Id -> Bool
existeIdNaTabela [] _ = False
existeIdNaTabela ((_, id, _) : tail) idBusca | (equalsId id idBusca) = True
                                             | otherwise = (existeIdNaTabela tail idBusca)
                                             
existeEndNaTabela :: Frame -> Endereco -> Bool
existeEndNaTabela [] _ = False
existeEndNaTabela ((end, _, _) : tail) endBusca | (equalsEnd end endBusca) = True
                                                | otherwise = (existeEndNaTabela tail endBusca)
buscarEndNaTabela :: Frame -> Endereco -> Binding
buscarEndNaTabela [] _ = ((END 666), (ID "nao existe"), NULL)
buscarEndNaTabela ((end, a, b) : tail) endBusca | (equalsEnd end endBusca) =  (end, a, b)
                                                | otherwise = (buscarEndNaTabela tail endBusca)  

existeEnd :: Memoria -> Endereco -> Bool
existeEnd (MEM_LIST_END _ _) _ = False
existeEnd (MEM_LIST mem list) end | (existeEndNaTabela mem end) = True
                                  | otherwise = (existeEnd list end)

buscarEnd :: Memoria -> Endereco -> Binding
buscarEnd (MEM_LIST_END _ _) _ = ((END 666), (ID "nao existe"), NULL)
buscarEnd (MEM_LIST mem list) end   | (existeEndNaTabela mem end) = (buscarEndNaTabela mem end)
                                    | otherwise = (buscarEnd list end)                                                
                                          

setarTipo :: Memoria -> Id -> ValorMemoria -> Memoria
setarTipo (MEM_LIST_END _ _) _ _ = error "Variavel nao declarada!"
setarTipo (MEM_LIST frame list) id tipo | (existeIdNaTabela frame id) = MEM_LIST (setarTipoNaTabela frame id tipo) list
                                        | otherwise = MEM_LIST frame (setarTipo list id tipo)

setarTipoNaTabela :: Frame -> Id -> ValorMemoria -> Frame
setarTipoNaTabela [] _ _= []
setarTipoNaTabela ((end, id, valor):tail) idBusca novoValor | (equalsId id idBusca) = ((end, id, novoValor):tail)
                                                            | otherwise = ((end, id, valor) : (setarTipoNaTabela tail idBusca novoValor))

equalsId :: Id -> Id -> Bool
equalsId (ID a) (ID b)
                   | (a == b)                   = True
                   | otherwise                  = False


equalsEnd :: Endereco -> Endereco -> Bool
equalsEnd (END a) (END b)
                   | (a == b)                   = True
                   | otherwise                  = False



























aExpressao :: Memoria -> Expressao -> ValorMemoria
aExpressao mem (VALUE (CONC_VALUE x)) = aExpValue x
aExpressao mem (UNARY x) = aExpUnaria mem x
aExpressao mem (BINARY x) = aExpBinaria mem x
aExpressao mem (EXP_ID x) =  aExpId mem x
aExpressao mem (AMP_OPE AMPERSAND x) = aExpAmp mem x
aExpressao mem (AST_OPE ASTERISK x) = aExpAst mem x

aExpValue :: ValorConcreto -> ValorMemoria
aExpValue (INT_VALUE x) = VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE x))
aExpValue (BOL_VALUE x) = VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE x))
aExpValue (STR_VALUE x) = VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE x))

aExpUnaria :: Memoria -> ExpUnaria -> ValorMemoria
aExpUnaria mem (INVERT x) = invertInt (aExpressao mem x)
aExpUnaria mem (NOT x) = notBool (aExpressao mem x)
aExpUnaria mem (LENGTH x) = lengthString (aExpressao mem x)

invertInt :: ValorMemoria -> ValorMemoria
invertInt (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE x))) = (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE (negate x))))
invertInt _ = error ("A funcao invert so pode ser usada com tipos inteiros!!!")
   
notBool :: ValorMemoria -> ValorMemoria
notBool (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE x))) = (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE (not x))))
notBool _ = error ("A funcao not so pode ser usada com tipos booleanos!!!")
    
lengthString :: ValorMemoria -> ValorMemoria
lengthString (VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE x))) = (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE (length x))))
lengthString _ = error ("A funcao length so pode ser usada com tipos String!!!")

aExpBinaria :: Memoria -> ExpBinaria -> ValorMemoria
aExpBinaria mem (SUM_EXP x PLUS y) = sumInt (aExpressao mem x) (aExpressao mem y)
aExpBinaria mem (SUB_EXP x MINUS y) = subInt (aExpressao mem x) (aExpressao mem y)
aExpBinaria mem (AND_EXP x AND y) = andBool (aExpressao mem x) (aExpressao mem y)
aExpBinaria mem (OR_EXP x OR y) = orBool (aExpressao mem x) (aExpressao mem y)
aExpBinaria mem (COMP_EXP x COMPARATION y) = comparation (aExpressao mem x) (aExpressao mem y)
aExpBinaria mem (CONC_EXP x CONCAT y) = concString (aExpressao mem x) (aExpressao mem y)

sumInt :: ValorMemoria -> ValorMemoria -> ValorMemoria
sumInt (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE x))) (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE y))) = (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE (x + y))))
sumInt _ _ = error("A funcao sum so pode ser usada com tipos inteiros!!!")

subInt :: ValorMemoria -> ValorMemoria -> ValorMemoria
subInt (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE x))) (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE y))) = (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE (x - y))))
subInt _ _ = error("A funcao sub so pode ser usada com tipos inteiros!!!")

andBool :: ValorMemoria -> ValorMemoria -> ValorMemoria
andBool (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE x))) (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE y))) = (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE (x && y))))
andBool _ _ = error("A funcao and so pode ser usada com tipos booleanos!!!")

orBool :: ValorMemoria -> ValorMemoria -> ValorMemoria
orBool (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE x))) (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE y))) = (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE (x || y))))
orBool _ _ = error("A funcao or so pode ser usada com tipos booleanos!!!")

concString :: ValorMemoria -> ValorMemoria -> ValorMemoria
concString (VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE x))) (VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE y))) = (VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE (x ++ y))))
concString _ _ = error("A funcao ++ so pode ser usada com tipos string!!!")

comparation :: ValorMemoria -> ValorMemoria -> ValorMemoria
comparation (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE x))) (VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE y))) = (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE (x == y))))
comparation (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE x))) (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE y))) = (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE (x == y))))
comparation (VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE x))) (VAR_MEM (T TYPE_S) (CONC_VALUE (STR_VALUE y))) = (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE (x == y))))

aExpId :: Memoria -> Id -> ValorMemoria
aExpId mem x = c where (a, b, c) = buscarId mem x

aExpAmp :: Memoria -> Id -> ValorMemoria
aExpAmp mem x = (VAR_MEM (P c) (CONC_VALUE (INT_VALUE a))) where ((END a), b, (VAR_MEM (T c) d)) = buscarId mem x

aExpAst :: Memoria -> Id -> ValorMemoria
aExpAst mem ide = d where
                     (_, _, (VAR_MEM _ (CONC_VALUE (INT_VALUE c)))) = buscarId mem ide
                     (_,_,d) = (buscarEnd mem (END c))




















executar :: Programa -> Teclado -> Memoria
executar x teclado = vPrograma (MEM_LIST [] (MEM_LIST_END [] teclado)) x


vPrograma ::  Memoria  -> Programa      -> Memoria
vPrograma x (PROGRAM c) = vComando x c

vComando ::   Memoria  -> Comando       -> Memoria
vComando mem (COM_SEQ x SEMI_COLON y) = vComando (vComando mem x) y
vComando mem (COM_DECL (DECL LEFT_BRACKET x SEMI_COLON y RIGHT_BRACKET)) = vComando (vComandoDeclaracao mem x) y
vComando mem (COM_ATTR x)             = vComandoAtribuicao mem x
vComando mem (COM_WHIL x)             = vComandoWhile mem x
vComando mem (COM_IF x)               = vComandoIf mem x
vComando mem (COM_IO x)               = vComandoIO mem x
vComando mem (COM_CALL x)             = vComandoCall mem x
vComando mem (COM_SKIP x)             = mem


vComandoDeclaracao :: Memoria -> Declaracao -> Memoria
vComandoDeclaracao mem (VAR_DECL x) = vComandoDeclaracaoVariavel mem x
vComandoDeclaracao mem (PROC_DECL x) = vComandoDeclaracaoProcedimento mem x
vComandoDeclaracao mem (SEQ_DECL x COMMA y) = vComandoDeclaracao (vComandoDeclaracao mem x) y

vComandoDeclaracaoVariavel :: Memoria -> DeclaracaoVariavel -> Memoria
vComandoDeclaracaoVariavel mem (VAR_SIMPLES VAR x EQUALS y) = (adcionarIdAoEscopo mem x (checarTipoMemoria "simples" (aExpressao mem y)))
vComandoDeclaracaoVariavel mem (VAR_POINTER POINTER x EQUALS CIRCUMFLEX y) = (adcionarIdAoEscopo mem x (VAR_MEM (P y) (CONC_VALUE (INT_VALUE (-1)))))

checarTipoMemoria :: String -> ValorMemoria -> ValorMemoria
checarTipoMemoria "simples" (VAR_MEM (T a) b) = (VAR_MEM (T a) b)
checarTipoMemoria "ponteiro" (VAR_MEM (P a) b) = (VAR_MEM (P a) b)
checarTipoMemoria "simples" _ = error("Nao eh possivel atribuir um ponteiro a uma variavel simples")
checarTipoMemoria "ponteiro" _ = error("Nao eh possivel atribuir uma variavel simples a um ponteiro")

vComandoDeclaracaoProcedimento :: Memoria -> DeclaracaoProcedimento -> Memoria
vComandoDeclaracaoProcedimento mem (PROC_PARAM PROC x LEFT_PARENTHESIS y RIGHT_PARENTHESIS LEFT_BRACKET z RIGHT_BRACKET)
                               = (adcionarIdAoEscopo mem x (FUNC_MEM (PROC_PARAM PROC x LEFT_PARENTHESIS y RIGHT_PARENTHESIS LEFT_BRACKET z RIGHT_BRACKET) ))


vComandoAtribuicao :: Memoria -> Atribuicao -> Memoria
vComandoAtribuicao mem (ATRIB (x) BECOMES y) = setarTipo mem x (aExpressao mem y)

vComandoWhile :: Memoria -> While -> Memoria
vComandoWhile mem (WHILE_COM WHILE x DO y)
                            | valorBool == False        = mem
                            | otherwise                 = let mem2 = (vComando mem y)
                                                            in (vComando mem2 (COM_WHIL (WHILE_COM WHILE x DO y)))
                              where
                                   (VAR_MEM (T TYPE_B) (CONC_VALUE (BOL_VALUE valorBool))) = (aExpressao mem x)


vComandoIf :: Memoria -> IfThenElse -> Memoria
vComandoIf mem (IF_COM IF x THEN c1 ELSE c2)
                            | valorBool == True        = vComando mem c1
                            | otherwise                = vComando mem c2
                              where
                                   (VAR_MEM _ (CONC_VALUE (BOL_VALUE valorBool))) = (aExpressao mem x)


vComandoIO :: Memoria -> IO_IMP -> Memoria
vComandoIO mem (IO_WRITE WRITE LEFT_PARENTHESIS expr RIGHT_PARENTHESIS) = (adcionarStringVideo mem (imprime valor))
																	where
																	   (VAR_MEM _ (CONC_VALUE valor)) = aExpressao mem expr
vComandoIO mem (IO_READ READ LEFT_PARENTHESIS iden RIGHT_PARENTHESIS) = setarTipo memoria iden valor
																	where
																	   (memoria, valor) = getProximaEntrada mem

imprime :: ValorConcreto -> String
imprime (INT_VALUE x) = (show x)
imprime (BOL_VALUE x) = (show x)
imprime (STR_VALUE x) = (show x)

vComandoCall :: Memoria -> ChamadaProcedimento -> Memoria                        
vComandoCall mem (PROC_CALL_VOID CALL x LEFT_PARENTHESIS RIGHT_PARENTHESIS) = vComandoCall2 mem (PROC_CALL_VOID CALL x LEFT_PARENTHESIS RIGHT_PARENTHESIS) (buscarId mem x)
vComandoCall mem (PROC_CALL_PARAM CALL x LEFT_PARENTHESIS y RIGHT_PARENTHESIS) = vComandoCall2 mem (PROC_CALL_PARAM CALL x LEFT_PARENTHESIS y RIGHT_PARENTHESIS) (buscarId mem x)
                                    
vComandoCall2 :: Memoria -> ChamadaProcedimento -> Binding -> Memoria
vComandoCall2 mem (PROC_CALL_VOID CALL x LEFT_PARENTHESIS RIGHT_PARENTHESIS)
                  (_,_,(FUNC_MEM (PROC_PARAM PROC x1 LEFT_PARENTHESIS NULL_PARAM RIGHT_PARENTHESIS LEFT_BRACKET com RIGHT_BRACKET)))
                        = closeScope (vComando (openScope mem) com)
vComandoCall2 mem (PROC_CALL_PARAM CALL x LEFT_PARENTHESIS y RIGHT_PARENTHESIS)
                  (_,_,(FUNC_MEM (PROC_PARAM PROC x1 LEFT_PARENTHESIS (PARAM qq) RIGHT_PARENTHESIS LEFT_BRACKET com RIGHT_BRACKET)))
                        = closeScope (vComando (validarParametros (openScope mem) x (avaliarListaExp mem y)) com)
vComandoCall2 mem _ _ = error ("Quantidade de parametros incompativel!")


avaliarListaExp :: Memoria -> ListaExpressao -> [ValorMemoria]
avaliarListaExp mem (ONE_EXP expr) = (aExpressao mem expr):[]
avaliarListaExp mem (MORE_EXP expr COMMA list) = (aExpressao mem expr) : (avaliarListaExp mem list)

validarParametros :: Memoria -> Id -> [ValorMemoria] -> Memoria
validarParametros mem ident listExp = validarParametros2 mem y listExp
                                      where
                                         (_,_,(FUNC_MEM (PROC_PARAM PROC x LEFT_PARENTHESIS y RIGHT_PARENTHESIS LEFT_BRACKET z RIGHT_BRACKET))) = buscarId mem ident


validarParametros2 :: Memoria -> Parametros -> [ValorMemoria] -> Memoria
validarParametros2 mem (PARAM (DECL_SIMP ident NO_POINTER t1)) ((VAR_MEM (T t2) valor) : [])
                    | t1 == t2          = adcionarIdAoEscopo mem ident (VAR_MEM (T t2) valor)
                    | otherwise         = error ("Parametros nao compativeis : " ++ show (t1) ++ " e " ++ show (t2) ++ "!")

validarParametros2 mem (PARAM (DECL_SIMP ident WITH_POINTER t1)) ((VAR_MEM (P t2) valor) : [])
                    | t1 == t2          = adcionarIdAoEscopo mem ident (VAR_MEM (P t2) valor)
                    | otherwise         = error ("Parametros nao compativeis : " ++ show (t1) ++ " e " ++ show (t2) ++ "!")

validarParametros2 mem (PARAM (DECL_SEQ ident NO_POINTER t1 COMMA list)) ((VAR_MEM (T t2) valor) : tail)  
                    | t1 == t2          = validarParametros2 (adcionarIdAoEscopo mem ident (VAR_MEM (T t2) valor)) (PARAM list) tail
                    | otherwise         = error ("Parametros nao compativeis : " ++ show (t1) ++ " e " ++ show (t2) ++ "!")

validarParametros2 mem (PARAM (DECL_SEQ ident WITH_POINTER t1 COMMA list)) ((VAR_MEM (P t2) valor) : tail)  
                    | t1 == t2          = validarParametros2 (adcionarIdAoEscopo mem ident (VAR_MEM (P t2) valor)) (PARAM list) tail
                    | otherwise         = error ("Parametros nao compativeis : " ++ show (t1) ++ " e " ++ show (t2) ++ "!")

validarParametros2 mem _ (vMem : [])  = error ("Tem mais parametros que argumentos!")
validarParametros2 mem (PARAM (DECL_SIMP _ _ _)) _  = error ("Tem mais argumentos que parametros!")
validarParametros2 mem _ _  = error ("Passagem de parametros errada!!")












-- Programas de exemplo

programa1 = PROGRAM (
                    COM_SEQ
                           (COM_SKIP
                                    SKIP)
                           SEMI_COLON
                           (COM_SKIP
                                    SKIP)
                    )


programa2 = PROGRAM (
                    COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "tres"
                                                                    )
                                                            EQUALS
                                                            (UNARY (INVERT (
                                                            (VALUE
                                                                (CONC_VALUE
                                                                    (INT_VALUE(2))
                                                                )
                                                             )
                                                            
                                                            ))
                                                             )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "string"
                                                                    )
                                                            EQUALS
                                                            (VALUE
                                                                (CONC_VALUE
                                                                    (STR_VALUE("merda"))
                                                                )
                                                             )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )

                    )



programa3 = PROGRAM (
                    COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "tres"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                            COMP_EXP
                                                                (VALUE (CONC_VALUE (BOL_VALUE (True))))
                                                                COMPARATION
                                                                (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                            )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "string"
                                                                    )
                                                            EQUALS
                                                            (VALUE
                                                                (CONC_VALUE
                                                                    (STR_VALUE("merda"))
                                                                )
                                                             )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )

                    )

programa4 = PROGRAM  (
                     COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "x"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                            COMP_EXP
                                                                (VALUE (CONC_VALUE (BOL_VALUE (True))))
                                                                COMPARATION
                                                                (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                            )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_ATTR
                                     (ATRIB
                                     (ID "z")
                                     BECOMES
                                     (VALUE
                                           (CONC_VALUE
                                                      (INT_VALUE(3))
                                           )

                                     )
                                     )
                            )
                     )


programa5 = PROGRAM (
                    COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "x"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                            COMP_EXP
                                                                (VALUE (CONC_VALUE (BOL_VALUE (True))))
                                                                COMPARATION
                                                                (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                            )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "y"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                                OR_EXP
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (True))))
                                                                    OR
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                                )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "z"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                                OR_EXP
                                                                    (EXP_ID (
                                                                            ID "y"
                                                                            )
                                                                    )
                                                                    OR
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                                )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )

                    )

                    )

programa6 = PROGRAM (
                    COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (
                                                  SEQ_DECL
                                                          (VAR_DECL (VAR_POINTER POINTER (ID "ponteiro") EQUALS CIRCUMFLEX TYPE_B))
                                                          COMMA
                                                         (VAR_DECL (VAR_POINTER POINTER (ID "ponteiro2") EQUALS CIRCUMFLEX TYPE_I))


                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_SEQ
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "x"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                                OR_EXP
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (True))))
                                                                    OR
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                                )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_SKIP
                                                SKIP
                                                )
                                       RIGHT_BRACKET
                                       )
                            )
                            SEMI_COLON
                            (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "z"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                                OR_EXP
                                                                    (VALUE (CONC_VALUE(BOL_VALUE (True))))
                                                                    OR
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                                )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_ATTR
                                        (ATRIB (ID "x") BECOMES (EXP_ID (ID "z")))
                                       )
                                       RIGHT_BRACKET
                                       )
                            )

                    )

                    )

loopInfinito = PROGRAM (
                    COM_WHIL
                           (WHILE_COM WHILE 
                                            (VALUE (CONC_VALUE(BOL_VALUE True)))
                                            DO
                                            (COM_SKIP SKIP)
                           )
                    )
                    
programaIfElse = PROGRAM (
                    COM_IF
                           (IF_COM IF 
                                      (VALUE (CONC_VALUE(BOL_VALUE True)))
                                      THEN
                                      (COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (
                                                VAR_SIMPLES
                                                            VAR (
                                                                    ID "z"
                                                                    )
                                                            EQUALS
                                                            (BINARY (
                                                                OR_EXP
                                                                    (VALUE (CONC_VALUE(BOL_VALUE (True))))
                                                                    OR
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                                )
                                                            )
                                                )
                                       )
                                       SEMI_COLON
                                       (COM_ATTR
                                        (ATRIB (ID "z") BECOMES (EXP_ID (ID "z")))
                                       )
                                       RIGHT_BRACKET
                                       )
                                       )
                                      ELSE
                                      (COM_IO (IO_WRITE WRITE LEFT_PARENTHESIS
                                                             (BINARY (
                                                                OR_EXP
                                                                    (VALUE (CONC_VALUE(BOL_VALUE (True))))
                                                                    OR
                                                                    (VALUE (CONC_VALUE (BOL_VALUE (False))))
                                                                )
                                                             )
                                                             RIGHT_PARENTHESIS)
                                      )
                           )
                    )
                    
                    
pAlteraGlobal = PROGRAM (
                        COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (
                                                  SEQ_DECL
                                                          (VAR_DECL (VAR_SIMPLES
                                                            VAR (
                                                                    ID "z"
                                                                    )
                                                            EQUALS
                                                            (VALUE (CONC_VALUE(INT_VALUE (665))))
                                                          ))
                                                          COMMA
                                                          (PROC_DECL (PROC_PARAM 
                                                                                 PROC
                                                                                 (ID "zMaisMais")
                                                                                 LEFT_PARENTHESIS
                                                                                 (PARAM (
                                                                                        DECL_SIMP 
                                                                                        (ID "z")
                                                                                        NO_POINTER
                                                                                        TYPE_I
                                                                                        )
                                                                                 )
                                                                                 RIGHT_PARENTHESIS
                                                                                 LEFT_BRACKET
                                                                                 ((COM_ATTR
                                                                                    (ATRIB (ID "z") BECOMES (
                                                                                                            BINARY (
                                                                                                                    SUM_EXP
                                                                                                                        (EXP_ID (ID "z"))
                                                                                                                        PLUS
                                                                                                                        (VALUE (CONC_VALUE (INT_VALUE (1))))
                                                                                                                    )
                                                                                                            )
                                                                                    )
                                                                                 ))
                                                                                 RIGHT_BRACKET
                                                                                 
                                                                     )
                                                          )


                                       )
                                       SEMI_COLON
                                       (COM_CALL
                                                (PROC_CALL_PARAM CALL (ID "zMaisMais") LEFT_PARENTHESIS (MORE_EXP (VALUE (CONC_VALUE (INT_VALUE 1))) COMMA (ONE_EXP (VALUE (CONC_VALUE (INT_VALUE 1))) )) RIGHT_PARENTHESIS)
                                                )
                                       RIGHT_BRACKET
                                       )
                    ) 
pImprime = PROGRAM (
                    COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (VAR_DECL (VAR_SIMPLES
                                                            VAR (
                                                                    ID "x"
                                                                    )
                                                            EQUALS
                                                            (VALUE (CONC_VALUE(INT_VALUE (665))))
                                                          ))
                                       SEMI_COLON
                                       (COM_SEQ
                                                (COM_IO(
                                                         IO_READ READ 
                                                         LEFT_PARENTHESIS
                                                         (ID "x")
                                                         RIGHT_PARENTHESIS             
                                                       ))
                                                SEMI_COLON
                                                (COM_SEQ
                                                    (COM_IO(
                                                         IO_WRITE WRITE 
                                                         LEFT_PARENTHESIS
                                                         (EXP_ID (ID "x"))
                                                         RIGHT_PARENTHESIS             
                                                       ))
                                                    SEMI_COLON
                                                    (COM_IO(
                                                         IO_WRITE WRITE 
                                                         LEFT_PARENTHESIS
                                                         (VALUE (CONC_VALUE(INT_VALUE (666))))
                                                         RIGHT_PARENTHESIS             
                                                       )))
                                               
                                         )
                                        RIGHT_BRACKET
                                 )
                    )                   
pFatorialPonteiro = PROGRAM (
                        COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (  
                                           SEQ_DECL
                                                  ( SEQ_DECL 
                                                        (VAR_DECL (VAR_SIMPLES
                                                            VAR (
                                                                    ID "x"
                                                                    )
                                                            EQUALS
                                                            (VALUE (CONC_VALUE(INT_VALUE (3))))
                                                          ))
                                                         COMMA
                                                         (SEQ_DECL
                                                                (VAR_DECL (VAR_SIMPLES
                                                                    VAR (
                                                                            ID "count"
                                                                        )
                                                                    EQUALS
                                                                    (VALUE (CONC_VALUE(INT_VALUE (0))))
                                                                ))
                                                                COMMA
                                                                (PROC_DECL (PROC_PARAM 
                                                                                 PROC
                                                                                 (ID "mult")
                                                                                 LEFT_PARENTHESIS             
                                                                                 (PARAM ( --DECL_SEQ Id PointerOrNo Tipo T_CM ListaDeclaracaoParametro
                                                                                        DECL_SEQ 
                                                                                        (ID "n1")
                                                                                        NO_POINTER
                                                                                        TYPE_I
                                                                                        COMMA
                                                                                        (
                                                                                        DECL_SIMP 
                                                                                        (ID "n2")
                                                                                        NO_POINTER
                                                                                        TYPE_I
                                                                                        )
                                                                                        )
                                                                                 )
                                                                                 RIGHT_PARENTHESIS
                                                                                 LEFT_BRACKET
                                                                                 (COM_SEQ
                                                                                    (COM_ATTR (ATRIB (ID "x") BECOMES (VALUE (CONC_VALUE (INT_VALUE 0))))) -- X = 0
                                                                                    SEMI_COLON
                                                                                    (COM_SEQ
                                                                                      (COM_ATTR (ATRIB (ID "count") BECOMES (VALUE (CONC_VALUE (INT_VALUE 0))))) --COUNT = 0
                                                                                      SEMI_COLON
                                                                                      (COM_WHIL ( WHILE_COM --WHILE_COM TWhile Expressao TDo Comando
                                                                                                  WHILE
                                                                                                  (UNARY (NOT (BINARY ( COMP_EXP
                                                                                                                        (EXP_ID (ID "n1"))
                                                                                                                        COMPARATION
                                                                                                                        (EXP_ID (ID "count")))))) -- not(n1 == count)
                                                                                                  DO
                                                                                                  (COM_SEQ
                                                                                                    (COM_ATTR (ATRIB (ID "x") BECOMES (BINARY ( SUM_EXP (EXP_ID (ID "x")) PLUS (EXP_ID (ID "n2")))))) -- x = x + n2;
                                                                                                    SEMI_COLON
                                                                                                    (COM_ATTR (ATRIB (ID "count") BECOMES (BINARY ( SUM_EXP (EXP_ID (ID "count")) PLUS (VALUE (CONC_VALUE (INT_VALUE 1))))))) --count = count + 1
                                                                                                  )            
                                                                                                ) 
                                                                                      )--WHILE
                                                                                    )
                                                                                 )
                                                                                 RIGHT_BRACKET
                                                                       )
                                                           )
                                                          )
                                                   )
                                                  COMMA
                                                  (SEQ_DECL
                                                          (VAR_DECL (VAR_SIMPLES
                                                            VAR (
                                                                    ID "z"
                                                                    )
                                                            EQUALS
                                                            (VALUE (CONC_VALUE(INT_VALUE (1))))
                                                          ))
                                                          COMMA
                                                          (PROC_DECL (PROC_PARAM 
                                                                                 PROC
                                                                                 (ID "fatorial")
                                                                                 LEFT_PARENTHESIS             
                                                                                 (PARAM (
                                                                                        DECL_SIMP 
                                                                                        (ID "N")
                                                                                        WITH_POINTER
                                                                                        TYPE_I
                                                                                        )
                                                                                 )
                                                                                 RIGHT_PARENTHESIS
                                                                                 LEFT_BRACKET
                                                                                 (COM_IF ( --IF_COM  TIf Expressao TThen Comando TElse Comando
                                                                                            IF_COM
                                                                                            IF
                                                                                            ( BINARY ( --COMP_EXP Expressao T_CO Expressao
                                                                                                       COMP_EXP
                                                                                                       (AST_OPE ASTERISK (ID "N"))
                                                                                                       COMPARATION
                                                                                                       (VALUE (CONC_VALUE (INT_VALUE 1))) 
                                                                                                      )
                                                                                            )
                                                                                            THEN
                                                                                            ((COM_ATTR
                                                                                                  (ATRIB (ID "z") BECOMES (
                                                                                                                            VALUE (CONC_VALUE (INT_VALUE 1))
                                                                                                                           )
                                                                                                  )
                                                                                            ))
                                                                                            ELSE
                                                                                            (COM_SEQ
                                                                                                  (COM_CALL
                                                                                                    (PROC_CALL_PARAM CALL (ID "fatorial") LEFT_PARENTHESIS (ONE_EXP ( BINARY (
                                                                                                                                                                                SUB_EXP
                                                                                                                                                                                        (AST_OPE ASTERISK (ID "N"))
                                                                                                                                                                                        MINUS
                                                                                                                                                                                        (VALUE (CONC_VALUE (INT_VALUE (1))))
                                                                                                                                                                              )
                                                                                                                                                                     ) ) RIGHT_PARENTHESIS)
                                                                                                   )
                                                                                                  SEMI_COLON
                                                                                                  (COM_SEQ
                                                                                                    (COM_CALL
                                                                                                        (PROC_CALL_PARAM CALL (ID "mult") LEFT_PARENTHESIS (MORE_EXP (EXP_ID (ID "z")) COMMA (ONE_EXP (AST_OPE ASTERISK (ID "N")))) RIGHT_PARENTHESIS)
                                                                                                    )
                                                                                                    SEMI_COLON 
                                                                                                    (COM_ATTR
                                                                                                       (ATRIB (ID "z") BECOMES (EXP_ID (ID "x"))
                                                                                                       )
                                                                                                    )
                                                                                                  )
                                                                                            )
                                                                                          )
                                                                                 )
                                                                                 RIGHT_BRACKET
                                                                       )
                                                           )
                                         ))
                                         SEMI_COLON
                                         (COM_SEQ
                                            (COM_SEQ
                                              (COM_IO(
                                                         IO_READ READ 
                                                         LEFT_PARENTHESIS
                                                         (ID "x")
                                                         RIGHT_PARENTHESIS             
                                                       ))
                                             SEMI_COLON
                                              (COM_CALL
                                                 (PROC_CALL_PARAM CALL (ID "fatorial") LEFT_PARENTHESIS (ONE_EXP (AMP_OPE AMPERSAND (ID "x"))) RIGHT_PARENTHESIS)
                                               )
                                            )
                                            SEMI_COLON
                                            (COM_IO(
                                                         IO_WRITE WRITE 
                                                         LEFT_PARENTHESIS
                                                         (EXP_ID (ID "z"))
                                                         RIGHT_PARENTHESIS             
                                                       )) 
                                         )
                                         RIGHT_BRACKET
                              )
               )
               
pFatorial = PROGRAM (
                        COM_DECL  (
                                       DECL
                                       LEFT_BRACKET
                                       (  
                                           SEQ_DECL
                                                  ( SEQ_DECL 
                                                        (VAR_DECL (VAR_SIMPLES
                                                            VAR (
                                                                    ID "x"
                                                                    )
                                                            EQUALS
                                                            (VALUE (CONC_VALUE(INT_VALUE (3))))
                                                          ))
                                                         COMMA
                                                         (SEQ_DECL
                                                                (VAR_DECL (VAR_SIMPLES
                                                                    VAR (
                                                                            ID "count"
                                                                        )
                                                                    EQUALS
                                                                    (VALUE (CONC_VALUE(INT_VALUE (0))))
                                                                ))
                                                                COMMA
                                                                (PROC_DECL (PROC_PARAM 
                                                                                 PROC
                                                                                 (ID "mult")
                                                                                 LEFT_PARENTHESIS             
                                                                                 (PARAM ( --DECL_SEQ Id PointerOrNo Tipo T_CM ListaDeclaracaoParametro
                                                                                        DECL_SEQ 
                                                                                        (ID "n1")
                                                                                        NO_POINTER
                                                                                        TYPE_I
                                                                                        COMMA
                                                                                        (
                                                                                        DECL_SIMP 
                                                                                        (ID "n2")
                                                                                        NO_POINTER
                                                                                        TYPE_I
                                                                                        )
                                                                                        )
                                                                                 )
                                                                                 RIGHT_PARENTHESIS
                                                                                 LEFT_BRACKET
                                                                                 (COM_SEQ
                                                                                    (COM_ATTR (ATRIB (ID "x") BECOMES (VALUE (CONC_VALUE (INT_VALUE 0))))) -- X = 0
                                                                                    SEMI_COLON
                                                                                    (COM_SEQ
                                                                                      (COM_ATTR (ATRIB (ID "count") BECOMES (VALUE (CONC_VALUE (INT_VALUE 0))))) --COUNT = 0
                                                                                      SEMI_COLON
                                                                                      (COM_WHIL ( WHILE_COM --WHILE_COM TWhile Expressao TDo Comando
                                                                                                  WHILE
                                                                                                  (UNARY (NOT (BINARY ( COMP_EXP
                                                                                                                        (EXP_ID (ID "n1"))
                                                                                                                        COMPARATION
                                                                                                                        (EXP_ID (ID "count")))))) -- not(n1 == count)
                                                                                                  DO
                                                                                                  (COM_SEQ
                                                                                                    (COM_ATTR (ATRIB (ID "x") BECOMES (BINARY ( SUM_EXP (EXP_ID (ID "x")) PLUS (EXP_ID (ID "n2")))))) -- x = x + n2;
                                                                                                    SEMI_COLON
                                                                                                    (COM_ATTR (ATRIB (ID "count") BECOMES (BINARY ( SUM_EXP (EXP_ID (ID "count")) PLUS (VALUE (CONC_VALUE (INT_VALUE 1))))))) --count = count + 1
                                                                                                  )            
                                                                                                ) 
                                                                                      )--WHILE
                                                                                    )
                                                                                 )
                                                                                 RIGHT_BRACKET
                                                                       )
                                                           )
                                                          )
                                                   )
                                                  COMMA
                                                  (SEQ_DECL
                                                          (VAR_DECL (VAR_SIMPLES
                                                            VAR (
                                                                    ID "z"
                                                                    )
                                                            EQUALS
                                                            (VALUE (CONC_VALUE(INT_VALUE (1))))
                                                          ))
                                                          COMMA
                                                          (PROC_DECL (PROC_PARAM 
                                                                                 PROC
                                                                                 (ID "fatorial")
                                                                                 LEFT_PARENTHESIS             
                                                                                 (PARAM (
                                                                                        DECL_SIMP 
                                                                                        (ID "N")
                                                                                        NO_POINTER
                                                                                        TYPE_I
                                                                                        )
                                                                                 )
                                                                                 RIGHT_PARENTHESIS
                                                                                 LEFT_BRACKET
                                                                                 (COM_IF ( --IF_COM  TIf Expressao TThen Comando TElse Comando
                                                                                            IF_COM
                                                                                            IF
                                                                                            ( BINARY ( --COMP_EXP Expressao T_CO Expressao
                                                                                                       COMP_EXP
                                                                                                       (EXP_ID (ID "N"))
                                                                                                       COMPARATION
                                                                                                       (VALUE (CONC_VALUE (INT_VALUE 1))) 
                                                                                                      )
                                                                                            )
                                                                                            THEN
                                                                                            ((COM_ATTR
                                                                                                  (ATRIB (ID "z") BECOMES (
                                                                                                                            VALUE (CONC_VALUE (INT_VALUE 1))
                                                                                                                           )
                                                                                                  )
                                                                                            ))
                                                                                            ELSE
                                                                                            (COM_SEQ
                                                                                                  (COM_CALL
                                                                                                    (PROC_CALL_PARAM CALL (ID "fatorial") LEFT_PARENTHESIS (ONE_EXP ( BINARY (
                                                                                                                                                                                SUB_EXP
                                                                                                                                                                                        (EXP_ID (ID "N"))
                                                                                                                                                                                        MINUS
                                                                                                                                                                                        (VALUE (CONC_VALUE (INT_VALUE (1))))
                                                                                                                                                                              )
                                                                                                                                                                     ) ) RIGHT_PARENTHESIS)
                                                                                                   )
                                                                                                  SEMI_COLON
                                                                                                  (COM_SEQ
                                                                                                    (COM_CALL
                                                                                                        (PROC_CALL_PARAM CALL (ID "mult") LEFT_PARENTHESIS (MORE_EXP (EXP_ID (ID "z")) COMMA (ONE_EXP (EXP_ID (ID "N")))) RIGHT_PARENTHESIS)
                                                                                                    )
                                                                                                    SEMI_COLON 
                                                                                                    (COM_ATTR
                                                                                                       (ATRIB (ID "z") BECOMES (EXP_ID (ID "x"))
                                                                                                       )
                                                                                                    )
                                                                                                  )
                                                                                            )
                                                                                          )
                                                                                 )
                                                                                 RIGHT_BRACKET
                                                                       )
                                                           )
                                         ))
                                         SEMI_COLON
                                         (COM_SEQ
                                            (COM_SEQ
                                              (COM_IO(
                                                         IO_READ READ 
                                                         LEFT_PARENTHESIS
                                                         (ID "x")
                                                         RIGHT_PARENTHESIS             
                                                       ))
                                             SEMI_COLON
                                              (COM_CALL
                                                 (PROC_CALL_PARAM CALL (ID "fatorial") LEFT_PARENTHESIS (ONE_EXP (EXP_ID (ID "x"))) RIGHT_PARENTHESIS)
                                               )
                                            )
                                            SEMI_COLON
                                            (COM_IO(
                                                         IO_WRITE WRITE 
                                                         LEFT_PARENTHESIS
                                                         (EXP_ID (ID "z"))
                                                         RIGHT_PARENTHESIS             
                                                       )) 
                                         )
                                         RIGHT_BRACKET
                              )
               )
               
pPonteiroSimples = PROGRAM ( COM_DECL  (
                                           DECL
                                           LEFT_BRACKET
                                           (SEQ_DECL
                                               (VAR_DECL (VAR_SIMPLES VAR (ID "ponteiro") EQUALS (VALUE (CONC_VALUE (INT_VALUE 10)))))
                                               COMMA
                                               (PROC_DECL (PROC_PARAM 
                                                                                 PROC
                                                                                 (ID "fatorial")
                                                                                 LEFT_PARENTHESIS             
                                                                                 (PARAM (
                                                                                        DECL_SIMP 
                                                                                        (ID "N")
                                                                                        WITH_POINTER
                                                                                        TYPE_I
                                                                                        )
                                                                                 )
                                                                                 RIGHT_PARENTHESIS
                                                                                 LEFT_BRACKET
                                                                                 (COM_IO(
                                                                                           IO_WRITE WRITE
                                                                                           LEFT_PARENTHESIS
                                                                                           (AST_OPE ASTERISK (ID "N"))
                                                                                           RIGHT_PARENTHESIS             
                                                                                        )
                                                                                 )
                                                                                 RIGHT_BRACKET
                                                          ))
                                           )
                                           SEMI_COLON
                                           ( COM_SEQ 
                                               (COM_ATTR
                                                     (ATRIB (ID "ponteiro") BECOMES (VALUE (CONC_VALUE (INT_VALUE 666)))))
                                               SEMI_COLON
                                               (COM_CALL
                                                     (PROC_CALL_PARAM CALL (ID "fatorial") LEFT_PARENTHESIS (ONE_EXP (AMP_OPE AMPERSAND (ID "ponteiro"))) RIGHT_PARENTHESIS))     
                                           )
                                           RIGHT_BRACKET
                                       )
                            )
main =  do {
    print pFatorial;
    putStr "\n---------------------";
    print (executar pFatorial [(VAR_MEM (T TYPE_I) (CONC_VALUE (INT_VALUE 8)))]);
}


