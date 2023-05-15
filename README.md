1\. Análisis Léxico

(a) Separar los símbolos en terminales y no terminales.


|**Terminales**|**No Terminales**|
| :-: | :-: |
|-|Argumentos|
|!|Asignacion|
|!=|assign\_op|
|%|Bloque |
|%=|Caso|
|&|ClausulaFor|
|&&|Conversion|
|\*|DatoMiembro|
|\*=|Declaracion |
|/|DeclaracionCampo|
|/=|DeclaracionConst|
|{}|DeclaracionFuncion|
|+|DeclaracionLocal|
|+=|DeclaracionParam|
|=|DeclaracionParams|
|-=|DeclaracionVar|
|==|Declarasiones|
|cadena |ExprCaso|
|caso |ExprCasos|
|constante|Expresion|
|continuar|ListaArgumentos|
|dec32|ListaIdentificadores|
|dec64|ListaIdentificadoresConst|
|detener|ListaParam|
|devolver|ListaSentencias|
|ent |Literal|
|estructura|LlamadaFuncion|
|falso |NombreTipo|
|funcion|OpBinario|
|identificador|OpUnario|
|imprimir|ParteArreglo|
|leer|ParteIzquierda|
|literal\_cadena|Programa|
|literal\_entera|Sentencia|
|literal\_flotante|Sentencia Return|
|literal\_runa verdadero|SentenciaBreak|
|logico|SentenciaContinue|
|para|SentenciaFor|
|predeterminado|SentenciaIf|
|runa|SentenciaIncDec|
|segun|SentenciaSimple|
|si|SentenciaSwitch|
|sin|Tipo|
|sino|TipoArreglo|
|var|TipoEstructura|
||TipoParam|
||TipoParamArr|

(b) Generar las expresiones regulares para los terminales. Poner especial atención en los siguientes tokens.

**i. Los identificadores deben de comenzar pueden comenzar con una letra, un guión bajo o el símbolo de pesos, seguidos o no de más letras, guiones bajos, símbolos de pesos o dígitos. Las letras pueden tener acentos tanto las mayúsculas como las minúsculas, así mismo se pueden usar diéresis y la ñ.**

Posible solución:

[a-zA-ZáéíóúÁÉÍÓÚñÑ\_$][a-zA-ZáéíóúÁÉÍÓÚñÑ\_$0-9]\*

La expresión generada acepta cadenas que comienzan con una letra, un guión bajo o un símbolo de pesos, que puede seguir con cualquier combinación de letras, guiones bajos, símbolos de pesos o dígitos. Las letras pueden tener acentos, diéresis y la letra "ñ".

**ii. Las literales enteras pueden contener guiones bajos como los siguientes ejemplos** 

**1\_2\_3** 

**234\_34\_4** 

**42** 

**4\_2** 

**0600** 

**0\_600** 

**170141183460469231731687303715884105727 170\_141183\_460469\_231731\_687303\_715884\_105727**

0|[1-9][0-9](\_?[0-9]+)

**iii. Las constantes flotantes deben tener la siguiente estructura:** 

**0.** 

**72.40** 

**072.40 // == 72.40** 

**2.71828** 

**1.e+0 6.67428e-11** 

**1E6 .25 .12345E+5** 

**1\_5. // == 15.0** 

**0.15e+0\_2 // == 15.0** 

**Contraejemplos:** 

**1\_.5** 

**1.\_5** 

**1.5\_e1** 

**1.5e\_1** 

**1.5e1\_**

([0-9]+(?[0-9]+).[0-9](?[0-9]+)([eE][+-]?[0-9]+(\_?[0-9]+))?)|(.[0-9]+(?[0-9]+)\*([eE][+-]?[0-9]+(?[0-9]+))?)|([0-9]+(\_?[0-9]+)[eE][+-]?[0-9]+(\_?[0-9]+)\*)

**(c) Las runas que son una extensión de los caracteres del lenguaje que pero que además contienen las letras con acento y la eñe.**

` `**’a’** 

**’ä’** 

**’\t’** 

**’\’’ 		// Carácter de comilla simple** 

**Contraejemplos:** 

**’aa’** 

**’\k’**

