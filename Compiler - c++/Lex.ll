%{
#include <iostream>
#include <string>
#include <cstdlib>
#include <cstdio>
using namespace std;
extern int yylex();
%}

/* Flex solo leerá un archivo de entrada */
%option noyywrap
/* Nos permitirá contar las líneas */
%option yylineno

/* Sección de Tokens */

GUIONES         [-_]
COMA            ","
PUNTO           "."
PUNTOYCOMA      ";"
ESPACIO         [ ]
DIGITO          [0-9]
LETRA           [a-zA-ZñÑáéíóúÁÉÍÓÚüÜ]
IDENTIFICADOR   {LETRA}({LETRA}|{DIGITO}|{GUIONES})*
ENT             {DIGITO}(_?{DIGITO}+)*
NOT             [Ee]([+-]?)?{ENT}
DEC             (({ENT}.({ENT})?|.{ENT})({NOT})?|{ENT}{NOT})[FfDd]
RUNA            '([^\\'\n]|(\\.))*'
CADENA          \"([^\"]|\\.)*\"

/* OPERADORES LÓGICOS Y ARITMÉTICOS BÁSICOS */

SUMA            "+"
RESTA           ["-"]
MULTIP          "*"
DIVIC           "/"
IGUAL           "="
MAYOR           ">"
MENOR           "<"
MAYORIGUAL      ">="
MENORIGUAL      "<="
NEGACION        "!"
DISTINTO        "!="
ESIGUAL         "=="

/* APERTURA, CERRADURA */

LLAVE_INI       "{"
LLAVE_FIN       "}"
PARENTESIS_I    "("
PARENTESIS_F    ")"

/* PALABRAS RESERVADAS */

RW_SI              ["si"|"SI"]
RW_MIENTRAS        ("mientras"|"MIENTRAS")
RW_ENTERO          ["entero"|"ENTERO"]
RW_DECIMAL         ["decimal"|"DECIMAL"]
RW_ESCRIBIR        ["escribir"|"ESCRIBIR"]

/*-----------------------------------------------*/
/*              SECCION DE REGLAS                */
/*-----------------------------------------------*/

%%

{GUIONES}       {cout << "\nGUIONES " << yytext;}
{COMA}          {cout << "\nCOMA " << yytext;}
{PUNTO}         {cout << "\nPUNTO " << yytext;}
{PUNTOYCOMA}    {cout << "\nPUNTOYCOMA " << yytext;}
{ESPACIO}       {cout << "\nESPACIO " << yytext;}
{DIGITO}        {cout << "\nDIGITO " << yytext;}
{LETRA}         {cout << "\nLETRA " << yytext;}
{IDENTIFICADOR} {cout << "\nIDENTIFICADOR " << yytext;}

{RUNA}          {cout << "\nRUNA " << yytext;}
{CADENA}        {cout << "\nCADENA " << yytext;}

{SUMA}          {cout << "\nSUMA " << yytext;}
{RESTA}         {cout << "\nRESTA " << yytext;}
{MULTIP}        {cout << "\nMULTIP " << yytext;}
{DIVIC}         {cout << "\nDIVIC " << yytext;}
{IGUAL}         {cout << "\nIGUAL " << yytext;}
{MAYOR}         {cout << "\nMAYOR " << yytext;}
{MENOR}         {cout << "\nMENOR " << yytext;}
{MAYORIGUAL}    {cout << "\nMAYORIGUAL " << yytext;}
{MENORIGUAL}    {cout << "\nMENORIGUAL " << yytext;}
{NEGACION}      {cout << "\nNEGACION " << yytext;}
{DISTINTO}      {cout << "\nDISTINTO " << yytext;}
{ESIGUAL}       {cout << "\nESIGUAL " << yytext;}

{LLAVE_INI}     {cout << "\nLLAVE_INI " << yytext;}
{LLAVE_FIN}     {cout << "\nLLAVE_FIN " << yytext;}
{PARENTESIS_I}  {cout << "\nPARENTESIS_I " << yytext;}
{PARENTESIS_F}  {cout << "\nPARENTESIS_F " << yytext;}

{RW_SI}            {cout << "\nRW_SI " << yytext;}  /* Cambiado a RW_SI */
{RW_MIENTRAS}      {cout << "\nRW_MIENTRAS " << yytext;}  /* Cambiado a RW_MIENTRAS */
{RW_ENTERO}        {cout << "\nRW_ENTERO " << yytext;}  /* Cambiado a RW_ENTERO */
{RW_DECIMAL}       {cout << "\nRW_DECIMAL " << yytext;}  /* Cambiado a RW_DECIMAL */
{RW_ESCRIBIR}      {cout << "\nRW_ESCRIBIR " << yytext;}  /* Cambiado a RW_ESCRIBIR */

{ENT}           {cout << "\nENT " << yytext;}
{NOT}           {cout << "\nNOT " << yytext;}
{DEC}           {cout << "\nDEC " << yytext;}
.               {cout << "\nError léxico: No es válido el caracter " << yytext << ". Adiós"; exit(1);}

%%

int main (int argc, char *argv[]) {
    if ((yyin = fopen(argv[1], "rt")) == nullptr) {
        cout << "\nNo se pudo abrir el archivo: " << argv[1] << "\n";
        return 1;
    } else {
        cout << "\nEl archivo " << argv[1] << " se abrió correctamente\n";
        yylex();
    }
    
    cout << "\nFLEX finalizó la lectura del archivo: " << argv[1] << "\n";
    fclose(yyin);
    return 0;
}
