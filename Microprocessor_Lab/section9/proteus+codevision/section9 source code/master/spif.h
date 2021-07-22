#ifndef _spif_INCLUDED_
#define _spif_INCLUDED_


extern  int data_spi[2];
extern bit new_data_spi;
extern char num_data_spi;
 
 
void spi_init(void);
void spi_init_slave(void);

interrupt [SPI_STC] void spi_isr(void);

#endif

