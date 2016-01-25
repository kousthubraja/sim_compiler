%{
  void yyerror (char *s);

  #include <stdio.h>
  #include <stdlib.h>

  #define YYSTYPE Node*
  #include "exptree.h"
  #include "exptree.c"

  #include "lex.yy.c"

  int symbols[26];

%}

%token NUM
%token ID
%token READ
%token WRITE
%left '+' '-'
%left '*' '/'

%%

program         : program '\n' slist | slist;
slist           : slist statement | statement | '\n';
statement       : expr ';' {printf("%d\n", eval($1));}
                    | assignment ';'
                    | READ '(' ID ')' ';' {scanf("%d",&symbols[$3->val]);}
                    | WRITE '(' expr ')' ';' {printf("%d\n", eval($3));}
                    | ';';
assignment      :  ID '=' expr  {
                      symbols[$1->val] = eval($3);
                      };
expr            : expr '*' expr {$$ = makeOperatorNode('*',$1,$3);}
                  | expr '-' expr {$$ = makeOperatorNode('-',$1,$3);}
                  | expr '+' expr {$$ = makeOperatorNode('+',$1,$3);}
                  | expr '/' expr {$$ = makeOperatorNode('/',$1,$3);}
                  | '(' expr ')' {$$ = $2;}
                  |  NUM {$$ = $1;}
                  | ID {$$ = makeLeafNode(symbols[$1->val]);};
%%

int main(void){
  int i;
  for(i=0; i <= 26; i++)
    symbols[i] = 0;

  return yyparse();
  return 0;
}

void yyerror (char *s){
  fprintf(stderr, "%s\n", s);
}
