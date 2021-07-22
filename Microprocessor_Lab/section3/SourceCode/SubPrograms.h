#ifndef _SubProgram_INCLUDED_
#define _SubProgram_INCLUDED_

void SubProgram_1(char *Name, char *StdNo);

void SubProgram_2(char *BigStr);

char SubProgram_3();

interrupt [EXT_INT1] void SubProgram_4(void);

char Hex2Int(char x);
char CheckRange(char Num, char LowerBound, char UpperBound );
void Q5parts(char *str, char L, char U);
void SubProgram_5();

#endif