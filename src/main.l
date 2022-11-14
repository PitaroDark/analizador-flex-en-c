%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <conio.h>
    /* definiciones de las constantes de manifiesto
    LT, LE, EQ, NE, GT, GE,
    IF, THEN, ELSE, ID, NUMERO, OPREL */
    FILE *yyin;
%}

%option yylineno

/* definiciones regulares */
delim   [ \t\n]
INCLUDE {"#include"}
RETURN  {"return"}
OP_LT   ["<"]
OP_LE   "<="
OP_GT   [">"]
OP_GE   ">="
OP_EE   "=="
OP_EQ   ["="]
OP_NE   "<>"
L_PAREN ["("]
R_PAREN [")"]
L_KEY   ["{"]
R_KEY   ["}"]
STRING  {"([A-Z]|[a-z]|[" "]|["\"]|{digito})*"}
ws      {delim}+
letra   [A−Za−z]
digito  [0−9]
id      {letra}({letra}|{digito})*
numero  {digito}+(\.{digito}+)?(E[+−]?(digito)+)?

%%

{ws}        {/* no hay accion y no hay retorno */}
int         {printf("INT (%s)" ,yytext);}
if          {printf("IF (%s)" ,yytext);}
then        {printf("THEN (%s)" ,yytext);}
else        {printf("ELSE (%s)" ,yytext);}
{id}        {yylval = (int) instalarID(); return(ID);}
{numero}    {yylval = (int) instalarNum(); return(NUMERO);}
"<"         {yylval = "<"; return(OPREL);}
"<="        {yylval = OP_LE; return(OPREL);}
"="         {yylval = OP_EQ; return(OPREL);}
"<>"        {yylval = OP_NE; return(OPREL);}
">"         {yylval = OP_GT; return(OPREL);}
">="        {yylval = OP_GE; return(OPREL);}
"=="        {yylval = OP_EE; return(OPREL);}
"("         {yylval = L_PAREN; return(OPREL);}
")"         {yylval = R_PAREN; return(OPREL);}
"{"         {yylval = L_KEY; return(OPREL);}
"}"         {yylval = R_KEY; return(OPREL);}
"\n"
"\t"
.           yyerror();//No encuentra algun patron

%%

int main(int argc, int argv[]){ 
    //Abrimos el archivo
    if((yyin = fopen(argv[1], "rt")) == NULL){
        printf("No se logro abrir el archivo '%s'\n", argv[1]);
        return 1;
    }
    else{
        printf("El archivo '%s' se abrio correctamente\n", argv[1]);
        yylex();
    }
    puts("Flex Finalizo con la lectura del archivo");
    fclose(yyin);
    return 0;
}

int instalarID() {
    /* funcion para instalar el lexema en
    la tabla de sı ́mbolos y devolver un
    apuntador a esto; yytext apunta al
    primer caracter y yylent es
    la longitud */
    
    return 0;
}

int instalarNum() {
    /* similar a instalarID, pero coloca las
    constantes numericas en una tabla separada */
    return 0;
}

int yyerror(void){
    printf("Error lexico:\nCaracter invalido o no implementado -> '%s', saliendo...\n", yytext);
    exit(1);
}