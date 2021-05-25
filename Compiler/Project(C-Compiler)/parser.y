/*******************************************************************/
//	
//		Creator:‌ Sara Baradaran, Mahdi Heidari
//		Creation Date:‌ Jan 2020
//		Project Title: C to MIPS assembly compiler
//		
/*******************************************************************/


%{

	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <math.h>
	extern int yylex();
	int yyparse();
	FILE* yyin;
	FILE* symbol;
	FILE* output;
	char output_name[100];
	void yyerror(const char* s);
	struct node
	{
		int value;
		char* name;
		char* reg;
		char* scope;
		struct node* next;
	};
	struct fnode
	{
		char* name;
		int arg_num;
		char* outputtype;
		struct fnode* next;
	};
	struct fnode* finsert(struct fnode** ffirst, struct fnode** flast, char* name);
	struct fnode* flookup(struct fnode* ffirst, char* name);

	struct node* insert(struct node** first, struct node** last, char* name, char type);
	struct node* lookup(struct node* first, char* name);
	void set_value(struct node*x, int value);
	void print(struct node* first);
	struct node* first;
	struct node* last;
	struct fnode* ffirst;
	struct fnode* flast;
	void pushStack(char* reg);
	char* popStack();
	char stack[30][8];
	int stackSize;
	char t_registers[10][4] = {"$t0","$t1","$t2","$t3","$t4","$t5","$t6","$t7","$t8","$t9"};
	_Bool t_state[10] = {0,0,0,0,0,0,0,0,0,0};
	char s_registers[8][4] = {"$s0","$s1","$s2","$s3","$s4","$s5","$s6","$s7"};
	_Bool s_state[8] = {0,0,0,0,0,0,0,0};
	char a_registers[4][4] = {"$a0","$a1","$a2","$a3"};
	_Bool a_state[4] = {0,0,0,0};
	int label_num;
	int loop_num;
	int GetFreeRegister(char registerSet);
	void SetFreeRegister(char* reg_name);
	char* itos(int i);
	char* currentScope;
	void removeScopeVariables(struct node** first ,struct node** last, char* scope_name);
	_Bool ISNUMBER(char* reg);
	_Bool anyerror;
	
%}

%union{
	int ival;
	char* sval;
}

%left OPENA CLOSEA 
%left ASSIGN
%left BLE BGE BLT BGT
%left EQUAL NOTEQUAL
%left MINUS PLUS
%left MUL DIV
%left AND OR
%left BITAND BITOR
%left NOT
%left OPENP CLOSEP
%left OPENB CLOSEB

%token SEMICOLON COMMA PRINT BACKN
%token VOID INT IF RETURN WHILE GLOBAL ELSE 

%nterm <ival> exp
%token <ival> NUM
%token <sval> ID
%nterm <ival> ident
%nterm <ival> farg
%nterm <ival> agrumans
%nterm <sval> type
%start program
%%
program : globalvar;
		
	
globalvar:

		{currentScope = (char*)malloc(sizeof(char)*7); strcpy(currentScope, "global");} 
		GLOBAL INT ID ASSIGN exp SEMICOLON 
		{
		
			struct node* x = insert(&first, &last, $4, 's');
			printf("%s added to symbol table\n", $4);										
			set_value(x, $6);
			char* srcreg = (char*)malloc(sizeof(char)*8);
			strcpy(srcreg, popStack());
			output = fopen(output_name, "a+");
			
			if(ISNUMBER(srcreg))
				fprintf(output, "\taddi %s, $zero, %s \n", x->reg, srcreg);
			else{
				fprintf(output, "\tmove %s, %s \n", x->reg, srcreg);
				if(srcreg[1] == 't')
					SetFreeRegister(srcreg);
			}

			fclose(output);
			free(srcreg);
		} globalvar {free(currentScope);}
		| function ;
		
	
		
function: 
		| type ID
		{
			currentScope = (char*)malloc(sizeof(char)*(strlen($2)+7));
			strcpy(currentScope, $2);
		
			output = fopen(output_name, "a+");
			fprintf(output, "%s:\n", $2);
			if(strcmp($2,"main") != 0){
				fprintf(output, "\taddi $sp, $sp , -32\n");
				for(int i=0; i<=7; i++)
					fprintf(output, "\tsw $s%d, %d($sp)\n", i, i*4);
			}
			
			fclose(output);
			
		} OPENP farg
		{
			struct fnode* x = finsert(&ffirst, &flast, $2);
			x->arg_num = $5;
			strcpy(x->outputtype, $1);
			
		
		} CLOSEP OPENA stmt
		{
			output = fopen(output_name, "a+");
			if(strcmp($2,"main") != 0){
				for(int i=0; i<=7; i++)
					fprintf(output, "\tlw $s%d, %d($sp)\n", i, i*4);
				fprintf(output, "\taddi $sp, $sp , 32\n");	
				fprintf(output, "\tjr $ra\n");
			}
			else
				fprintf(output, "\tli $v0, 10\n\tsyscall\n");	
			fclose(output);
		}
		CLOSEA{ print(first); removeScopeVariables(&first, &last, $2); free(currentScope); } function ;
		
array_var : 	OPENB CLOSEB | ;


type : 	  	VOID {$$ = "void";} | INT {$$ = "int";};



