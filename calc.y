%{
  void yyerror (char *s);

  #include <stdio.h>
  #include <stdlib.h>

  #define YYSTYPE Node*
  #include "exptree.h"
  #include "exptree.c"

  #include "lex.yy.c"
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%
program         : program statement
                    | statement;
statement       :  expr '\n' {printf("%d\n", eval($1));}
                    | '\n';

expr            : expr '*' expr {$$ = makeOperatorNode('*',$1,$3);}
                  | expr '-' expr {$$ = makeOperatorNode('-',$1,$3);}
                  | expr '+' expr {$$ = makeOperatorNode('+',$1,$3);}
                  | expr '/' expr {$$ = makeOperatorNode('/',$1,$3);}
                  | '(' expr ')' {$$ = $2;}
                  |  NUM {$$ = $1;};
%%

int main(void){
  return yyparse();
  return 0;
}

void yyerror (char *s){
  fprintf(stderr, "%s\n", s);
}
