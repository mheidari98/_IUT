#include "myheader.h"

char buf[100];
char LastPercent=0;
signed char RouteNum=0;

// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
// Place your code here

}

// External Interrupt 1 service routine
interrupt [EXT_INT1] void ext_int1_isr(void)
{
// Place your code here

}

// Timer1 input capture interrupt service routine
interrupt [TIM1_CAPT] void timer1_capt_isr(void)
{
// Place your code here

}

char t=0;
// External Interrupt 2 service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
    t = (t+1)%6;
    if(jahat==1 && t==5)
    {
        PORTB = (PORTB&0x0f) | (1<<(4+RouteNum));  
        RouteNum = (RouteNum+1)%4;
    } 
    else if(jahat==3 && t==5)
    {
        PORTB = (PORTB&0x0f) | (1<<(4+RouteNum));  
        RouteNum = (RouteNum-1);
        if(RouteNum<0)
            RouteNum = 3 ;
    }   
}

// ***** Q3 ***** //
void ChangeDutyCycle(char percent)
{
    lcd_gotoxy(0,0); sprintf(buf,"DC=%3d",percent); lcd_puts(buf); 
    if( LastPercent != percent )
    {
        OCR0=2.5*percent + 1;  
        lcd_gotoxy(8,0); sprintf(buf,"OCR0=%3d",OCR0); lcd_puts(buf);
        LastPercent = percent;
    }
}

char Number2Percent(char A)
{
    return (A*18)/51 + 5;
}









