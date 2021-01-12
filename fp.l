%{
#include "y.tab.h"
%}
letter [a-z]
digit [0-9]
number ([0]|[1-9]{digit}*|[-][1-9]{digit}*)
ID {letter}({letter}|{digit}|[-])*
%%
"\t"|"\n"|"\r"|" " {;}
"print-num" {yylval.word=strdup(yytext);return(PRINTNUM);}
"print-bool" {yylval.word=strdup(yytext);return(PRINTBOOL);}
"#t" {yylval.word=strdup(yytext);return(BOOLVAL);}
"#f" {yylval.word=strdup(yytext);return(BOOLVAL);}
"(" {yylval.word=strdup(yytext);return(LP);}
")" {yylval.word=strdup(yytext);return(RP);}
"+" {yylval.word=strdup(yytext);return(PLUS);}
"-" {yylval.word=strdup(yytext);return(MINUS);}
"*" {yylval.word=strdup(yytext);return(MULTIPLY);}
"/" {yylval.word=strdup(yytext);return(DIVIDE);}
"mod" {yylval.word=strdup(yytext);return(MODULUS);}
">" {yylval.word=strdup(yytext);return(GREATER);}
"<" {yylval.word=strdup(yytext);return(SMALLER);}
"=" {yylval.word=strdup(yytext);return(EQUAL);}
"and" {yylval.word=strdup(yytext);return(AND);}
"or" {yylval.word=strdup(yytext);return(OR);}
"not" {yylval.word=strdup(yytext);return(NOT);}
"define" {yylval.word=strdup(yytext);return(DEFINE);}
"fun" {yylval.word=strdup(yytext);return(FUN);}
"if" {yylval.word=strdup(yytext);return(IF);}
{number} {yylval.word=strdup(yytext);return(NUMBER);}
{ID} {yylval.word=strdup(yytext);return(ID);}
. {return(yytext[0]);}
%%
