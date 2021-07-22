/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 10/7/2020
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
#include "myfunc.h"

void main(void)
{
    // Declare your local variables here
    //char i = 0;
    
    // Input/Output Ports initialization
    DDRA = 0x00;  // Input
    DDRB = 0xff;  // Output
    DDRC = 0xff;  // Output
    DDRD = 0x0f;  // (7-4 Input) & (3-0 Output)
    
    
    SubProgram_1(Bout, 2, 500);
    
    SubProgram_2(Bout, 0, 3000);
     
    SubProgram_4( LED1+LED2+LED3+LED4 , des);
    //SubProgram_4( LED2+LED4 , asc);
    
    while (1)
    {
        SubProgram_3(Bout, Ain);
        SubProgram_5(Ain, 5);
    }
}