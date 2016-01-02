%{
  void yyerror (char *s);
  #include "lex.yy.c"
%}

%token NUM

%%
pgm     : expr '\n' {printf("%d\n", $1); exit(0);};
expr    : expr '+' expr {$$ = $1 + $3;};
expr    : NUM {$$ = $1;};
%%

int main(void){
  return yyparse();
}

void yyerror (char *s){
  fprintf(stderr, "%s\n", s);
}
