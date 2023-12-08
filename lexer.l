%{
	#include "parser.tab.h" //archivo generado bison
	#include <stdlib.h>
%}

Num [0-9]
blank [ \t\n]+ 

%%
{Num}+ {yylval = atoi(yytext);		//secuencia
		return(Number);}
"+"	{return(Plus); }		//suma
"-"	{return(Minus);}	//resta
"="	{return(Equal);}	//igual
"*"	{return(Mult);}		//multiplicacion
"/"    	{return(Div);}		//division
"**"    {return(Pow);}		//exponente
"("	{return(PL);}		//parentesis
")"    	{return(PR);}
"mod"	{return(MOD);}		//mod - residuo
"sqrt"	{return(SQRT);}		//raiz cuadrada
"|"     {return ABS;} 		//valor absoluto
"<<"	{return(BitsL);}	//corrimiento de bits
">>"	{return(BitsR);}
{blank} {;}
.	   {printf(" %c\n",yytext[0]); }

%%