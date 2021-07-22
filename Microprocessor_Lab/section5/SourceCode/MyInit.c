
#include "myheader.h"

void io_init(void)  // Input/Output Ports initialization
{
    DDRA=0x00;
    PORTA=0x00;

    DDRB=0xff;
    PORTB=0x00;

    DDRC=0x00;
    PORTC=0x00;

    DDRD=0x0f;
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

void TimerCounter1_init(void)
{
    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 8000.000 kHz
    // Mode: CTC top=OCR1A
    // OC1A output: Toggle on compare match
    // OC1B output: Disconnected
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer Period: 5 ms
    // Output Pulse(s):
    // OC1A Period: 10 ms Width: 5 ms
    // Timer1 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    TCCR1A=(0<<COM1A1) | (1<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
    TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
    
    TCNT1H=0x00;
    TCNT1L=0x00;
    
    ICR1H=0x00;
    ICR1L=0x00;
    
    OCR1AH=0x9C;
    OCR1AL=0x3F;
    
    OCR1BH=0x00;
    OCR1BL=0x00;
}

void TimerCounter2_init(void)
{
    // Timer/Counter 2 initialization
    // Clock source: System Clock
    // Clock value: 7.813 kHz
    // Mode: Normal top=0xFF
    // OC2 output: Disconnected
    // Timer Period: 32.768 ms
    ASSR=0<<AS2;
    TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (1<<CS22) | (1<<CS21) | (1<<CS20);
    TCNT2=0x00;
    OCR2=0x00;
}

void TimerCounter_Interrupt_init(void)
{
    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK=(0<<OCIE2) | (1<<TOIE2) | (1<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
}

void External_Interrupt_init(void)
{    
    // External Interrupt(s) initialization
    // INT0: On
    // INT0 Mode: Falling Edge
    // INT1: On
    // INT1 Mode: Rising Edge
    // INT2: Off
    GICR|=(1<<INT1) | (1<<INT0) | (0<<INT2);
    MCUCR=(1<<ISC11) | (1<<ISC10) | (1<<ISC01) | (0<<ISC00);
    MCUCSR=(0<<ISC2);
    GIFR=(1<<INTF1) | (1<<INTF0) | (0<<INTF2);
}

void board_init(void)
{
    io_init();   
    TimerCounter0_init();
    TimerCounter1_init(); 
    TimerCounter2_init();
    TimerCounter_Interrupt_init();
    External_Interrupt_init();
    lcd_init(16);     // Alphanumeric LCD initialization
}
