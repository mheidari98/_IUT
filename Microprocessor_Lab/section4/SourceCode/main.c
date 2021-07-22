/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 10/23/2020
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
#include "SubPrograms.h"

char Hour=0 ,Minute=0 ,Second=0 ,USec=0;
int CurCap=1000; 

void main(void)
{
    char LastA=249;
    
    board_init();
    
    PrintTimer();
    PrintCapacity();
    
    
    #asm("sei") // Global enable interrupts

    while (1)
    {
        if(PINA != LastA)
        {
            LastA = PINA;
            ChangePeriod(LastA);
        }
    }
}
