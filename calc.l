%{
  #include "y.tab.h"
  extern int yylval;
%}

digit [0-9]

%%

{digit}+ {yylval = atoi(yytext); return NUM;}
[*+\n] {return *yytext;}
. {}

%%