farg:	  	{$$ = 0;}
		| INT ID array_var{$$ = 1; 
			
			insert(&first, &last, $2, 'a');
			
		}
		| INT ID array_var COMMA INT ID array_var{$$ = 2;
			
			insert(&first, &last, $2, 'a');
			insert(&first, &last, $6, 'a');
		
		}
		| INT ID array_var COMMA INT ID array_var COMMA INT ID array_var {$$ = 3;
		
			insert(&first, &last, $2, 'a');
			insert(&first, &last, $6, 'a');
			insert(&first, &last, $10, 'a');
		}
		| INT ID array_var COMMA INT ID array_var COMMA INT ID array_var COMMA INT ID array_var  {$$ = 4;
		
			insert(&first, &last, $2, 'a');
			insert(&first, &last, $6, 'a');
			insert(&first, &last, $10, 'a');
			insert(&first, &last, $14, 'a');
		};

agrumans:
		{$$ = 0;}
		| exp COMMA exp COMMA exp COMMA exp {$$ =4;}
		| exp COMMA exp COMMA exp {$$ =3;}
		| exp COMMA exp {$$ =2;}
		| exp {$$ =1;};
		
stmt :	
		| loop
		| condition
		| var_declaration
		| function_return
		| function_call
		| assign_value
		| array_declaration
		| array_assign_value
		| print;

print:	
		PRINT OPENP exp CLOSEP SEMICOLON
		{
			
			char* srcreg = (char*)malloc(sizeof(char)*8);
			strcpy(srcreg, popStack());
			output = fopen(output_name, "a+");
			
			if(strcmp(currentScope, "main") != 0){
				fprintf(output, "\taddi $sp, $sp , -4\n");
				fprintf(output, "\tsw $a0, 0($sp)\n");
				
			}
			
			if(ISNUMBER(srcreg))
				fprintf(output, "\taddi $a0, $zero, %s \n", srcreg);
				
			else
				fprintf(output, "\tmove $a0, %s \n", srcreg);
				
			fprintf(output, "\tli $v0, 1\n\tsyscall\n");
			
			if(strcmp(currentScope, "main") != 0){
			
				fprintf(output, "\tlw $a0, 0($sp)\n");
				fprintf(output, "\taddi $sp, $sp , 4\n");
				
			}
			free(srcreg);
			fclose(output);
		
		}stmt;
		| PRINT OPENP BACKN CLOSEP SEMICOLON
		{
			
			output = fopen(output_name, "a+");	
			if(strcmp(currentScope, "main") != 0){
				fprintf(output, "\taddi $sp, $sp , -4\n");
				fprintf(output, "\tsw $a0, 0($sp)\n");
				
			}
				
			fprintf(output, "\tla $a0, backn\n\tli $v0, 4\n\tsyscall\n");
			
			if(strcmp(currentScope, "main") != 0){
			
				fprintf(output, "\tlw $a0, 0($sp)\n");
				fprintf(output, "\taddi $sp, $sp , 4\n");
			}
			fclose(output);
		
		}stmt;
		
		
array_assign_value:

		ID OPENB exp CLOSEB ASSIGN exp SEMICOLON
		{
			struct node* x = lookup(first,$1);
			if(x == NULL){
			
				char error[30] = "undefined array ";
				strcat(error, $1);
				yyerror(error);
				YYERROR;
			}
			else{
			
				output = fopen(output_name, "a+");
				char* srctreg1 = (char*)malloc(sizeof(char)*8);
				char* srctreg2 = (char*)malloc(sizeof(char)*8);
				
				strcpy(srctreg2, popStack());
				strcpy(srctreg1, popStack());
			
				int no = GetFreeRegister('t');
				char treg1[4] = "$t";
				strcat(treg1, itos(no));
				
				
				no = GetFreeRegister('t');
				char treg2[4] = "$t";
				strcat(treg2, itos(no));
				
				output = fopen(output_name, "a+");
				if(ISNUMBER(srctreg1) && ISNUMBER(srctreg2)){
					fprintf(output, "\taddi %s, $zero , %s\n", treg1, srctreg2);
					fprintf(output, "\tsw %s, %d(%s)\n", treg1, atoi(srctreg1)*4, x->reg);
				}
				else if(ISNUMBER(srctreg1) ){
				
					fprintf(output, "\tsw %s, %d(%s)\n", srctreg2, atoi(srctreg1)*4, x->reg);
				}
				else if(ISNUMBER(srctreg2)){

					fprintf(output, "\tsll %s, %s , 2\n", treg1, srctreg1);
					fprintf(output, "\tadd %s, %s , %s\n", treg1, treg1, x->reg);
					fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg2);
					fprintf(output, "\tsw %s, 0(%s)\n", treg2, treg1);
				}
				else{
					
					fprintf(output, "\tsll %s, %s , 2\n", treg1, srctreg1);
					fprintf(output, "\tadd %s, %s , %s\n", treg1, treg1, x->reg);
					fprintf(output, "\tsw %s, 0(%s)\n", srctreg2, treg1);
				}
				SetFreeRegister(treg1);
				SetFreeRegister(treg2);
				fclose(output);
			
			}
		} stmt ;
		
