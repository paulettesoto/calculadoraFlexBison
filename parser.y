%{
#include "parser.tab.h"
#include <stdio.h>
#include <math.h>

//funciones
int is_integer(double num) { 		//numero entero
    return num == (int)num;
}

int yylex(void);
void yyerror(char *s);

double raiz(double num) {		//raiz cuadrada
    if (num < 0) {
        printf("Error: No se puede calcular la raíz cuadrada de un número negativo\n"); 
    }else
	return sqrt(num);
}

double valorAbsoluto(double num) {	//valor absoluto
    return fabs(num);
}
%}

//tokens
%token Plus Minus  Number Equal Mult Div Pow PR PL MOD SQRT ABS BitsL BitsR
%start input
%left Plus Minus
%left Mult Div
%right Pow
%right MOD

//reglas
%%
input : 
    		| input line {
        		if (is_integer($2)) {
            			printf("Resultado: %d\n", (int)$2);
        		} else {
            			printf("Resultado: %.2f\n", (double)$2);
        		}
    		}
    		;
line : Equal   
		| Exp Equal
		; 
Exp : Number 
		| Exp Plus Exp {$$ = $1 + $3;} 
		| Exp Minus Exp {$$ = $1 - $3;}
		| Exp Mult Exp {$$ = $1 * $3;}
							
		| Exp Div Exp {
						if($3 == 0){
							printf("Error: No se puede dividir por cero\n");
						}
						else
							$$ = $1 / $3;
						}
		| Exp Pow Exp {
						$$ = pow($1, $3);
						}
		| Exp MOD Exp {
						$$ = fmod($1, $3);
						}
		| SQRT Exp {
						if ($2 < 0) {
            						printf("Error: No se puede calcular raiz cuadrada de un numero negativo\n");
        					} else 
							$$ = raiz($2);
						}
		| ABS Exp ABS {
                    				$$ = valorAbsoluto($2);
                    				}
		| Exp BitsL Exp {$$ = $1 << $3;}
    		| Exp BitsR Exp {$$ = $1 >> $3;}
		| PL Exp PR {$$ = $2;}


%%

//error de sintaxis
void yyerror(char *s){
	printf ("Error: %s",s);
}

//final de entrada
int yywrap(){
	return 1;
}
//principal
int main(void){
	yyparse();
}

