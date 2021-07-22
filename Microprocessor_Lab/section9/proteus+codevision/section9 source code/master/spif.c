
 #include <myheader.h> 
 
 int data_spi[2]={99,99}; 
 char num_data_spi=0;
 bit new_data_spi=0; 
 bit master_micro=1;
 
 void spi_init(void)
{
// SPI initialization
// SPI Type: Master
// SPI Clock Rate: 2000.000 kHz
// SPI Clock Phase: Cycle Start
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=(1<<SPIE) | (1<<SPE) | (0<<DORD) | (1<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
SPSR=(0<<SPI2X);

// Clear the SPI interrupt flag
#asm
    in   r30,spsr
    in   r30,spdr
#endasm


}
 void spi_init_slave(void)
{



// SPI initialization
// SPI Type: Slave
// SPI Clock Rate: 2000.000 kHz
// SPI Clock Phase: Cycle Start
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=(1<<SPIE) | (1<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
SPSR=(0<<SPI2X);

#asm
    in   r30,spsr
    in   r30,spdr
#endasm



}

interrupt [SPI_STC] void spi_isr(void)
{
//unsigned char data;
//data_spi[0]=SPDR;
char scr[20];


data_spi[num_data_spi]=SPDR;
num_data_spi++;
if (num_data_spi==2)
{
new_data_spi=1;
num_data_spi=0;
}
if (master_micro==0)
{
            if (new_data_spi==1)
       {
       sprintf(scr,"\r\n ADC0=%d apdated!! \r\n",((data_spi[0]&0x00ff)|(data_spi[1]<<8)));
        puts(scr);
       new_data_spi=0;
       }
 }
}