([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ]|\[abfnrtv'"\])

**(d) Cadenas de caracteres que se pueden tener la siguiente estructura:** 

**‘abc‘ 		// lo mismo que "abc"** 

**‘\n** 

**\n‘ 		// lo mismo que "\\n\n\\n"** 

**"\n"** 

**"\"" 		// lo mismo que ‘ " ‘** 

**"Hello, world!\n"** 

**"sí es una cadena"** 

("([^"\]|\[abfnrtv\"])\*")|('([^'\]|\[abfnrtv\'])')

**(e) Los comentarios serán los comentarios idénticos al los comentarios del lenguaje C de una o varias líneas** 

/([^]|\*+[^/])\*+/

**(f) Calcular el AFD para las runas, enteros, flotantes, identificadores.** 

**Runas:**

Desde el estado q1, si leemos un guión bajo \_, vamos al estado q2.

Desde el estado q3, si leemos un guión bajo \_, vamos al estado q2.

Desde el estado q3, si leemos un dígito cualquiera (0-9), vamos al estado q1.

Desde el estado q2, cualquier entrada nos lleva al estado de error q2.

**Enteros:**

Empezamos convirtiendo la expresión regular en una en la que no haya símbolos \_. Para esto, podemos reemplazar cualquier aparición de [0-9]\_[0-9] por [0-9][0-9].

Entonces, la expresión regular equivalente es [0-9][0-9]\*[0-9]|[0-9].

Creamos el AFD con los siguientes estados:

Estado inicial: q0.

Estado final: q1.

Estado de error: q2.

Agregamos las transiciones del AFD:

Desde el estado q0, si leemos un dígito entre 1 y 9, vamos al estado q1.

Desde el estado q0, si leemos un 0, vamos al estado q3.

Desde el estado q1, si leemos un dígito cualquiera (0-9), nos quedamos en q1.

**Flotantes:**

Alfabeto: {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, +, -, ., E, e, \_}

Estados: {q0, q1, q2, q3, q4, q5, q6, q7, q8}

Transiciones:

q0 --' 0 --> q1

q0 --' cualquier dígito diferente de 0 --> q2

q1 --' . --> q3

q1 --' E, e --> q5

q2 --' . --> q4

q2 --' E, e --> q5

q2 --' cualquier dígito --> q2

q3 --' cualquier dígito --> q4

q3 --' E, e --> q5

q4 --' cualquier dígito --> q4

q4 --' E, e --> q5

q4 --' --> q8

q5 --' +, - --> q6

q5 --' cualquier dígito --> q7

q6 --' cualquier dígito --> q7

q7 --' cualquier dígito --> q7

q7 --' --> q8

Estado inicial: q0

Estado de aceptación: q2, q4, q7, q8

**Identificadores:**

Alfabeto: {a, b, c, ..., z, A, B, C, ..., Z, \_, $, á, é, í, ó, ú, Á, É, Í, Ó, Ú, ü, Ü, ñ, Ñ, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9}

Estados: {q0, q1, q2, q3}

Transiciones:

q0 --' letra, \_, $ --> q1

q1 --' letra, \_, $, número --> q1

q1 --' á, é, í, ó, ú, Á, É, Í, Ó, Ú, ü, Ü, ñ, Ñ --> q1

q1 --' número --> q2

q2 --' letra, \_, $, número --> q2

q2 --' á, é, í, ó, ú, Á, É, Í, Ó, Ú, ü, Ü, ñ, Ñ --> q2

q2 --' --> q3

Estado inicial: q0

Estado de aceptación: q3

**(g) Presentar el diagrama de transiciones del AFD obtenido** 

**Runas:**

![](images\Aspose.Words.de75a710-8edb-4870-bb15-8abf44ff58b6.001.png)

**Enteros:**

![](images\Aspose.Words.de75a710-8edb-4870-bb15-8abf44ff58b6.002.jpeg)

**Flotantes:**

![](images\Aspose.Words.de75a710-8edb-4870-bb15-8abf44ff58b6.003.png)

**Identificadores:**

![](images\Aspose.Words.de75a710-8edb-4870-bb15-8abf44ff58b6.004.png)

**(h) Realizar un programa en lex que genere los tokens correspondientes.**
