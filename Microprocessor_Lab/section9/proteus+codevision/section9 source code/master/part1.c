
#include <myheader.h>
#include <i2c_e.h>
#include <mandala2.h>
#include <glcdf.h> 

void main(void)
{


    int i;
    char buffer[12];

    port_init();
    spi_init();
    uart_init();
    
    
    
    puts("Hello,  Welcome to last online class in 1399\r\n           ***     MASTER MICRO    ***\r\r\r\n");
    adc_init_no_intterupt();
        

    #asm("sei")

    
    glcddisplay();
    delay_ms(1000);
    
    puts("W EEPROM\r\n"); 
    i2c_24lc32_frame();   //write to eeprom

    puts("R EEPROM\r\n"); 
    puts("Display\r\n");  
     
    i2c_24lc32_read_frame();  //read eeprom
   
    
    while (1)
    {
        I2C_Init2(); 
        puts( "\r\n Sending :       ");
        I2C_Start_Wait(Slave_Write_Address);/* Start I2C communication with SLA+W */
		delay_ms(5);
		for ( i = 0; i < count ; i++)
		{
			sprintf(buffer, "%d    ",i);
			puts(buffer);
			I2C_Write2(i);					/* Send Incrementing count */
			delay_ms(500);
		}
		puts("\r\n Receiving :       ");
		I2C_Repeated_Start(Slave_Read_Address);	/* Repeated Start I2C communication with SLA+R */
		delay_ms(5);
		for ( i = 0; i < count; i++)
		{
			if(i < count - 1)
				sprintf(buffer, "%d    ", I2C_Read_Ack());/* Read and send Acknowledge of data */
			else
				sprintf(buffer, "%d    ", I2C_Read_Nack());/* Read and Not Acknowledge to data */
			puts(buffer);
			delay_ms(500);
		}
		I2C_Stop2();   /* Stop I2C */
        adc_send_to_spi();	// check the adc value change 					
	}
}

  
    
