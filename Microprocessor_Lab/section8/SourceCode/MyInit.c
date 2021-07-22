#include "myheader.h"

void io_init(void)  // Input/Output Ports initialization
{
    // 0=In     1=Out
    DDRA=0xff;  // Output
    PORTA=0x00;

    DDRB=0xff;  // Output
    PORTB=0x00;

    DDRC=0x00;  // Input
    PORTC=0x00;

    DDRD=0x80;  // port7=Output , o.w=Input
    PORTD=0x00;
}

void TimerCounter1_init(void)
{
    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 31.250 kHz
    // Mode: Normal top=0xFFFF
    // OC1A output: Disconnected
    // OC1B output: Disconnected
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer Period: 1 s
    // Timer1 Overflow Interrupt: On
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
    TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (1<<CS12) | (0<<CS11) | (0<<CS10);
    TCNT1H=0x85;
    TCNT1L=0xEE;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;
}                                                         

void TimerCounterInterrupt_init(void)
{
    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
}

void GraphicDisplayController_init(void)
{
    // Variable used to store graphic display
    // controller initialization data
    GLCDINIT_t glcd_init_data; 
    
    // Graphic Display Controller initialization
    // The KS0108 connections are specified in the
    // Project|Configure|C Compiler|Libraries|Graphic Display menu:
    // DB0 - PORTC Bit 0
    // DB1 - PORTC Bit 1
    // DB2 - PORTC Bit 2
    // DB3 - PORTC Bit 3
    // DB4 - PORTC Bit 4
    // DB5 - PORTC Bit 5
    // DB6 - PORTC Bit 6
    // DB7 - PORTC Bit 7
    // E - PORTD Bit 0
    // RD /WR - PORTD Bit 1
    // RS - PORTD Bit 2
    // /RST - PORTD Bit 3
    // /CS1 - PORTD Bit 5
    // /CS2 - PORTD Bit 4

    // Specify the current font for displaying text
    glcd_init_data.font=font5x7;
    // No function is used for reading
    // image data from external memory
    glcd_init_data.readxmem=NULL;
    // No function is used for writing
    // image data to external memory
    glcd_init_data.writexmem=NULL;

    glcd_init(&glcd_init_data);
}

void board_init(void)
{
    io_init();   
    TimerCounter1_init();
    TimerCounterInterrupt_init();
    GraphicDisplayController_init();
}
