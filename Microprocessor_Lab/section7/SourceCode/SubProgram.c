#include "myheader.h"

//char buf[100];

void USART_configure(char TransmitterStatus, char ReceiverStatus,long int BaudRate )
{
    bit RxEn=0, TxEn=0, RxCie=0, TxCie=0;
     
    switch (TransmitterStatus) {
    case 2: TxCie=1;
    case 1: TxEn = 1;
            break;    
    //default: TxEn = 0;
    };
    
    switch (ReceiverStatus) {
    case 2: RxCie=1;
    case 1: RxEn = 1;
            break;    
    //default: RxEn=0
    };

    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
    UCSRB=(RxCie<<RXCIE) | (TxCie<<TXCIE) | (0<<UDRIE) | (RxEn<<RXEN) | (TxEn<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
    
    UBRRH=0x00;
    
    if( BaudRate == 38400 )
        UBRRL=0x0C;
    else if( BaudRate == 19200 )
        UBRRL=0x19;  
    else if( BaudRate == 9600 )
        UBRRL=0x33;  
    else if( BaudRate == 4800 )
        UBRRL=0x67;  
    else if( BaudRate == 2400 )
        UBRRL=0xCF;  
    else if( BaudRate == 1200 )
    {
        UBRRH=0x01;
        UBRRL=0x9F; 
    } 
    else
    {
    
        UBRRH=(( 500000/BaudRate -1 )>>8) & 0xff;  // Focs = 8.000000 MHz
        UBRRL= ( 500000/BaudRate -1 ) & 0xff;  // UBRR = Focs/(8*BaudRate) - 1      
    }  
    
}

void SubProgram2()
{
    char Name[20], LastName[20];
    
    //USART_configure( TX_enable_noneinterrupt, RX_enable_noneinterrupt, 9600 ); 
    USART_configure( TX_enable_interrupt, RX_enable_interrupt, 9600 );
    
    printf("-->part 2 is running!\r\n");
    
    printf(">Enter your Name : "); 
    scanf("%s",Name);
    
    printf(">Enter your LastName : "); 
    scanf("%s",LastName);
    
    printf("\r\n>>    Output : (%s %s)\r\n",Name, LastName);
    
    printf("-->part 2 is Ending!\r\n\r\n");    
}

void SubProgram3()
{
    char cmd;
    
    //USART_configure( TX_enable_noneinterrupt, RX_enable_interrupt, 9600 );
    USART_configure( TX_enable_interrupt, RX_enable_interrupt, 9600 ); 
    
    printf("-->part 3 is running!\r\n");
    
    printf(">Enter your command char : "); 
    cmd = getchar();
    
    if('0'<=cmd && cmd<='9')
        printf("\r\n>>    Output : Data is a integer and 10*data=%d\r\n",(cmd-'0')*10);
    else if(cmd=='D')
    {
        lcd_gotoxy(0,0); lcd_clear(); lcd_putsf("lcd delete");
        printf("\r\n");
    }
    else if(cmd=='H')
        printf("\r\n  ***********************\r\n    Micro processor lab\r\n  ***********************\r\n");         
    else   
        printf("\r\n>>    Output : No function defined!\r\n");
    
    printf("-->part 3 is Ending!\r\n\r\n");       
}

void SubProgram4()
{
    char j, flag, tmp,cur;
    char str[20];
    
    USART_configure( TX_enable_interrupt, RX_enable_interrupt, 9600 );
    
    printf("-->part 4 is running!\r\n");    

    flag=1;
    cur=0;
        
    do{ 
        printf(">Enter your frame : "); 
        tmp = getchar();
        if(tmp=='(')
            break;
        else
            printf(" should start with '(' \r\n");
    }while(1);
        
    for(j=0;j<20;j++)
    {
        tmp = getchar();
        if(tmp==')')
            break;
        if(!('0'<=tmp && tmp<='9'))
            flag=0;
        str[cur++]=tmp;
    }
        
    if(j<5)
        printf("\r\n    Length of frame not correct\r\n");
    else if(j>5 || !flag)
        printf("\r\n    Frame must be 5 integer\r\n");
    else
    {
        printf("\r\n    Frame is correct\r\n");
            
        lcd_clear();
        lcd_gotoxy(0,0);
        for(j=0;j<cur;j++)
            lcd_putchar( str[j] );
    }

    printf("-->part 4 is Ending!\r\n\r\n"); 
}

