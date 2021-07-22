/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 11/8/2020
Author  : 
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include "myheader.h"
#include "MyInit.h"
#include "SubProgram.h"

char jahat;

void main(void)
{
    char i;
    
    board_init();    
    
    #asm("sei")    // Global enable interrupts
    
    
    while (1)
    {
        for(i=0;i<20;i++)
        {
            ChangeDutyCycle( Number2Percent(PINA) );
            
            // Q4  
            jahat = i/5;
            if( jahat == 0 || jahat == 2)
            {
                lcd_gotoxy(0,1); lcd_putsf("   0rpm");
                PORTD.0 = 0;
                PORTD.1 = 0;
            }
            else if( jahat == 1)
            {
                lcd_gotoxy(0,1); lcd_putsf("+458rpm"); 
                PORTD.0 = 0;
                PORTD.1 = 1;
            }
            else if( jahat == 3)
            {
                lcd_gotoxy(0,1); lcd_putsf("-458rpm"); 
                PORTD.0 = 1;
                PORTD.1 = 0;
            } 
            delay_ms(1000);
        }
        
    }
}
