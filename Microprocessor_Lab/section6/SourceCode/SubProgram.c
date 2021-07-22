#include "myheader.h"

char buf[100];
signed char RouteNum=0;

void MyShow()
{
    char i;
    
    for(i=0;i<4;i++)
    {
        lcd_gotoxy(0,0); sprintf(buf,"ADC%d=%4d",2*i, MyAdcData[2*i]); lcd_puts(buf);
        lcd_gotoxy(0,1); sprintf(buf,"ADC%d=%4d",2*i+1, MyAdcData[2*i + 1]); lcd_puts(buf);
        delay_ms(500); 
    }
}

unsigned int read_adc(unsigned char adc_input) // Read the AD conversion result
{
    ADMUX=adc_input | ADC_VREF_TYPE;
    
    delay_us(10); // Delay needed for the stabilization of the ADC input voltage
    
    ADCSRA|=(1<<ADSC); // Start the AD conversion
    
    while ((ADCSRA & (1<<ADIF))==0); // Wait for the AD conversion to complete
    
    ADCSRA|=(1<<ADIF);
    
    return ADCW;
}

void SubProgram1()
{
    char i;
    
    for(i=0;i<8;i++)
    {
        MyAdcData[i] = read_adc(i) * 5;
        delay_ms(10);
    } 
    
    MyShow();
    
}

interrupt [ADC_INT] void adc_isr(void) // ADC interrupt service routine with auto input scanning
{
    static unsigned char input_index=0;
    
    adc_data[input_index]=ADCW; // Read the AD conversion result
    //MyAdcData[input_index]=adc_data[input_index];
    if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT)) // Select next ADC input
       input_index=0;   
       
    ADMUX=(FIRST_ADC_INPUT | ADC_VREF_TYPE)+input_index;
    
    delay_us(10); // Delay needed for the stabilization of the ADC input voltage
    
    ADCSRA|=(1<<ADSC); // Start the AD conversion
}

void CheckChanges(char i)   ///  change if changes more than 5%  ///
{
    unsigned int a = adc_data[(i+1)%8] * 5;
    unsigned int b = MyAdcData[i];
    
    if( ((abs(a - b)*100)/b) > 5 )
        MyAdcData[i] = a;  
}

// ***** Q3 ***** //
void ChangeDutyCycle(unsigned char percent)
{
    //lcd_gotoxy(0,1); sprintf(buf,"%3d",percent); lcd_puts(buf); 

    OCR0=2.5*percent + 1;  
    //lcd_gotoxy(0,1); sprintf(buf,"%3d",OCR0); lcd_puts(buf);
}

unsigned char Number2Percent(unsigned int A)
{
    return ( (A) /1023.0)*90 + 5;
}


void charkhesh(char jahat)
{
    if(jahat==1)
    {
        RouteNum = (RouteNum+1)%4;
        PORTB = (PORTB&0x0f) | (1<<(4+RouteNum));    
    } 
    else
    {
        RouteNum = (RouteNum-1);
        if(RouteNum<0)
            RouteNum = 3 ;
        PORTB = (PORTB&0x0f) | (1<<(4+RouteNum));   
    } 
}
signed int CurAngel=0;
void Optional_1(unsigned int ADC_1)
{
    signed int MyDiff, Angel;
    signed char jahat;
    //char i;
    
    Angel = (ADC_1<256)?(ADC_1-128):(ADC_1/4-128);
                 
    MyDiff = Angel - CurAngel;
    
    jahat = (MyDiff<0)?-1:+1;
    
    lcd_gotoxy(9,0); sprintf(buf,"%4d",CurAngel); lcd_puts(buf);
    lcd_gotoxy(9,1); sprintf(buf,"%4d",MyDiff); lcd_puts(buf);
            
    if(MyDiff) //MyDiff
    {
        PORTD = (PORTD&0x1f) & ~(1 << POSITION_SET); 
        for( ; MyDiff; MyDiff=MyDiff-jahat )
        {
            lcd_gotoxy(9,0); sprintf(buf,"%4d",CurAngel); lcd_puts(buf);
            lcd_gotoxy(9,1); sprintf(buf,"%4d",MyDiff); lcd_puts(buf); 
            charkhesh( jahat );
            delay_ms(200);
            CurAngel=CurAngel+jahat; 
        }
        
        CurAngel = Angel;   
    }
    
    PORTD = (PORTD&0x1f)|(1 << POSITION_SET); 
}

void Optional_2(unsigned int ADC_2)
{
    static char flag=0;
    if( ADC_2 < 1000 )
    {
        if(flag)
            PORTD = (PORTD&0x1f)|(1 << LED_NORMAL);
        else
            PORTD = (PORTD&0x1f)|(1 << LED_LOW);
    }
    else if( ADC_2 < 4000 )
    {
        PORTD = (PORTD&0x1f)|(1 << LED_NORMAL);
    }
    else
    {
        if(flag)
            PORTD = (PORTD&0x1f)|(1 << LED_NORMAL);
        else
            PORTD = (PORTD&0x1f)|(1 << LED_HIGH);
    }
    if(!flag)
        delay_ms(200); 
    flag = (flag)?0:1;
    
}
