%{
  #include <stdio.h>
  #include "y.tab.h"
  #include <stdlib.h>

  int number;
%}

%%

[0-9]+      {
              number = atoi(yytext);
              yylval = makeLeafNode(number);
              return NUM;
            }
read        {return READ;}
write       {return WRITE;}
[a-z]       {
              yylval=makeLeafNode(yytext[0]-'a');
              return ID;
            }
[*+-/()=;\n]  return *yytext;
[ \t]       return;
.         yyerror("Invalid syntax");

%%

int yywrap(void){
  return 1;
}