array_declaration:

		INT ID OPENB exp CLOSEB SEMICOLON
		{
			struct node* x = insert(&first, &last, $2, 's');
			printf("%s array added to symbol table\n", $2);
			
			char* srcreg = (char*)malloc(sizeof(char)*8);
			strcpy(srcreg, popStack());
			output = fopen(output_name, "a+");

			if(strcmp(currentScope, "main")!=0){
			
				fprintf(output, "\taddi $sp, $sp , -4\n");
				fprintf(output, "\tsw $a0, 0($sp)\n");
			}
			if(ISNUMBER(srcreg)){
				fprintf(output, "\taddi $a0, $zero, %d \n", atoi(srcreg)*4);	
			}
				
			else{
				fprintf(output, "\tsll $a0, %s , 2\n", srcreg);
				if(srcreg[1] == 't')
					SetFreeRegister(srcreg);

			}
			fprintf(output, "\tli $v0, 9 \n\tsyscall\n");
			fprintf(output, "\tmove %s, $v0\n", x->reg);
			
			if(strcmp(currentScope, "main")!=0){
			
				fprintf(output, "\tlw $a0, 0($sp)\n");
				fprintf(output, "\taddi $sp, $sp , 4\n");
			}
			fclose(output);
			free(srcreg);
		} stmt;		
		
assign_value:
	
		ID ASSIGN exp SEMICOLON
		{
			struct node* x = lookup(first, $1); 
			if(x == NULL)
			{	
				char error[30] = "undefined variable ";
				strcat(error, $1);
				yyerror(error);
				YYERROR;
			}											
			set_value(x, $3);
			printf("%s variable has new value %d\n", x->name, x->value);

			char* srcreg = (char*)malloc(sizeof(char)*8);
			strcpy(srcreg, popStack());
			output = fopen(output_name, "a+");
			
			if(ISNUMBER(srcreg))
				fprintf(output, "\taddi %s, $zero, %s \n", x->reg, srcreg);
			else{
				fprintf(output, "\tmove %s, %s \n", x->reg, srcreg);
				if(srcreg[1] == 't')
					SetFreeRegister(srcreg);
			}

			fclose(output);
			free(srcreg);

		}stmt ;
		
var_declaration:
	
		INT ID ASSIGN exp SEMICOLON 
		{	
			struct node* x = insert(&first, &last, $2, 's');
			printf("%s added to symbol table\n", $2);										
			set_value(x, $4);
			printf("%s variable has new value %d\n", x->name, x->value);

			char* srcreg = (char*)malloc(sizeof(char)*8);
			strcpy(srcreg, popStack());
			output = fopen(output_name, "a+");
			
			if(ISNUMBER(srcreg))
				fprintf(output, "\taddi %s, $zero, %s \n", x->reg, srcreg);
			else{
				fprintf(output, "\tmove %s, %s \n", x->reg, srcreg);
				if(srcreg[1] == 't')
					SetFreeRegister(srcreg);
			}

			fclose(output);
			free(srcreg);
		}stmt ;
		
function_call:	
		
		ID OPENP agrumans
		{
			struct fnode* x = flookup(ffirst, $1);
			if(x == NULL){
				
				char error[30] = "undefined function ";
				strcat(error, $1);
				yyerror(error);
				YYERROR;
				
			}
			else{
				if(x->arg_num != $3){
				
					char error[40] = "to many function args in ";
					strcat(error, $1);
					yyerror(error);
					YYERROR;
				}
				else{
		
					output = fopen(output_name, "a+");
					char** arg = (char**)malloc(sizeof(char)*$3);
					for(int i=0; i<$3; i++)
						arg[i] = (char*)malloc(sizeof(char)*8);
						
					for(int i=$3-1; i>=0; i--)
						strcpy(arg[i], popStack());
					
					for(int i=0; i<$3; i++){
					
						if(ISNUMBER(arg[i]))
							fprintf(output, "\taddi $a%d, $zero , %s\n",i, arg[i]);		
						else					
							fprintf(output, "\tmove $a%d, %s\n",i, arg[i]);
					}
					
					for(int i=0; i<$3; i++)
						free(arg[i]);
					free(arg);	
					fprintf(output, "\tjal %s\n", $1);
					
					fclose(output);
					
				}
			}
		} CLOSEP SEMICOLON stmt 
		
		| ID ASSIGN ID OPENP agrumans
		{
			struct fnode* x = flookup(ffirst, $3);
			struct node* var = lookup(first, $1);
			if(x == NULL){
				
				char error[30] = "undefined function ";
				strcat(error, $3);
				yyerror(error);
				YYERROR;
				
			}
			else if(strcmp(x->outputtype , "int") != 0){
			
				yyerror("void function has no output");
			}
			else if(var == NULL){
			
				char error[30] = "undefined variable ";
				strcat(error, $1);
				yyerror(error);
				YYERROR;
			}
			else{
				if(x->arg_num != $5){
				
					char error[40] = "to many function args in ";
					strcat(error, $3);
					yyerror(error);
					YYERROR;
				}
				else{
		
					output = fopen(output_name, "a+");
					char** arg = (char**)malloc(sizeof(char)*$5);
					for(int i=0; i<$5; i++)
						arg[i] = (char*)malloc(sizeof(char)*8);
						
					for(int i=$5-1; i>=0; i--)
						strcpy(arg[i], popStack());
					
					for(int i=0; i<$5; i++){
					
						if(ISNUMBER(arg[i]))
							fprintf(output, "\taddi $a%d, $zero , %s\n",i, arg[i]);		
						else						
							fprintf(output, "\tmove $a%d, %s\n",i, arg[i]);
					}
					for(int i=0; i<$5; i++)
						free(arg[i]);
					free(arg);	
					fprintf(output, "\tjal %s\n", $3);
					fprintf(output, "\tmove %s, $v0\n", var->reg);
					
					fclose(output);
				}
			}
		} CLOSEP SEMICOLON stmt 
		
		| INT ID ASSIGN ID OPENP agrumans
		{
			struct fnode* x = flookup(ffirst, $4);
			struct node* var = insert(&first, &last, $2, 's');
			if(x == NULL){
				
				char error[30] = "undefined function ";
				strcat(error, $4);
				yyerror(error);
				YYERROR;
				
			}
			else if(strcmp(x->outputtype , "int") != 0){
			
				yyerror("void function has no output");
			}
			else{
				if(x->arg_num != $6){
				
					char error[40] = "to many function args in ";
					strcat(error, $4);
					yyerror(error);
					YYERROR;
				}
				else{
		
					output = fopen(output_name, "a+");
					char** arg = (char**)malloc(sizeof(char)*$6);
					for(int i=0; i<$6; i++)
						arg[i] = (char*)malloc(sizeof(char)*8);
						
					for(int i=$6-1; i>=0; i--)
						strcpy(arg[i], popStack());
					
					for(int i=0; i<$6; i++){
					
						if(ISNUMBER(arg[i]))
							fprintf(output, "\taddi $a%d, $zero , %s\n",i, arg[i]);		
						else						
							fprintf(output, "\tmove $a%d, %s\n",i, arg[i]);
					}
					for(int i=0; i<$6; i++)
						free(arg[i]);
					free(arg);	
					fprintf(output, "\tjal %s\n", $4);
					fprintf(output, "\tmove %s, $v0\n", var->reg);
		
					
					fclose(output);
				}
			}
		} CLOSEP SEMICOLON stmt ;
		
