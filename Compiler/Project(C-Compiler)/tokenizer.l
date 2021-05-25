


%{
	/////////////////////////////////////////////////////////////////////
	//	
	//		Creator:‌ Sara Baradaran, Mahdi Heidari
	//		Creation Date:‌ Jan 2020
	//		Project Title: C to MIPS assembly compiler
	//		
	/////////////////////////////////////////////////////////////////////

	#include "parser.tab.h"
	#include <string.h>
	
%}

%%

[1-9][0-9]*|0	{printf("I see a num : %s \n", yytext); yylval.ival = atoi(yytext); return NUM; }
"void "		{printf("I see void keyword \n"); return VOID;}
"int "			{printf("I see int keyword \n"); return INT;}
"if"			{printf("I see int if \n"); return IF;}
"else"			{printf("I see int else \n"); return ELSE;}
"return"		{printf("I see return \n"); return RETURN;}
"while"		{printf("I see while \n"); return WHILE;}
"global "		{printf("I see global \n"); return GLOBAL;}
"print"		{printf("I see print \n"); return PRINT;}
"\\n"			{printf("I see backn \n"); return BACKN;}
([a-z]|[A-Z])+	{printf("I see an id : %s \n", yytext); 
			yylval.sval = (char*)malloc(sizeof(char)*(strlen(yytext)+1)); strcpy(yylval.sval, yytext); return ID;}
"="			{printf("I see = \n"); return ASSIGN;}
"+"			{printf("I see + \n"); return PLUS;}
"-"			{printf("I see - \n"); return MINUS;}
"*"			{printf("I see * \n"); return MUL;}
"/"			{printf("I see / \n"); return DIV;}
"<="			{printf("I see <= \n"); return BLE;}
">="			{printf("I see >= \n"); return BGE;}
"<"			{printf("I see < \n"); return BLT;}
">"			{printf("I see > \n"); return BGT;}
"=="			{printf("I see == \n"); return EQUAL;}
"!="			{printf("I see != \n"); return NOTEQUAL;}
"!"			{printf("I see ! \n"); return NOT;}
"&&"			{printf("I see && \n"); return AND;}
"&"			{printf("I see & \n"); return BITAND;}
"||"			{printf("I see || \n"); return OR;}
"|"			{printf("I see | \n"); return BITOR;}
"("			{printf("I see ( \n"); return OPENP;}
")"			{printf("I see ) \n"); return CLOSEP;}
"{"			{printf("I see { \n"); return OPENA;}
"}"			{printf("I see } \n"); return CLOSEA;}
";"			{printf("I see ; \n"); return SEMICOLON;}	
","			{printf("I see , \n"); return COMMA;}
"["			{printf("I see [ \n"); return OPENB;}
"]"			{printf("I see ] \n"); return CLOSEB;}
[ \t]+			{printf("I see space \n");}
[\n]+			{printf("I see newline \n");}
%%	

int yywrap(){}
