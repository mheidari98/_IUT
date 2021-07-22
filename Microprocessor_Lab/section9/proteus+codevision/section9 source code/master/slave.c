#include <myheader.h>
#include <glcd_s.h>
#include <clock.h>
#include <timer.h>

void main(void)
{

char scr[];

char count1 = 0,count3;

master_micro=0;

port_init();
spi_init_slave();
uart_init();
clock_display();
timer1_init();

#asm("sei")

puts("Hello,  END of ONLINE CLASS \r\n   ***     MASTER MICRO 2    ***\r\r\r\n");

sprintf(scr,"TIME: "); 
glcd_moveto(80,  32);
glcd_outtext(scr);
   

I2C_Slave_Init(Slave_Address);


    
 while (1)
     { 
     
 
    switch(I2C_Slave_Listen())    /* Check for SLA+W or SLA+R */
     {
        case 0:
        {
          puts("\r\n Receiving :       "); 
          
          do 
          {
            count1 = I2C_Slave_Receive();/* Receive data byte*/
            
            sprintf(scr, "%d    ", count1);
            puts(scr); 
            
            
          }while (count1 != 255); /* Receive until STOP/REPEATED START */
		  count1 = 0;
		  break;
		}
	    case 1:
		{
		  char Ack_status;
          count3=10;
		  puts("\r\n Sending :       ");
		  do
		  {
		    Ack_status = I2C_Slave_Transmit(count3);/* Send data byte */ 
           
		    sprintf(scr, "%d    ",count3);
		    puts(scr);
		    count3++;
		  } while (Ack_status == 0);/* Send until Ack is receive */
		  break;
		}
	    default:
		break;
	 }
     }
 }






