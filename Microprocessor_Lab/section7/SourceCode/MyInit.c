#include "myheader.h"

void io_init(void)  // Input/Output Ports initialization
{
    // 0=In     1=Out
    DDRA=0x00;  // Input
    PORTA=0x00;

    DDRB=0x00;  // Input
    PORTB=0x00;

    DDRC=0x00;  // Input
    PORTC=0x00;

    DDRD=0x00;  // Input
    PORTD=0x00;
}
                                                          
void USART_init(void)
{
    // USART initialization
    // Communication Parameters: 8 Data, 1 Stop, No Parity
    // USART Receiver: On
    // USART Transmitter: On
    // USART Mode: Asynchronous
    // USART Baud Rate: 9600
    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
    UCSRB=(1<<RXCIE) | (1<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
    UBRRH=0x00;
    UBRRL=0x33;
}

void board_init(void)
{
    io_init();   
    USART_init();
    lcd_init(16);     // Alphanumeric LCD initialization
}
