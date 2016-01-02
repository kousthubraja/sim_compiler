%{
  #include "y.tab.h"
  extern int yylval;
%}

%%

[0-9]+      {
              yylval = atoi(yytext);
              return NUM;
            }
[a-z]       {
              yylval = yytext[0] - 'a';
              return IDENTIFIER;
            }

[*+-/()=;]  return *yytext;
[ \t\n]     ;
print       return print;
.         yyerror("Invalid syntax");

%%

int yywrap(void){
  return 1;
}
