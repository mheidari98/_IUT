/*******************************************************
Project : 
Version : 
Date    : 10/18/2020
Author  : Mahdi Heidari
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

char MyI;

void main(void)
{
    char Name[] = "Mahdi";
    char StdNo[] = "9626903";
    
    char BigStr[] = "Welcome to the online lab classes due to Corona disease.";
    
    board_init();
    
    //********************************************************
    // Q1 => Show Name & StudentID
    SubProgram_1(Name, StdNo);  delay_ms(2000);
    
    //********************************************************
    // Q2 => show big string
    SubProgram_2(BigStr);
    
    //********************************************************
    // Q3 => get input from KeyPad with Polling
    lcd_clear(); lcd_gotoxy(0,0); 
    for(MyI=0; MyI<4; MyI++)
        SubProgram_3();
     
    //********************************************************
    // Q4 => get input from KeyPad with Interrupts
    MyI=0;
    lcd_gotoxy(0,1);
    #asm("sei");      //  Set  Global interrupt flag
    
    while (MyI<4);
    
    #asm("cli");     // Clear Global interrupt flag
    delay_ms(500);
    //********************************************************
    // Q5 => get initialize value
    SubProgram_5();
    
    while(1);
    
}
