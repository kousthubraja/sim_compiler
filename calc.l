%{
  #include "y.tab.h"
  int number;
%}

%%

[0-9]+      {
              number = atoi(yytext);
              yylval = makeLeafNode(number);
              return NUM;
            }

[*+-/()\n]  return *yytext;
.         yyerror("Invalid syntax");

%%

int yywrap(void){
  return 1;
}
