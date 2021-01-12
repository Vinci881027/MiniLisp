%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char *equal_val;
struct varStack{
    char *name;
    char *value;
    struct varStack *next;
};
struct varStack *top = NULL;
int yylex(void);
void yyerror(const char*);
%}
%union{
    char *word;
}
%token <word> PRINTNUM
%token <word> PRINTBOOL
%token <word> NUMBER
%token <word> ID
%token <word> BOOLVAL
%token <word> LP
%token <word> RP
%token <word> PLUS
%token <word> MINUS
%token <word> MULTIPLY
%token <word> DIVIDE
%token <word> MODULUS
%token <word> GREATER
%token <word> SMALLER
%token <word> EQUAL
%token <word> AND
%token <word> OR
%token <word> NOT
%token <word> DEFINE
%token <word> FUN
%token <word> IF
%type <word> program
%type <word> stmts
%type <word> stmt
%type <word> print_stmt
%type <word> exp
%type <word> num_op
%type <word> plus
%type <word> plus_exp
%type <word> minus
%type <word> multiply
%type <word> multiply_exp
%type <word> divide
%type <word> modulus
%type <word> greater
%type <word> smaller
%type <word> equal
%type <word> equal_exp
%type <word> logical_op
%type <word> and_op
%type <word> and_exp
%type <word> or_op
%type <word> or_exp
%type <word> not_op
%type <word> def_stmt
%type <word> variable
%type <word> fun_exp
%type <word> fun_ids
%type <word> fun_ids_exp
%type <word> fun_body
%type <word> fun_call
%type <word> param
%type <word> fun_name
%type <word> if_exp
%type <word> test_exp
%type <word> then_exp
%type <word> else_exp
%%
// program
program: stmts
    ;
stmts: stmts stmt
    | stmt
    ;
stmt: exp
    | def_stmt
    | print_stmt
    ;
// print
print_stmt: LP PRINTNUM exp RP {printf("%s\n", $3);}
    | LP PRINTBOOL exp RP {printf("%s\n", $3);}
    ;
// expression
exp: BOOLVAL
    | NUMBER
    | variable {
        struct varStack *temp = top;
        while(temp != NULL){
            if(strcmp(temp->name, $1) == 0)
                break;
            else
                temp = temp->next;
        }
        $$ = temp->value;
    }
    | num_op
    | logical_op
    | fun_exp
    | fun_call
    | if_exp
    ;
// numerical operations
num_op: plus
    | minus
    | multiply
    | divide
    | modulus
    | greater
    | smaller
    | equal
    ;
plus: LP PLUS plus_exp RP {$$ = $3;}
    ;
plus_exp: plus_exp exp {sprintf($$, "%d", atoi($1) + atoi($2));}
    | exp exp {sprintf($$, "%d", atoi($1) + atoi($2));}
    ;
minus: LP MINUS exp exp RP {sprintf($$, "%d", atoi($3) - atoi($4));}
    ;
multiply: LP MULTIPLY multiply_exp RP {$$ = $3;}
    ;
multiply_exp: multiply_exp exp {sprintf($$, "%d", atoi($1) * atoi($2));}
    | exp exp {sprintf($$, "%d", atoi($1) * atoi($2));}
    ;
divide: LP DIVIDE exp exp RP {sprintf($$, "%d", atoi($3) / atoi($4));}
    ;
modulus: LP MODULUS exp exp RP {sprintf($$, "%d", atoi($3) % atoi($4));}
    ;
greater: LP GREATER exp exp RP {if(atoi($3) > atoi($4))$$ = "#t";else $$ = "#f";}
    ;
smaller: LP SMALLER exp exp RP {if(atoi($3) < atoi($4))$$ = "#t";else $$ = "#f";}
    ;
equal: LP EQUAL equal_exp RP {$$ = $3;}
    ;
equal_exp: equal_exp exp {
        if(strcmp($1, "#t") == 0){
            if(strcmp($2, equal_val) == 0)
                $$ = "#t";
            else
                $$ = "#f";
        }
        else
            $$ = "#f";
    }
    | exp exp {if(atoi($1) == atoi($2)){$$ = "#t";equal_val = $1;}else{$$ = "#f";equal_val = "#f";}}
    ;
// logical operations
logical_op: and_op
    | or_op
    | not_op
    ;
and_op: LP AND and_exp RP {if(strcmp($3, "#f") == 0)$$ = "#f";else $$ = "#t";}
    ;
and_exp: and_exp exp {if(strcmp($1, "#f") == 0 || strcmp($2, "#f") == 0)$$ = "#f";}
    | exp exp {if(strcmp($1, "#f") == 0 || strcmp($2, "#f") == 0)$$ = "#f";}
    ;
or_op: LP OR or_exp RP {if(strcmp($3, "#t") == 0)$$ = "#t";else $$ = "#f";}
    ;
or_exp: or_exp exp {if(strcmp($1, "#t") == 0 || strcmp($2, "#t") == 0)$$ = "#t";}
    | exp exp {if(strcmp($1, "#t") == 0 || strcmp($2, "#t") == 0)$$ = "#t";}
    ;
not_op: LP NOT exp RP {$$ = (strcmp($3, "#t") == 0) ? "#f" : "#t";}
    ;
// define statement
def_stmt: LP DEFINE ID exp RP {
        struct varStack *temp = top;
        while(temp != NULL){
            if(strcmp($3, temp->name) == 0){
                yyerror("error: redefinition");
                break;
            }
            else
                temp = temp->next;
        }
        if(temp == NULL){
            struct varStack *s = (struct varStack*)malloc(sizeof(struct varStack));
            s->name = $3;
            s->value = $4;
            s->next = top;
            top = s;
        }
    }
    ;
variable: ID
    ;
// function
fun_exp: LP FUN fun_ids fun_body RP
    ;
fun_ids: LP fun_ids_exp RP
    | LP RP
    ;
fun_ids_exp: fun_ids_exp ID
    | ID
    ;
fun_body: exp
    ;
fun_call: LP fun_exp param RP
    | LP fun_exp RP
    | LP fun_name param RP
    | LP fun_name RP
    ;
param: param exp
    | exp
    ;
fun_name: ID
    ;
// if expression
if_exp: LP IF test_exp then_exp else_exp RP {
        if(strcmp($3, "#t") == 0)
            $$ = $4;
        else
            $$ = $5;
    }
    ;
test_exp: exp
    ;
then_exp: exp
    ;
else_exp: exp
    ;
%%
void yyerror(const char *message){
    fprintf(stderr, "%s\n", message);
}
int main(int argc, char *argv[]){
    yyparse();
    return(0);
}
