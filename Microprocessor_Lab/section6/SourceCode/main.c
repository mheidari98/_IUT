/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 11/15/2020
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

unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
unsigned int MyAdcData[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

void main(void)
{
    char i=0;
    char buf[100];
    
    board_init();
    
    SubProgram1();  //Q1    
    
    #asm("sei") // Global enable interrupts
    delay_ms(1000);
    
    for(;;)
    {
        ChangeDutyCycle( Number2Percent( adc_data[1] ) ); //Q3
                                                  
        Optional_1( adc_data[2] );  //Optional 1
        
        Optional_2( adc_data[3]*5 );  //Optional 2
        
        CheckChanges(i);  //Q2
        
        //MyShow();
        lcd_gotoxy(0,i%2); sprintf(buf,"ADC%d=%4d",i, MyAdcData[i]); lcd_puts(buf);
        
        if (++i > 7) 
            i=0;
            
        if(!(i%2))    
            delay_ms(500); 
    }
}
