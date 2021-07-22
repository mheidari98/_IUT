#ifndef _SubProgram_INCLUDED_
#define _SubProgram_INCLUDED_

interrupt [TIM1_OVF] void timer1_ovf_isr(void);

/* --> SubProgram 1 <-- */
void iterative_String_On_DotMatrix(char *BigStr);

/* --> SubProgram 2 <-- */
void Show_Image_on_GLCD(void);

/* --> SubProgram 3 <-- */
double Degree2Radian(int alpha);
void DrawClock_on_GLCD(char hr,char min,char sec);

#endif