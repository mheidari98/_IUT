/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : Laboratory1
Version : 0.1
Date    : 10/1/2020
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

#include <mega16.h>
#include <math.h>
#include <delay.h>

// Declare your global variables here
flash unsigned char digit[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
char MyNum = 0;
signed char sadgan, dahgan, yekan, dahom;

void SubProgram_1(char n)
{
    char i;
    for (i=0; i<n; i++) {
        PORTB = 0xff;
        delay_ms(500);
        
        PORTB = 0x00;
        delay_ms(500);
    };
}

void SubProgram_2(void)
{
    char i;
    for (i=0; i<9; i++) {
        PORTB = (1<<i);
        delay_ms(375);  // 3000/8=375
    };
}

void SubProgram_3(void)
{
    PORTB = PINA;
    delay_ms(100);
}

void SubProgram_4(void)
{
    signed char i;
    PORTD = (PORTD & 0xf0); 
    for (i=9; i>=0; i--) {
        PORTC = digit[i];
        delay_ms(500);
    }; 
    PORTC = 0x00;
    //PORTD = (PORTD | 0x0f);
}

char func(signed char N, char k, char Z) // return (N-k)%Z
{
    N -= k;
    if( N < 0 )
        N += Z;
    return N;        
}

void SubProgram_5(void)
{
    char i, j, num;
    num = PINA;
    if( MyNum != num )
    {
        sadgan = (num/100)%10; 
        dahgan = (num/10)%10;
        yekan = num%10;
        dahom = 0;
        MyNum = num;
    }
    
    for (i=0; i<7; i++) {
    
        for (j=0; j<10; j++) {
            PORTD = ~(0xf1);
            PORTC =  digit[ sadgan ];
            delay_ms(10); 
            
            PORTD = ~(0xf2);
            PORTC =  digit[ dahgan ];
            delay_ms(10); 
            
            PORTD = ~(0xf4);
            PORTC =  digit[ yekan ] | 0x80 ;
            delay_ms(10); 
            
            PORTD = ~(0xf8);
            PORTC =  digit[ dahom ];
            delay_ms(10);
        }
         
        
        if( !(sadgan | dahgan | yekan | dahom) )
            break;
        if( !(dahgan | yekan | dahom) )    
            sadgan = func(sadgan, 1, 10);   // (sadgan-1)%10;
               
        if( !(yekan | dahom) )
            dahgan = func(dahgan, 1, 10);   // dahgan = (dahgan-1)%10;
        
        if( !(dahom) )
            yekan = func(yekan, 1, 10);   // yekan = (yekan-1)%10;
        
        dahom = func(dahom, 2, 10);   // dahom = (dahom-2)%10; 

    };
}

void SubProgram_6(void)
{
    if( PIND.7 == 0)
         sadgan = 0;
         
    if( PIND.6 == 0)
         dahgan = 0;
         
    if( PIND.5 == 0)
         yekan = 0;
         
    if( PIND.4 == 0)
         dahom = 0;
}

void main(void)
{
    // Declare your local variables here
    //char i = 0;
    
    // Input/Output Ports initialization
    DDRA = 0x00;  // Input
    DDRB = 0xff;  // Output
    DDRC = 0xff;  // Output
    DDRD = 0x0f;  // (7-4 Input) & (3-0 Output)
    
    
    SubProgram_1(4);
    SubProgram_2(); 
    SubProgram_4();
   
    while (1)
    {
        SubProgram_3();
        SubProgram_5();
        SubProgram_6();   
    }
}
