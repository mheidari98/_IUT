#include "myheader.h"

// Declare your global variables here
flash unsigned char digit[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

char GetData(char input)
{
    char CurVal=0;
    
    switch (input) {
    case Ain:
        CurVal = PINA;
        break;
    case Bin:
        CurVal = PINB;
        break;
    case Cin:
        CurVal = PINC;
        break;
    case Din:
        CurVal = PIND;
        break;  
    };
    
    return CurVal;
}

void SendData(char output, char Val)
{
    switch (output) {
    case Aout:
        PORTA = Val;
        break;
    case Bout:
        PORTB = Val;
        break;
    case Cout:
        PORTC = Val;
        break;
    case Dout:
        PORTD = Val;
        break;  
    };
}

void SubProgram_1(char output, char tedad, int miliSecond)
{
    char i;
    for (i=0; i<tedad; i++) {
        SendData(output, 0xff);
        delay_ms(miliSecond);        
        SendData(output, 0x00);
        delay_ms(miliSecond);  
    };
}

void SubProgram_2(char output, char StartPos, int Time)
{
    char i, CurPos=StartPos ;
    for (i=0; i<8; i++) {
        SendData( output, (1<<CurPos) );
        delay_ms(Time/8);  // 3000/8=375 
        CurPos = (CurPos+1)%8;
    };
    SendData( output, 0x00 );
}

void SubProgram_3(char output, char input)
{
    SendData( output, GetData(input) );  // PORTB = PINA;
    delay_ms(100);
}

void SubProgram_4(char LEDs, char POINT)
{
    signed char i, j, num;
    PORTD = (PORTD & 0xf0);
    
    num = (POINT == des)?9:0;
     
    for (i=0; i<10; i++) {
        for(j=0; j<10; j++)
        {
            if( LEDs & LED1 )
            {
                PORTD = ~(0xf1);
                PORTC =  digit[num];
                delay_ms(10);
            }
            if( LEDs & LED2 )
            {
                PORTD = ~(0xf2);
                PORTC =  digit[num];
                delay_ms(10);
            }
            if( LEDs & LED3 )
            {
                PORTD = ~(0xf4);
                PORTC =  digit[num];
                delay_ms(10);
            }
            if( LEDs & LED4 )
            {
                PORTD = ~(0xf8);
                PORTC =  digit[num];
                delay_ms(10);
            }
        }
        if(POINT == des)
            num--;
        else
            num++;    
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

void SubProgram_5(char input, char Mines)
{
    char j, num;
    signed char sadgan, dahgan, yekan, dahom;
    
    num = GetData(input); // PINA
    
    sadgan = (num/100)%10; 
    dahgan = (num/10)%10;
    yekan = num%10;
    dahom = 0;
    
    for (; ; ) {
    
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
        
        dahom = func(dahom, Mines, 10);   // dahom = (dahom-2)%10; 

    };
}