function_return:	
	
		RETURN exp 
		{
			char* srcreg = (char*)malloc(sizeof(char)*8);										
			strcpy(srcreg, popStack());
			
			char vreg[4] = "$v0";
			
			output = fopen(output_name, "a+");
			
			if(ISNUMBER(srcreg))
				fprintf(output, "\taddi %s, $zero, %s \n",vreg , srcreg);
			else{
				fprintf(output, "\tmove %s, %s \n",vreg, srcreg);
				if(srcreg[1] == 't')
					SetFreeRegister(srcreg);
			}
			fclose(output);
		
		} SEMICOLON stmt ;
loop:								
		WHILE
		{
			loop_num++;
			output = fopen(output_name, "a+");
			fprintf(output, "LOOP%d: \n", loop_num);
			fclose(output);
			
		} OPENP exp 
		{
			char* destreg = (char*)malloc(sizeof(char)*8);
			strcpy(destreg, popStack());
			output = fopen(output_name, "a+");
			label_num++;
			fprintf(output, "\tbeq %s, $zero, L%d\n", destreg, label_num);
			fclose(output);
			strcpy(currentScope, strcat(currentScope,"_WHILE"));
			
		} 
		CLOSEP OPENA stmt CLOSEA
		{
			output = fopen(output_name, "a+");
			fprintf(output, "\tj LOOP%d\n", loop_num);
			fclose(output);

			output = fopen(output_name, "a+");
			fprintf(output, "L%d: \n", label_num);
			fclose(output);
			print(first); removeScopeVariables(&first, &last, currentScope);strcpy(currentScope, strtok(currentScope,"_"));
		}stmt ;
		
condition:	
		IF OPENP exp
		{
			char* destreg = (char*)malloc(sizeof(char)*8);
			strcpy(destreg, popStack());
			output = fopen(output_name, "a+");
			label_num++;
			fprintf(output, "\tbeq %s, $zero, L%d\n", destreg, label_num);
			
			strcpy(currentScope, strcat(currentScope,"_IF"));
			
			fclose(output);
			free(destreg);
		} CLOSEP scope
	

scope :

		OPENA stmt CLOSEA
		{
			output = fopen(output_name, "a+");
			fprintf(output, "\tL%d : \n", label_num);
			fclose(output);
		} {print(first); removeScopeVariables(&first, &last, currentScope);strcpy(currentScope, strtok(currentScope,"_"));}stmt

		| OPENA stmt CLOSEA 
		{	print(first); 
			removeScopeVariables(&first, &last, currentScope); 
			strcpy(currentScope, strtok(currentScope,"_"));
		} ELSE 
		{
			label_num++;
			output = fopen(output_name, "a+");
			fprintf(output, "\tj L%d\n", label_num);
			fprintf(output, "\tL%d : \n", label_num-1);
			strcpy(currentScope, strcat(currentScope,"_ELSE"));
			fclose(output);
		} OPENA stmt
		{	
			output = fopen(output_name, "a+");
			fprintf(output, "\tL%d : \n", label_num);
			fclose(output);
		} CLOSEA {print(first); removeScopeVariables(&first, &last, currentScope); strcpy(currentScope, strtok(currentScope,"_"));}stmt;


