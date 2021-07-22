#include <mega16.h>
#include <alcd.h>  // Alphanumeric LCD functions
#include <delay.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void io_init(void)
{
    DDRA = 0xff;
    PORTA = 0x00;

    DDRB = 0xf0;
    PORTB = 0xf0;

    DDRC = 0x01;
    PORTC = 0x00;

    DDRD = 0x00;
    PORTD = 0x00;
}

void interrupt_init(void)
{
    // External Interrupt(s) initialization
    // INT0: Off
    // INT1: On
    // INT1 Mode: Rising Edge
    // INT2: Off
    GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
    MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
    MCUCSR=(0<<ISC2);
    GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
}

void board_init(void)
{
    io_init();
    interrupt_init();
    lcd_init(16);     // Alphanumeric LCD initialization
}
