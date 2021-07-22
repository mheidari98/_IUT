/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 12/14/2020
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

char CurHr, CurMin, CurSec;

void main(void)
{
    CurHr =3;
    CurMin=59;
    CurSec=50;    
    
    board_init(); 
    
    Show_Image_on_GLCD();
       
    #asm("sei") // Global enable interrupts
    
    while (1)
    {
        iterative_String_On_DotMatrix("MH");  
    }
    
}
