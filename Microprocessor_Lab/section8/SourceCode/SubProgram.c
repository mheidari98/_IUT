#include "myheader.h"
#include "font8x8_basic.h"
#include "MyImage.h"

char buf[100], temp[100];

/*-----------------------*/
/* --> SubProgram 1 <-- */
void iterative_String_On_DotMatrix(char *BigStr)
{
    int i, j;
    char a, b, k, m, SLen;
    
    sprintf(buf,"  %s  ",BigStr);
    
    SLen = strlen(buf);
    
    for(i=0; i<(SLen*8)-16 ;i++)
    {
        for(m=0;m<8;m++)
        {
            for(j=i, k=0; j<(i+16) ;j++, k++)
            {
                PORTD.7 = !((k/8)%2);
                a = j/8;
                b = j%8; 
                
                PORTA = (1<<(k%8)); 
                PORTB = ~font8x8_basic[ (buf[a]-32)*8 + b];
                delay_ms(2);   
            }
        }

    }
    
}

/*-----------------------*/
/* --> SubProgram 2 <-- */
void Show_Image_on_GLCD(void)
{
    //glcd_outtextxyf(0,0,"in the name of god");

    glcd_clear();
    glcd_putimagef(0,0,img1,GLCD_PUTCOPY);
    delay_ms(1500);
    glcd_clear();
    glcd_putimagef(0,0,img2,GLCD_PUTCOPY);
    delay_ms(1500);
}

/*-----------------------*/
/* --> SubProgram 3 <-- */

double Degree2Radian(int alpha)
{
    return alpha*(3.14159265/180);
}

void DrawClock_on_GLCD(char hr,char min,char sec)
{
    char S_x=31, S_y=31, R=31;
    char H=10,M=20,S=28;
     
    glcd_clear();
    
    glcd_outtextxy(70,40,"TIME:");    
    sprintf(temp,"%02d:%02d:%02d",hr,min,sec);
    glcd_outtextxy(70,54,temp);
    
    glcd_circle(S_x, S_y, R);
    
    glcd_setlinestyle(3,GLCD_LINE_SOLID )
    glcd_line(S_x, S_y, S_x+H*sin( Degree2Radian(30*hr) ), S_y-H*cos( Degree2Radian(30*hr) ) );
    //glcd_line(S_x, S_y, S_x+H*sin( Degree2Radian(30*hr + min/2) ), S_y-H*cos( Degree2Radian(30*hr + min/2) ) );
    
    glcd_setlinestyle(2,GLCD_LINE_DOT_LARGE )
    glcd_line(S_x, S_y, S_x+M*sin( Degree2Radian(6*min) ), S_y-M*cos( Degree2Radian(6*min) ) );
    
    glcd_setlinestyle(1,GLCD_LINE_DOT_SMALL )
    glcd_line(S_x, S_y, S_x+S*sin( Degree2Radian(6*sec) ), S_y-S*cos( Degree2Radian(6*sec) ) );
    
}

interrupt [TIM1_OVF] void timer1_ovf_isr(void)  // Timer1 overflow interrupt service routine
{
    // Reinitialize Timer1 value
    TCNT1H=0x85EE >> 8;
    TCNT1L=0x85EE & 0xff;
    
    // Place your code here
    if(CurSec==59)
    {
        if(CurMin==59)
        {
            CurHr = (CurHr+1)%24;    
        }
        CurMin = (CurMin+1)%60;
    }
    CurSec= (CurSec+1)%60;            
    
    DrawClock_on_GLCD( CurHr, CurMin, CurSec); 
}