exp :	  	exp BLT exp		
		{
			if($1 < $3)
				$$ = 1;		
			else 
				$$ = 0;
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) < atoi(srctreg2));
			else if(r1){
			
				fprintf(output, "\taddi %s, $zero , %s\n", treg, srctreg1);
				fprintf(output, "\tslt %s, %s , %s \n", treg, treg, srctreg2);
			}
			else if(r2)
				fprintf(output, "\tslti %s, %s , %s \n", treg, srctreg1, srctreg2);
			else
				fprintf(output, "\tslt %s, %s , %s \n", treg, srctreg1, srctreg2);
				
			fclose(output);
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
		| exp BLE exp		
		{	
			if($1 <= $3)
				$$ = 1;	
			else 
				$$ = 0;
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) <= atoi(srctreg2));
			else if(r1)
				fprintf(output, "\tslti %s, %s , %s \n", treg, srctreg2, srctreg1);
			else if(r2){
			
				fprintf(output, "\taddi %s, $zero , %s\n", treg, srctreg2);
				fprintf(output, "\tslt %s, %s , %s \n", treg, treg, srctreg1);
			}
			else
				fprintf(output, "\tslt %s, %s , %s \n", treg, srctreg2, srctreg1);
			
			fprintf(output, "\txori %s , %s , 1\n", treg, treg);
			fclose(output);
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
		| exp BGT exp	
		{
			if($1 > $3)
				$$ = 1;		
			else 
				$$ = 0;
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) > atoi(srctreg2));
			else if(r1)
				fprintf(output, "\tslti %s, %s , %s \n", treg, srctreg2, srctreg1);
			else if(r2){
			
				fprintf(output, "\taddi %s, $zero , %s\n", treg, srctreg2);
				fprintf(output, "\tslt %s, %s , %s \n", treg, treg, srctreg1);
			}
			else
				fprintf(output, "\tslt %s, %s , %s \n", treg, srctreg2, srctreg1);
				
			fclose(output);
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
		| exp BGE exp
		{	
			if($1 >= $3)
				$$ = 1;
			else 
				$$ = 0;
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) >= atoi(srctreg2));
			else if(r1){
				fprintf(output, "\taddi %s, $zero , %s\n", treg, srctreg1);
				fprintf(output, "\tslt %s, %s , %s \n", treg, treg, srctreg2);
			}
			else if(r2)
				fprintf(output, "\tslti %s, %s , %s \n", treg, srctreg1, srctreg2);
			else
				fprintf(output, "\tslt %s, %s , %s \n", treg, srctreg1, srctreg2);
			
			fprintf(output, "\txori %s , %s , 1\n", treg, treg);			
			fclose(output);
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		
		}
		| exp NOTEQUAL exp	
		{	
			if($1 != $3)
				$$ = 1;	
			else 
				$$ = 0;
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg1[4] = "$t";
			strcat(treg1, itos(no));
			
			no = GetFreeRegister('t');
			char treg2[4] = "$t";
			strcat(treg2, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg1, atoi(srctreg1) != atoi(srctreg2));
			else if(r1){
				
				fprintf(output, "\taddi %s, $zero , %s\n", treg1, srctreg1);
				fprintf(output, "\tslt %s, %s , %s \n", treg1, treg1, srctreg2);
				
				fprintf(output, "\tslti %s, %s , %s \n", treg2, srctreg2, srctreg1);
				fprintf(output, "\tor %s , %s , %s\n", treg1, treg1, treg2);
			}
			else if(r2){
			
				fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg2);
				fprintf(output, "\tslt %s, %s , %s \n", treg2, treg2, srctreg1);
				
				fprintf(output, "\tslti %s, %s , %s \n", treg1, srctreg1, srctreg2);
				fprintf(output, "\tor %s , %s , %s\n", treg1, treg1, treg2);
			}
			else{
				fprintf(output, "\tslt %s, %s , %s \n", treg1, srctreg1, srctreg2);
				fprintf(output, "\tslt %s, %s , %s \n", treg2, srctreg2, srctreg1);
				fprintf(output, "\tor %s , %s , %s\n", treg1, treg1, treg2);
			}
			SetFreeRegister(treg2);	
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);		
			fclose(output);
			pushStack(treg1);
			free(srctreg1);
			free(srctreg2);
		
		}
		| exp EQUAL exp		
		{
			if($1 == $3)
				$$ = 1;	
			else
				$$ = 0;
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg1[4] = "$t";
			strcat(treg1, itos(no));
			
			no = GetFreeRegister('t');
			char treg2[4] = "$t";
			strcat(treg2, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg1, atoi(srctreg1) == atoi(srctreg2));
			else if(r1){
			
				fprintf(output, "\taddi %s, $zero , %s\n", treg1, srctreg1);
				fprintf(output, "\tslt %s, %s , %s \n", treg1, treg1, srctreg2);
				
				fprintf(output, "\tslti %s, %s , %s \n", treg2, srctreg2, srctreg1);
				fprintf(output, "\txor %s, %s , %s\n", treg1, treg1, treg2);	
			}
			else if(r2){
			
				fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg2);
				fprintf(output, "\tslt %s, %s , %s \n", treg2, treg2, srctreg1);
				
				fprintf(output, "\tslti %s, %s , %s \n", treg1, srctreg1, srctreg2);
				fprintf(output, "\txor %s, %s , %s\n", treg1, treg1, treg2);	
			
			}
			else{
				fprintf(output, "\tslt %s, %s , %s \n", treg1, srctreg1, srctreg2);
				fprintf(output, "\tslt %s, %s , %s \n", treg2, srctreg2, srctreg1);
				fprintf(output, "\txor %s, %s , %s\n", treg1, treg1, treg2);
			}
			SetFreeRegister(treg2);	
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg1);
			free(srctreg1);
			free(srctreg2);

		}
		| exp PLUS exp
		{ 
			$$ = $1 + $3;
				
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) + atoi(srctreg2));
			else if(r1)
				fprintf(output, "\taddi %s, %s , %s \n", treg, srctreg2, srctreg1);
			else if(r2)
				fprintf(output, "\taddi %s, %s , %s \n", treg, srctreg1, srctreg2);
			else
				fprintf(output, "\tadd %s, %s , %s \n", treg, srctreg1, srctreg2);
				
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}

		| exp MINUS exp
		{ 
			$$ = $1 - $3; 
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) - atoi(srctreg2));
			else if(r1){
				fprintf(output, "\tsub %s, $zero , %s", treg, srctreg2);
				fprintf(output, "\taddi %s, %s , %s \n", treg, treg, srctreg1);
			}
			else if(r2)
				fprintf(output, "\taddi %s, %s , -%s \n", treg, srctreg1, srctreg2);
			else
				fprintf(output, "\tsub %s, %s , %s \n", treg, srctreg1, srctreg2);
				
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
				  
		| exp MUL exp{ $$ = $1 * $3;
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) * atoi(srctreg2));
			else if(r1){
				
				fprintf(output, "\taddi %s, $zero , %s \n", treg, srctreg1);
				fprintf(output, "\tmul %s, %s , %s \n", treg, treg, srctreg2);
			}
			else if(r2){
			
				fprintf(output, "\taddi %s, $zero , %s \n", treg, srctreg2);
				fprintf(output, "\tmul %s, %s , %s \n", treg, srctreg1, treg);
			}
			else		
				fprintf(output, "\tmul %s, %s , %s \n", treg, srctreg1, srctreg2);
				
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
				  
		| exp DIV exp{
		
			if($3 == 0){
				yyerror("divide by zero");
				YYERROR;
			}
			
			$$ = $1 / $3;
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg, atoi(srctreg1) / atoi(srctreg2));
			else if(r1){
				
				fprintf(output, "\taddi %s, $zero , %s \n", treg, srctreg1);
				fprintf(output, "\tdiv %s, %s , %s \n", treg, treg, srctreg2);
			}
			else if(r2){
			
				fprintf(output, "\taddi %s, $zero , %s \n", treg, srctreg2);
				fprintf(output, "\tdiv %s, %s , %s \n", treg, srctreg1, treg);
			}
			else		
				fprintf(output, "\tdiv %s, %s , %s \n", treg, srctreg1, srctreg2);	
				
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
							
		| exp AND exp
		{ 	
			$$ = $1 && $3; 
			
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg1[4] = "$t";
			strcat(treg1, itos(no));
			
			no = GetFreeRegister('t');
			char treg2[4] = "$t";
			strcat(treg2, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg1, atoi(srctreg1) && atoi(srctreg2));
			else if(r1){
				fprintf(output, "\tslti %s, $zero , %s \n", treg1, srctreg1);
				fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg1);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, treg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				label_num++;
				fprintf(output, "\tbeq %s, $zero , L%d \n", treg1, label_num);
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg2);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\tL%d:\n", label_num);
			}
			else if(r2){
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg1);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg1);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				label_num++;
				fprintf(output, "\tbeq %s, $zero , L%d \n", treg1, label_num);
				fprintf(output, "\tslti %s, $zero , %s \n", treg1, srctreg2);
				fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg2);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, treg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\tL%d:\n", label_num);
			
			}
			else{
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg1);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg1);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				label_num++;
				fprintf(output, "\tbeq %s, $zero , L%d \n", treg1, label_num);
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg2);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\tL%d:\n", label_num);
			}
			SetFreeRegister(treg2);	
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg1);
			free(srctreg1);
			free(srctreg2);
			
		}
		| exp OR exp
		{ 
		
			$$ = $1 || $3; 
			
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg1[4] = "$t";
			strcat(treg1, itos(no));
			
			no = GetFreeRegister('t');
			char treg2[4] = "$t";
			strcat(treg2, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\taddi %s, $zero , %d \n", treg1, atoi(srctreg1) || atoi(srctreg2));
			else if(r1){
				fprintf(output, "\tslti %s, $zero , %s \n", treg1, srctreg1);
				fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg1);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, treg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				label_num++;
				fprintf(output, "\taddi %s, $zero , 1 \n", treg2);
				fprintf(output, "\tbeq %s, %s , L%d \n", treg2, treg1, label_num);
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg2);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\tL%d:\n", label_num);
			}
			else if(r2){
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg1);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg1);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				label_num++;
				fprintf(output, "\taddi %s, $zero , 1 \n", treg2);
				fprintf(output, "\tbeq %s, %s , L%d \n", treg2, treg1, label_num);
				fprintf(output, "\tslti %s, $zero , %s \n", treg1, srctreg2);
				fprintf(output, "\taddi %s, $zero , %s\n", treg2, srctreg2);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, treg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\tL%d:\n", label_num);
			
			}
			else{
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg1);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg1);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				label_num++;
				fprintf(output, "\taddi %s, $zero , 1 \n", treg2);
				fprintf(output, "\tbeq %s, %s , L%d \n", treg2, treg1, label_num);
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srctreg2);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srctreg2);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\tL%d:\n", label_num);
			}
			SetFreeRegister(treg2);
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg1);
			free(srctreg1);
			free(srctreg2);
			
		}
		| exp BITOR exp
		{ 
			$$ = $1 | $3; 
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\tori %s, $zero , %d \n", treg, atoi(srctreg1) | atoi(srctreg2));
			else if(r1)
				fprintf(output, "\tori %s, %s , %s \n", treg, srctreg2, srctreg1);
			else if(r2)
				fprintf(output, "\tori %s, %s , %s \n", treg, srctreg1, srctreg2);
			else		
				fprintf(output, "\tor %s, %s , %s \n", treg, srctreg1, srctreg2);	
				
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
		| exp BITAND exp
		{ 
			$$ = $1 & $3;
		
			output = fopen(output_name, "a+");
			char* srctreg1 = (char*)malloc(sizeof(char)*8);
			char* srctreg2 = (char*)malloc(sizeof(char)*8);
			
			strcpy(srctreg2, popStack());
			strcpy(srctreg1, popStack());
			
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			
			_Bool r1 = ISNUMBER(srctreg1);
			_Bool r2 = ISNUMBER(srctreg2);
			if(r1 && r2)
				fprintf(output, "\tandi %s, $zero , %d \n", treg, atoi(srctreg1) & atoi(srctreg2));
			else if(r1)
				fprintf(output, "\tandi %s, %s , %s \n", treg, srctreg2, srctreg1);
			else if(r2)
				fprintf(output, "\tandi %s, %s , %s \n", treg, srctreg1, srctreg2);
			else		
				fprintf(output, "\tand %s, %s , %s \n", treg, srctreg1, srctreg2);	
			
			fclose(output);
			if(srctreg1[1] == 't')
					SetFreeRegister(srctreg1);
			if(srctreg2[1] == 't')
					SetFreeRegister(srctreg2);	
			pushStack(treg);
			free(srctreg1);
			free(srctreg2);
		}
		| NOT exp			
		{
			$$ = !$2;
			char srcreg[10];
			strcpy(srcreg,popStack());
			if(ISNUMBER(srcreg)){
				if(atoi(srcreg) == 0)
					pushStack("1");
				else
					pushStack("0");
			}
			else{
				int no = GetFreeRegister('t');
				char treg1[4] = "$t";
				strcat(treg1, itos(no));
				
				no = GetFreeRegister('t');
				char treg2[4] = "$t";
				strcat(treg2, itos(no));
				
				output = fopen(output_name, "a+");
				fprintf(output, "\tslt %s, $zero , %s \n", treg1, srcreg);
				fprintf(output, "\tslt %s, %s , $zero \n", treg2, srcreg);
				fprintf(output, "\tor %s, %s , %s \n", treg1, treg1, treg2);
				fprintf(output, "\txori %s, %s , 1 \n", treg1, treg1);
				SetFreeRegister(treg2);	
				if(srcreg[1] == 't')
					SetFreeRegister(srcreg);
				pushStack(treg1);
				fclose(output);
			}
			
		
		}
		| OPENP exp CLOSEP	{$$ = $2;}
		| NUM				{$$ = $1; pushStack(itos($1));}
		| MINUS exp			
		{	
			$$ = -$2;
			char srcreg[10];
			strcpy(srcreg,popStack());
			if(ISNUMBER(srcreg)){
				char sign[2];
				strcpy(sign,"-");
				pushStack(strcat(sign, srcreg));
			}
			else{
				int no = GetFreeRegister('t');
				char treg[4] = "$t";
				strcat(treg, itos(no));
				
				output = fopen(output_name, "a+");
				fprintf(output, "\tsub %s, $zero , %s\n", treg, srcreg);
				pushStack(treg);
				fclose(output);
			}
			
		}
		| ID OPENB exp CLOSEB
		{
		
			char srcreg[10];
			strcpy(srcreg,popStack());			
		
			int no = GetFreeRegister('t');
			char treg[4] = "$t";
			strcat(treg, itos(no));
			struct node* x = lookup(first, $1);
			if(x == NULL){
			
				char error[30] = "undefined array ";
				strcat(error, $1);
				yyerror(error);
				YYERROR;
			}
			else{
			
				output = fopen(output_name, "a+");
				if(ISNUMBER(srcreg)){
				
					fprintf(output, "\tlw %s, %d(%s)\n", treg, atoi(srcreg)*4, x->reg);
				}
				else{
				
					fprintf(output, "\tsll %s, %s , 2\n", treg, srcreg);
					fprintf(output, "\tadd %s, %s , %s\n", treg, treg, x->reg);
					fprintf(output, "\tlw %s, 0(%s)\n", treg, treg);
				}
				pushStack(treg);
				fclose(output);
			}
		}
		| ident	;		
		
ident:		ID {
			struct node* x = lookup(first, $1);
			if(x != NULL)
			{ 
				$$ = x->value;
			}
			else
			{
				char error[30] = "undefined variable ";
				strcat(error, $1);
				yyerror(error);
				YYERROR;
			}
			pushStack(x->reg);
			
		};

%%

int main(int argc, char** argv){

	
	first = last = NULL;
	ffirst = flast = NULL;
	stackSize = 0;
	label_num = 0;
	loop_num = 0;
	anyerror = 0;
	FILE* input = fopen(argv[1], "r");
	if(input == 0){
		printf("could not open input file");
		exit(-1);
	}
	yyin = input;
	
	FILE* output = fopen(argv[2], "w");
	if(output == 0){
		printf("could not open output file");
		exit(-1);
	}
	else{
		strcpy(output_name, argv[2]);
		fprintf(output, ".data\n\tbackn: .asciiz \"%c%c\" \n.text\n.globl main\n", '\\','n');
		fclose(output);
	}
	FILE* symbol = fopen("symbol.txt", "w");
	if(symbol == 0){
		printf("sym file could not open");
	}	
	else 
		fclose(symbol);
	yyparse();
	if(anyerror){

		fclose(output);
		remove(output_name);
	}
	fclose(input);
	print(first);
}
void yyerror(const char *s){
	
	printf("error : %s", s);
	anyerror = 1;
}
char* itos(int num){
	 
	char* str = (char*)malloc(sizeof(char)*10);
    	int i, rem, len = 0, n;
	
	if(num == 0){
		str[0] = 0 + '0';
		len = 1;
	}
	else if(num < 0){
		str[0] = '-';
		len = 1;
		num = -num;
	}
	n = num;
	while (n != 0)
	{
		len++;
		n /= 10;
	}
	for (i = 0; i < len; i++)
	{
		rem = num % 10;
		num = num / 10;
		str[len - (i + 1)] = rem + '0';
	}
	str[len] = '\0';
	return str;

}
_Bool ISNUMBER(char* reg){

	if(reg[0] == '-' || (reg[0] >= '0' && reg[0] <= '9')){
		
		for(int i=1; i<strlen(reg); i++){
			if(!(reg[i] >= '0' && reg[i] <= '9'))
				return 0;
		}
		
		return 1;
	}
	return 0;
}
void removeScopeVariables(struct node** first, struct node** last, char* scope_name){

	struct node* prev;
	for(struct node* t = *first; t; t = t->next){
	
		if(strcmp(t->scope, scope_name) == 0){
			SetFreeRegister(t->reg);
			if(t == *first && t == *last){
				*first = *last = NULL;
			}
			else if(t == *first){
				*first = (*first)->next;
			}
			else if(t == *last){
				*last = prev;
				(*last)->next = NULL;
			}
			else{
				prev->next = t->next;
			}
			
		}
		else
			prev = t;		
	}
}
void SetFreeRegister(char* reg_name){

	char RegType = reg_name[1];
	char RegNo = reg_name[2];
	switch(RegType){
		case 't':
		t_state[RegNo-'0'] = 0;
		break;
		case 's':
		s_state[RegNo-'0'] = 0;
		break;
		case 'a':
		a_state[RegNo-'0'] = 0;
		break;
		
	}
}
int GetFreeRegister(char registerSet){

	switch(registerSet){
		case 't':
		for(int i=0; i<=9; i++){
			if(t_state[i] == 0){
				t_state[i] = 1;
				return i;
			}
		}	
		break;
		case 's':
		for(int i=0; i<=7; i++){
			if(s_state[i] == 0){
				s_state[i] = 1;
				return i;
			}
		}
		break;
		case 'a':
		for(int i=0; i<=3; i++){
			if(a_state[i] == 0){
				a_state[i] = 1;
				return i;
			}
		}	
		break;
	}
}
void pushStack(char* reg){

	strcpy(stack[stackSize++], reg);
}
char* popStack(){

	char* a = (char*)malloc(sizeof(char)*8);
	strcpy(a , stack[stackSize-1]);
	stackSize--;
	return a;
}
struct node* insert(struct node** first, struct node** last, char* name, char type){
		
	struct node* _new = (struct node*)malloc(sizeof(struct node));
	_new->name = (char*)malloc(sizeof(char)* (strlen(name)+1));
	strcpy(_new->name ,name);
	_new->reg = (char*)malloc(sizeof(char)*4);
	_new->scope = (char*)malloc(sizeof(char)*(strlen(currentScope)+1));
	strcpy(_new->scope, currentScope);
	_new->value = 888;
	int no;
	char reg[4];
	if(type == 's'){
		no = GetFreeRegister('s');
		strcpy(reg, "$s");
	}
	else if(type == 'a'){
		no = GetFreeRegister('a');
		strcpy(reg, "$a");
	}
	strcat(reg, itos(no));
	strcpy(_new->reg, reg);
	
	if(*first){
		_new->next = *first;
		*first = _new;
	}
	else{
		*first = *last = _new;
		_new->next = NULL;
	}	
	return _new;	
}
struct node* lookup(struct node* first, char* name){

	for(struct node* t = first; t; t = t->next){
		if(strcmp(t->name, name) == 0)
			return t;
	}
	return NULL;
}
void set_value(struct node* x, int value){
	
	x->value = value;	
}
void print(struct node* first){ 

	FILE* symbol = fopen("symbol.txt", "a+");
	if(!symbol){
		printf("sym file could not open");
		return;
	}
	for(struct node* t = first; t; t = t->next){

		fprintf(symbol, "%s			%d			%s			%s\n", t->name, t->value, t->reg, t->scope);
		
	} 
	fprintf(symbol, "-----------------------------------\n");
	fclose(symbol);
}
struct fnode* finsert(struct fnode** ffirst, struct fnode** flast, char* name){
		
	struct fnode* _new = (struct fnode*)malloc(sizeof(struct fnode));
	_new->name = (char*)malloc(sizeof(char)* (strlen(name)+1));
	_new->outputtype = (char*)malloc(sizeof(char)*5);
	strcpy(_new->name ,name);
	_new->next = NULL;
	
	if(*ffirst){
		
		(*flast)->next = _new;
		*flast = _new;
	}
	else{
		*ffirst = *flast = _new;
	}	
	return _new;
}
struct fnode* flookup(struct fnode* ffirst, char* name){

	for(struct fnode* t = ffirst; t; t = t->next){
		if(strcmp(t->name, name) == 0)
			return t;
	}
	return NULL;

}

