#include "myheader.h"

#define KEY_PRT PORTB
#define KEY_DDR DDRB
#define KEY_PIN PINB

char buf[100];

char row[] = {0x1f, 0x2f, 0x4f, 0x8f};

char data_key[]={
    '0', '1', '2', '3',
    '4', '5', '6', '7',
    '8', '9', 'A', 'B',
    'C', 'D', 'E', 'F'
};

void SubProgram_1(char *Name, char *StdNo)
{
    lcd_clear();
    
    lcd_gotoxy(0,0);
    sprintf(buf,"Name = %s",Name);   
    lcd_puts(buf);
    
    lcd_gotoxy(0,1);   
    sprintf(buf,"StdNo = %s",StdNo); 
    lcd_puts(buf);
}

void SubProgram_2(char *BigStr)
{
    char i;
    char SLen = strlen(BigStr);
    
    memset(BigStr, ' ', 15*sizeof(char));
    memset(BigStr + SLen , ' ', 15*sizeof(char));  
    
    for(i=0; i<SLen+1 ; i++)
    {
        strncpy(buf, &BigStr[i], 16);
        buf[16]='\0';
        lcd_clear();
        lcd_gotoxy(0,1);
        lcd_puts(buf);
        delay_ms(150);
    }
    PORTC.0 = 1;
}

char FindKey()
{
    char r;
    char ac, Key;
    
    for (r=0; r<4 ; r++)
    {
        ac=4;
        KEY_PRT = row[r];

        if(KEY_PIN.0 == 1) ac=0;
        if(KEY_PIN.1 == 1) ac=1;
        if(KEY_PIN.2 == 1) ac=2;
        if(KEY_PIN.3 == 1) ac=3;

        if(!(ac == 4))
        {
            Key = data_key[r*4 +ac];
            //lcd_gotoxy(pos,0); itoa(r,buf); lcd_puts(buf); 
            //lcd_gotoxy(pos,1); itoa(ac,buf); lcd_puts(buf);
            //pos++; 
            //lcd_putchar(Key);
            while (KEY_PIN.0==1);
            while (KEY_PIN.1==1);
            while (KEY_PIN.2==1);
            while (KEY_PIN.3==1); 
            
            break;               
        }
    }
    return Key;
}

char SubProgram_3()
{
    char temp;
    char Key;
    
    do{
        KEY_PRT = 0xf0;
        delay_ms(20);
        temp = (KEY_PIN & 0x0f);
    }while(temp != 0x00);
    
    do{
        do{
            delay_ms(20);
            temp = (KEY_PIN & 0x0f);
        }while(temp == 0x00);
            
        delay_ms(20);
        temp = (KEY_PIN & 0x0f);
    }while(temp == 0x00);
        
    Key = FindKey();
    
    lcd_putchar(Key);
    
    return Key; 
}

interrupt [EXT_INT1] void SubProgram_4(void)
{
    char Key;
    
    PORTC.0 = ~(PORTC.0);
    MyI++;
    
    Key = FindKey();
    
    lcd_putchar(Key);
    
    KEY_PRT = 0xf0; 
}

char Hex2Int(char x)
{
    switch (x) {
        case '0': return 0;
        case '1': return 1;
        case '2': return 2;       
        case '3': return 3;       
        case '4': return 4;       
        case '5': return 5;       
        case '6': return 6;       
        case '7': return 7;       
        case '8': return 8;       
        case '9': return 9;       
        case 'A': return 10;       
        case 'B': return 11;       
        case 'C': return 12;       
        case 'D': return 13;       
        case 'E': return 14;       
        case 'F': return 15;       
        default:  return -1;
    };
}

char CheckRange(char Num, char LowerBound, char UpperBound )
{
    return ( LowerBound<=Num && Num<=UpperBound)? 1 : 0;
}

void Q5parts(char *str, char L, char U)
{
    char Key;
    int Val=0;
    
    lcd_gotoxy(0,1); 
    lcd_puts(str);
    
    while(1)
    {
        lcd_gotoxy(6,1);
        
        Key = SubProgram_3();
        //lcd_putchar(Key);
        Val = Hex2Int(Key);
        
        Key = SubProgram_3();
        //lcd_putchar(Key);
        Val = (Val*10) + Hex2Int(Key);
        
        delay_ms(1000);
        
        if(CheckRange(Val, L, U))
            break;
        else
        {
            lcd_gotoxy(6,1);
            lcd_putsf("EE");
        }    
    }
}

void SubProgram_5()
{  
    char str1[] = "Speed:??(0-50r) ";
    char str2[] = "Time :??(0-99s) ";
    char str3[] = "Weigt:??(0-99F) ";
    char str4[] = "Temp :??(20-80C)";
    
    lcd_clear();
    lcd_gotoxy(0,0); lcd_putsf("init :");
    
    Q5parts(str1, 0, 50); 
    Q5parts(str2, 0, 99);
    Q5parts(str3, 0, 99);
    Q5parts(str4,20, 80);
    
    lcd_clear();
    lcd_gotoxy(0,0); 
    lcd_putsf("Done!");
}

