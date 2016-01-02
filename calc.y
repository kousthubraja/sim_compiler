%{
  void yyerror (char *s);
  #include "lex.yy.c"
  #include <stdio.h>

  int symbols[26];
%}

%token NUM
%token IDENTIFIER
%token print;

%%
program         : program statement
                    | statement;
statement       : print expr ';' {printf("%d\n", $2);}
                    | assignment;

assignment      : IDENTIFIER '=' expr ';' {symbols[$1] = $3;};

expr            : expr '*' expr {$$ = $1 * $3;}
                    | expr '-' expr {$$ = $1 - $3;}
                    | expr '+' expr {$$ = $1 + $3;}
                    | expr '/' expr {$$ = $1 / $3;}
                    | '(' expr ')' {$$ = $2;}
                    | IDENTIFIER {$$ = symbols[$1];}
                    |  NUM {$$ = $1;};
%%

int main(void){
  int i;
  for(i = 0 ; i <= 26 ; i++){
    symbols[i] = 0;
  }
  return yyparse();
  return 0;
}

void yyerror (char *s){
  fprintf(stderr, "%s\n", s);
}
