
#include "myheader.h"

void io_init(void)  // Input/Output Ports initialization
{
    // 0=In     1=Out
    DDRA=0x00;  // Input
    PORTA=0x00;

    DDRB=0xff;  // Output
    PORTB=0x00;

    DDRC=0xff;  // Output
    PORTC=0x00;

    DDRD=0xff;  // Output
    PORTD=0x00;
}
                                                          
void TimerCounter0_init(void)
{
    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: 7.813 kHz
    // Mode: Phase correct PWM top=0xFF
    // OC0 output: Non-Inverted PWM
    // Timer Period: 65.28 ms
    // Output Pulse(s):
    // OC0 Period: 65.28 ms Width: 6.656 ms
    TCCR0=(1<<WGM00) | (1<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (1<<CS00);
    TCNT0=0x00;
    OCR0=0x1A;
}

void TimerCounter_Interrupt_init(void)
{
    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
}

void ADC_init(void)
{
    // ADC initialization
    // ADC Clock frequency: 125.000 kHz
    // ADC Voltage Reference: AVCC pin
    // ADC Auto Trigger Source: Free Running
    ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
    ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (0<<ADPS0);
    SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
}

void board_init(void)
{
    io_init();   
    TimerCounter0_init();
    TimerCounter_Interrupt_init();
    ADC_init();
    lcd_init(16);     // Alphanumeric LCD initialization
}
